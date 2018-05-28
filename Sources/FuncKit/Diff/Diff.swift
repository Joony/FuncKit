//
//  Diff.swift
//  Work
//
//  Created by Jonathan McAllister on 19/02/2018.
//  Copyright © 2018 Jonathan McAlister. All rights reserved.
//

import Foundation

//public enum DiffStep<T> {
//    case insert(Int, T)
//    case delete(Int, T)
//}
//
//struct Diff {
//
//    public static func diff<T: Equatable>(_ lhs: [T], _ rhs: [T]) -> [DiffStep<T>] {
//        guard !lhs.isEmpty else {
//            return rhs.enumerated().map(DiffStep.insert)
//        }
//        guard !rhs.isEmpty else {
//            return lhs.enumerated().map(DiffStep.delete).reversed()
//        }
//
//        let table = MemoizedSequenceComparison.buildTable(lhs, rhs)
//
//    }
//
//    static func diffInternal<T: Equatable>(table: [[Int]], x: [T], y: [T], i: Int, j: Int, currentResults: ([DiffStep<T>], ))
//
//}
//
//fileprivate struct MemoizedSequenceComparison<T: Equatable> {
//    static func buildTable(_ x: [T], _ y: [T]) -> [[Int]] {
//        let n = x.count
//        let m = y.count
//        var table = Array(repeating: Array(repeating: 0, count: m + 1), count: n + 1)
//
//        table.withUnsafeMutableBufferPointer { unsafeTable in
//            x.withUnsafeBufferPointer { unsafeX in
//                y.withUnsafeBufferPointer { unsafeY in
//                    (0...n).forEach { i in
//                        (0...m).forEach { j in
//                            if unsafeX[i&-1] == unsafeY[j&-1] {
//                                unsafeTable[i][j] = unsafeTable[i&-1][j&-1] + 1
//                            } else {
//                                unsafeTable[i][j] = max(unsafeTable[i&-1][j], unsafeTable[i][j&-1])
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        return table
//    }
//
//    static func unsafeTable<T>(fromTable table: [T]) -> Future<UnsafeMutableBufferPointer<T>> {
//        return Promise { promise in
//            var table = table
//            table.withUnsafeMutableBufferPointer { unsafe in
//                promise.resolve(value: unsafe)
//            }
//        }
//    }
//}

