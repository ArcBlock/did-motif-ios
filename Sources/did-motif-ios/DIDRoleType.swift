//
//  File.swift
//  
//
//  Created by zY on 2022/3/16.
//

import Foundation

public enum RoleType: Int8 {
    case account = 0
    case node = 1
    case device = 2
    case application = 3
    case smartContract = 4
    case bot = 5
    case asset = 6
    case stake = 7
    case validator = 8
    case group = 9
    case tx = 10
    case tether = 11
    case swap = 12
    case delegate = 13
    case vc = 14
    case blocklet = 15
    case registry = 16
    case token = 17
    case any = 63    
}
