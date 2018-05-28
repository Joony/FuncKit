import Foundation
import CoreData
import UIKit

enum CoreDataError: Error {
    case modelNotFound(String)
    case cannotAddPersistentStoreToCoordinator
    case unableToSaveContexts(Error)
    case unableToPerformFetch(Error)
}

protocol ManagedObjectContext {
    var main: NSManagedObjectContext { get }
    var `private`: NSManagedObjectContext { get }
}

extension ManagedObjectContext {
    func save<T>(_ t: T) -> Future<T> {
        return .async { promise in
            self.`private`.performAndWait {
                do {
                    try self.`private`.save()
                } catch let error {
                    promise.reject(error: CoreDataError.unableToSaveContexts(error))
                    return
                }
                self.main.performAndWait {
                    do {
                        try self.main.save()
                        promise.resolve(value: t)
                    } catch let error {
                        promise.reject(error: CoreDataError.unableToSaveContexts(error))
                        return
                    }
                }
            }
        }
    }
}

extension ManagedObjectContext {
    func resultsController<T: NSManagedObject>(sectionNameKeyPath: String? = nil, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate? = nil) -> Result<NSFetchedResultsController<T>> {
        return Self.entityName(forType: T.self, inModel: self.main.persistentStoreCoordinator!.managedObjectModel) |>
            NSFetchRequest<T>.init(entityName:) >>>
            { return predicate == nil ? Either.left($0) : Either.right($0) } >>> identity ||| { Self.add(predicate: predicate!, toFetchRequest: $0) } >>>
            papply(sortDescriptors, f: Self.add(sortDescriptors:toFetchRequest:)) >>>
            papplyr(self.main, sectionNameKeyPath, nil, f: NSFetchedResultsController.init(fetchRequest:managedObjectContext:sectionNameKeyPath:cacheName:)) >>>
            Self.perform(fetchedResultsController:)
    }
    
    private static func entityName<T: NSManagedObject>(forType type: T.Type, inModel model: NSManagedObjectModel) -> String {
            let typeName = String(describing: type)
            guard let entityName = model.entities.filter({ $0.name == typeName }).first?.name else {
                fatalError("Entity (\(typeName)) not found.  Valid entity names: \(model.entities.compactMap({ $0.name }))")
            }
            return entityName
    }
    
    private static func add<T: NSManagedObject>(predicate: NSPredicate, toFetchRequest fetchRequest: NSFetchRequest<T>) -> NSFetchRequest<T> {
        fetchRequest.predicate = predicate
        return fetchRequest
    }
    
    private static func add<T: NSManagedObject>(sortDescriptors: [NSSortDescriptor], toFetchRequest fetchRequest: NSFetchRequest<T>) -> NSFetchRequest<T> {
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    private static func perform<T: NSManagedObject>(fetchedResultsController: NSFetchedResultsController<T>) -> Result<NSFetchedResultsController<T>> {
        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            return .failure(CoreDataError.unableToPerformFetch(error))
        }
        return .success(fetchedResultsController)
    }
}

struct CoreData {
    struct MOContext: ManagedObjectContext {
        let main: NSManagedObjectContext
        let `private`: NSManagedObjectContext
        
        // Initialise an in-memory MOContext with an momd name.
        init(name: String) {
            let f = (name, .main) |>
                CoreData.createManagedObjectModel(momdName:bundle:) >=>
                CoreData.createInMemoryStoreCoordinator(model:) >=>
                lift(toResult: CoreData.createManagedObjectContext(persistentStoreCoordinator:)) >=>
                lift(toResult: split) >=>
                lift(toResult: second(CoreData.addChildManagedObjectContext(parentContext:)))
            switch f {
            case let .success(main, `private`):
                self.main = main
                self.`private` = `private`
            case let .failure(error):
                fatalError("Unable to initialise Core Data: \(error)")
            }
        }
    }
}

// NMManagedObjectContext
extension CoreData {
    fileprivate static func createManagedObjectModel(momdName: String, bundle: Bundle = .main) -> Result<NSManagedObjectModel> {
        guard let modelURL = bundle.url(forResource: momdName, withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: modelURL) else {
                return .failure(CoreDataError.modelNotFound(momdName))
        }
        return .success(model)
    }
    
    fileprivate static func createInMemoryStoreCoordinator(model: NSManagedObjectModel) -> Result<NSPersistentStoreCoordinator> {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        do {
            try coordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil)
        } catch {
            return .failure(CoreDataError.cannotAddPersistentStoreToCoordinator)
        }
        return .success(coordinator)
    }
    
    fileprivate static func createManagedObjectContext(persistentStoreCoordinator: NSPersistentStoreCoordinator) -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext.name = ":MainContext"
        return managedObjectContext
    }
    
    fileprivate static func addChildManagedObjectContext(parentContext: NSManagedObjectContext) -> NSManagedObjectContext {
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        privateMOC.parent = parentContext
        privateMOC.name = ":UpdateContext"
        return privateMOC
    }
}

// FetchedResults Updates
protocol FetchedResultsControllerDelegate: class {
    func controllerWillUpdate()
    func controller(didUpdate update: CoreData.FetchedResultsController.Update)
    func controllerDidUpdate()
}

extension CoreData {
    class FetchedResultsController: NSObject, NSFetchedResultsControllerDelegate {
        weak var delegate: FetchedResultsControllerDelegate?
        private var updates: Update?
        let collectionView: UICollectionView
        
        init(collectionView: UICollectionView) {
            self.collectionView = collectionView
            super.init()
        }
        
        struct Update {
            var sections = SectionUpdate()
            var rows = RowUpdate()
        }
        
        struct SectionUpdate {
            var insert = IndexSet()
            var delete = IndexSet()
            var update = IndexSet()
        }
        
        struct RowUpdate {
            var move = Set<Move>()
            var insert = Set<IndexPath>()
            var delete = Set<IndexPath>()
            var update = Set<IndexPath>()
        }
        
        struct Move: Equatable, Hashable {
            let from: IndexPath
            let to: IndexPath
            
            var hashValue: Int {
                return "\(self.from.hashValue), \(self.to.hashValue)".hashValue
            }
        }
        
        func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            self.updates = Update()
            self.delegate?.controllerWillUpdate()
        }
        
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
            switch type {
            case .move:
                return
            case .insert:
                self.updates!.sections.insert.insert(sectionIndex)
            case .delete:
                self.updates!.sections.delete.insert(sectionIndex)
            case .update:
                self.updates!.sections.update.insert(sectionIndex)
            }
        }
        
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            guard type.rawValue != 0 else {
                // This is a bug with NSFetchedResultsController.  A NSFetchedResultsChangeType with a rawValue of 0 is invalid.
                return
            }
            switch type {
            case .move:
                guard indexPath != newIndexPath else {
                    return
                }
                self.updates!.rows.move.insert(Move(from: indexPath!, to: newIndexPath!))
                // Ensure that the row that is moving is also updated.
                self.updates!.rows.update.insert(newIndexPath!)
            case .insert:
                // Don't bother inserting a row if the entire section in being inserted.
                if !self.updates!.sections.insert.contains(newIndexPath!.section) {
                    self.updates!.rows.insert.insert(newIndexPath!)
                }
            case .delete:
                // Don't bother deleting a row if the entire section in being deleted.
                if !self.updates!.sections.delete.contains(indexPath!.section) {
                    self.updates!.rows.delete.insert(indexPath!)
                }
            case .update:
                self.updates!.rows.update.insert(indexPath!)
            }
        }
        
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            let update = self.updates!
            self.updates = nil
            self.collectionView.performBatchUpdates({
                self.collectionView.insertSections(update.sections.insert)
                self.collectionView.deleteSections(update.sections.delete)
                self.collectionView.reloadSections(update.sections.update)
                self.collectionView.insertItems(at: Array(update.rows.insert))
                self.collectionView.deleteItems(at: Array(update.rows.delete))
                // XXX calling reloadItems(at:) causes the collection view to lose it's current selection.
//                self.collectionView.reloadItems(at: Array(update.rows.update))
                update.rows.move.forEach { self.collectionView.moveItem(at: $0.from, to: $0.to) }
            }, completion: { [weak self] completed in
                self?.delegate?.controller(didUpdate: update)
                self?.delegate?.controllerDidUpdate()
            })
        }
    }
}

// Decode JSON to NSManagedObjects
extension CoreData {
    public static func decode<T>(type: T.Type, intoContext context: CoreData.MOContext, from data: Data) -> Future<T> where T: Decodable {
        let promise = Promise<T>()
        //        print(String(data: try! JSONSerialization.data(withJSONObject: JSONREST.transformDataToJSONDictionary(data: data).successValue!, options: .prettyPrinted), encoding: .utf8)!)
        context.`private`.perform {
            let decoder = JSONDecoder()
            decoder.userInfo[.context] = context.`private`
            do {
                let dto = try decoder.decode(type, from: data)
                promise.resolve(value: dto)
            } catch let error {
                promise.reject(error: REST.RESTError.error(error))
            }
        }
        return promise
    }
}

func ==(lhs: CoreData.FetchedResultsController.Move, rhs: CoreData.FetchedResultsController.Move) -> Bool {
    return (lhs.from == rhs.from) && (lhs.to == rhs.to)
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}


