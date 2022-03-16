//
//  File.swift
//  
//
//  Created by zY on 2022/3/16.
//

import Foundation

extension String {
    func removeDIDPrefix() -> String {
        if self.hasPrefix("did:abt:") {
            var newDid = self
            newDid.removeFirst(8)
            return newDid
        }
        return self
    }
    
    
    func roleType() -> RoleType? {
        let didWithoutPrefix = self.removeDIDPrefix()
                
        var encodedDid = didWithoutPrefix
        
        if encodedDid.hasPrefix("0x") {
            encodedDid.removeFirst(2)
        }
        guard let encodedDidData = Data.init(base58Encoded: encodedDid) else {
            return nil
        }

        let didTypeBytes = Array(encodedDidData.bytes.prefix(2))
        guard didTypeBytes.count >= 2 else {
            return nil
        }
        let u16 = UInt16(didTypeBytes[0]) << 8 + UInt16(didTypeBytes[1])
        guard let roleType = RoleType.init(rawValue: Int8((u16 >> 10) & 0b00111111)) else {
                return nil
        }
        return roleType
    }
}
