//
//  File.swift
//  
//
//  Created by zY on 2022/3/16.
//

import Foundation

extension Array {
    public func split(intoChunksOf chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            let endIndex = ($0.advanced(by: chunkSize) > self.count) ? self.count - $0 : chunkSize
            return Array(self[$0..<$0.advanced(by: endIndex)])
        }
    }
    
    func objectAtIndexSafely(index: Int) -> Element? {
        if index >= self.count || index < 0 {
            return nil
        }
        return self[index]
    }
}
