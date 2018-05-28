import Foundation
import UIKit

struct Animate {
    static func spring(duration: TimeInterval = 0.3, animations: @escaping () -> Void) -> Future<Bool> {
        return .async(queue: .main) { promise in
//        return Promise(queue: .main) { promise in
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [.curveLinear], animations: animations) { completed in
                promise.resolve(value: completed)
            }
        }
    }
}
