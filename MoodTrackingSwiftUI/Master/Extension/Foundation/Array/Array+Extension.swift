//
//  Array+Diff.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation

struct DiffItem<T> {

    let index: Int
    let element: T
}

struct Diff<T> {

    let insertions: [DiffItem<T>]
    let deletions: [DiffItem<T>]

    var hasAnyUpdates: Bool {
        return !insertions.isEmpty || !deletions.isEmpty
    }

    var hasAnyInsertions: Bool {
        return !insertions.isEmpty
    }

    var hasAnyDeletions: Bool {
        return !deletions.isEmpty
    }
}

extension Array where Element: Hashable {

    /// This will return the array of difference from the two array.
    ///
    /// EXAMPLE:-
    ///     let arrFirst = ["A","B"]
    ///     let arrSecond = ["A","B","C"]
    ///     let arrdiff = arrFirst.difference(from: arrSecond) => ["C"]
    func difference(from other: [Element]) -> [Element] {

        let thisSet = Set(self)
        let otherSet = Set(other)
        
        return Array(thisSet.symmetricDifference(otherSet))
    }

    /// This will return the instance of the Diff and by using this instance we can get the status of the arrays.
    /// This will give access to check the hasAnyUpdates, hasAnyInsertions, hasAnyDeletions status.
    ///
    /// EXAMPLE:-
    ///     let arrFirst = ["A","B"]
    ///     let arrSecond = ["A","B","C"]
    ///     let diff = arrFirst.diff(from: arrSecond)
    ///          - diff.hasAnyUpdates => If any updates(Insertions/Deletions) happens in arrays.
    ///          - diff.hasAnyInsertions => If any element insert in the array.
    ///          - diff.hasAnyDeletions => If any element deleted from the array.
    ///
    func diff(from others: [Element]) -> Diff<Element> {

        guard !difference(from: others).isEmpty else {
            return Diff(insertions: [], deletions: [])
        }

        let inserts = others.filter({ !self.contains($0) })
        let insertIndexes = inserts.compactMap({ others.firstIndex(of: $0) })
        let insertions = zip(insertIndexes, inserts).compactMap({ DiffItem<Element>(index: $0, element: $1) })

        let deletes = self.filter({ !others.contains($0) })
        let deleteIndexes = deletes.compactMap({ self.firstIndex(of: $0) })
        let deletions = zip(deleteIndexes, deletes).compactMap({ DiffItem<Element>(index: $0, element: $1) })

        return Diff(insertions: insertions, deletions: deletions)
    }
}

extension Array where Element: Equatable {
    
    /// This will return the array of indexes of the element if the element exist multiple instance in the array.
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
    
    /// This will return the first index of the element.
    ///
    ///  This could be nil value also, while using this "index(of element:)" please use if let. If you are not using if let and if this returns nil and when you are trying to unwrapped this value then application will crash.
    func index(of element: Element) -> Int? {
        return self.firstIndex(where: {$0 == element})
    }
    
    /// This method will compare the object and will remove it from array.
    ///
    /// - Parameter
    ///     - element: An object which will be removed from the array.
    // NOTE: - The Element must refer the Equatable protocol.
    mutating func remove(_ element: Element) {
        
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
    
    /// This method will remove the all duplicate data from the array with the array return type.
    func removeDuplicates() -> [Element] {
        
        var result = [Element]()
        
        for value in self where !result.contains(value) {
            result.append(value)
        }
        
        return result
    }
}

extension Array {
    
    /// This will return the chunked array of array.
    ///
    /// - Parameter
    ///     - size: size of the each array.
    ///
    /// EXAMPLE:-
    ///     let arr = ["A","B","C"]
    ///     let arrChunked = arr.chunked(into: 2)
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
