//
//  File.swift
//  DIDHashView
//
//  Created by zY on 2022/2/25.
//

import Foundation
import UIKit
import ArcBlockSDK

public class DIDMotifUtils {
    public static let backgroundColors = ["#E94E4E", "#E41115", "#E96B4E", "#E5502E", "#E98F4E", "#E57A2E", "#E98F4E", "#E5A82E", "#DACD5D", "#DAC825",
                                   "#BDD13D", "#C8E31C", "#AEE94E", "#7FD558", "#52CC19", "#4FC469", "#59DE9C", "#19CC73", "#5ED9D1", "#19CCC0",
                                   "#4ED7E9", "#19B7CC", "#45ACE8", "#1C97DE", "#4E68E9", "#2E4DE5", "#7F4EE9", "#682EE5", "#BE65E7", "#AF40E2",
                                   "#DF58C2", "#E94E8F"]
}
// MARK: - Shape Path
public extension DIDMotifUtils {
    // 默认参数，为防止崩溃，给个默认数据
    static let errorIndexs = (0, Array.init(repeating: 0, count: 8))
    
    /// 获取DID Motif的绘制坐标
    /// - Parameter did: did
    /// - Returns: (colorIndex, [cordinateIndex])
    static func getMotifIndexs(did: String) -> (Int, [Int]) {
        // base58 格式的 DID 解码为 binary DID string
        // 即 https://github.com/ArcBlock/ABT-DID-Protocol#create-did (step9 -> step8)
       let decoded = Data(multibaseEncoded: did.removeDIDPrefix())?.bytes.compactMap({ Int($0) }) ?? []
        
       guard decoded.count == 26 else {
           return errorIndexs
       }
               
        // 剔除前 2 个字节 (DID Type)，此时还剩 24 bytes，用来随机背景色和位置
        let striped = decoded.suffix(from: 2)
       
        // 对前 8 个 bytes 的每个 byte 求和，对 32 求模，结果为 colorIndex
       let colorIndex = striped.prefix(8).reduce(0, +) % 32
       
        // 后 16 bytes 均分 8 组后每组对 2 个 bytes 求和再对 64 取模 => positionIndexes
        let splitArrs = Array(striped.suffix(16)).split(intoChunksOf: 2)

       let positionIndexes = splitArrs.compactMap({ $0.reduce(0, +) })
                                       .compactMap({ $0 % 64 })
        return (colorIndex, positionIndexes)
    }
    
    /// 获取DID Motif的绘制信息
    /// - Parameter did: DID
    /// - Returns: (colorIndex, [cordinateIndex], DIDMotifShage)
    static func getMotifInfo(did: String) -> (Int, [Int], DIDMotifShage) {
        let (colorIndex, positionIndexs) = getMotifIndexs(did: did)
        let roleType = DidHelper.calculateTypesFromDid(did: did)?.roleType        
        
        var shape = DIDMotifShage.rectangle
        switch roleType {
        case .account:
            shape = .rectangle
        case .application:
            shape = .square
        case .asset:
            shape = .hexagon
        case .token:
            shape = .circle
        default:
            shape = .rectangle
        }
        
        return (colorIndex, positionIndexs, shape)
    }
        
    /// 根据 DID 获取 Motif的主色
    /// - Parameter did: DID
    /// - Returns: 颜色
    static func getDIDMotifColor(did: String) -> UIColor {
        let decoded = Data(multibaseEncoded: did.removeDIDPrefix())?.bytes.compactMap({ Int($0) }) ?? []
        let errDefaultColor = UIColor.white
         
        guard decoded.count == 26 else {
            return errDefaultColor
        }
                
         // 剔除前 2 个字节 (DID Type)，此时还剩 24 bytes，用来随机背景色和位置
         let striped = decoded.suffix(from: 2)
        
         // 对前 8 个 bytes 的每个 byte 求和，对 32 求模，结果为 colorIndex
        let colorIndex = striped.prefix(8).reduce(0, +) % 32
        
        guard let hexColorStr = Self.backgroundColors.objectAtIndexSafely(index: colorIndex) else {
            return errDefaultColor
        }
        
        return UIColor(hex: hexColorStr)
    }
    
    static func testCase() {
        print(getMotifIndexs(did: "zNKtCNqYWLYWYW3gWRA1vnRykfCBZYHZvzKr") == (4, [50, 9, 49, 9, 16, 46, 15, 18]))
        print(getMotifIndexs(did: "z1oQhZEQSsMeAPiTCBAH8cqZxF8YttyUPJp") == (24, [6, 16, 28, 45, 47, 61, 54, 61]))
        print(getMotifIndexs(did: "z1kHBYtqXxpUfUpsW2ug8q4PBeKDEPTsC4Y") == (19, [12, 21, 21, 39, 35, 10, 16, 16]))
        print(getMotifIndexs(did: "z1RbtVHc66zEErVZ1rFb35hkt2xNqDQQExk") == (31, [17, 11, 42, 54, 4, 34, 62, 27]))
        print(getMotifIndexs(did: "z1mAZQTnCioGA9jpXdXJgtMJwrzP5vwGqio") == (20, [42, 54, 20, 12, 31, 19, 49, 39]))
    }
}

// MARK: - Shape Path
public extension DIDMotifUtils {
    /// 根据当前frame的任一边长算出的居中path
    /// - Parameter side: 当前frame的长或宽（理论讲DIDMotifView的frame应该都是长宽相等的）
    /// - Returns: path
    static func hexagonPathWith(side: CGFloat) -> UIBezierPath {
        let sideLength = side/2 // 六边形边长
        let path = UIBezierPath()
        let utilAngle = Double.pi/3 // 60°
        
        let startPoint = CGPoint(x: sideLength, y: 0)
        
        let point1 = CGPoint(x: sideLength + sin(utilAngle)*sideLength, y: cos(utilAngle)*sideLength)
        
        let point2 = CGPoint(x: point1.x, y: point1.y + sideLength)
        
        let point3 = CGPoint(x: sideLength, y: sideLength*2)
        
        let point4 = CGPoint(x: sideLength - sin(utilAngle)*sideLength, y: point2.y)
        
        let point5 = CGPoint(x: point4.x, y: point4.y - sideLength)
        
        path.move(to: startPoint)
        path.addLine(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.addLine(to: point4)
        path.addLine(to: point5)
        path.addLine(to: startPoint)
        
        return path
    }

    /// 根据当前frame的任一边长算出的居中path
    /// - Parameter side: 当前frame的长或宽（理论讲DIDMotifView的frame应该都是长宽相等的）
    /// - Returns: path
    static func squarePathWith(side: CGFloat) -> UIBezierPath {
        return UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: side, height: side), cornerRadius: cornerRadiusWith(side: side))
    }
    
    /// 根据当前frame的任一边长算出的居中path
    /// - Parameter side: 当前frame的长或宽（理论讲DIDMotifView的frame应该都是长宽相等的）
    /// - Returns: path
    static func rectanglePathWith(side: CGFloat) -> UIBezierPath {
        let height = side*0.7
        let y = (side - height)/2
        return UIBezierPath.init(roundedRect: CGRect(x: 0, y: y, width: side, height: height), cornerRadius: cornerRadiusWith(side: side))
    }

    /// 根据当前frame的任一边长算出的居中path
    /// - Parameter side: 当前frame的长或宽（理论讲DIDMotifView的frame应该都是长宽相等的）
    /// - Returns: path
    static func circlePathWith(side: CGFloat) -> UIBezierPath {
        return UIBezierPath.init(roundedRect: CGRect(x: 0, y: 0, width: side, height: side), cornerRadius: side/2)
    }
    
    static func cornerRadiusWith(side: CGFloat) -> CGFloat {
        // 大于80时固定10 小于20时固定1.5
        return side > 80 ? 10 : (side <= 20 ? 1.5 : floor(0.1*side + 2))
    }

}
