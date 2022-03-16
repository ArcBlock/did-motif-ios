//
//  DIDHashView.swift
//  DIDHashView
//
//  Created by zY on 2022/2/24.
//

import UIKit
import CoreGraphics

public enum DIDMotifShage {
    case square
    case rectangle
    case circle
    case hexagon
}

/// 理论上讲这个view都是正方形，根据type去裁剪展示区域
public class DIDMotifView: UIView {
    // MARK: - Public Properties
    private var address: String?
    
    // 用户固定设置的shape
    // 若未设置，则shape默认为address解出来的
    private var shape: DIDMotifShage?
    
    // MARK: - Properties
    private lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    private var info: (Int, [Int], DIDMotifShage)?
    
    private var hexagonLayers: [CAShapeLayer] = []
    // MARK: - Init Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DIDMotifView deinit")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
}
// MARK: - UI Functions
extension DIDMotifView {
    private func commonInit() {
        layer.addSublayer(shapeLayer)
        for _ in 0...7 {
            let subLayer = CAShapeLayer()
            subLayer.isHidden = true
            subLayer.fillColor = UIColor(white: 1, alpha: 0.5).cgColor
            shapeLayer.addSublayer(subLayer)
            hexagonLayers.append(subLayer)
        }
    }
    
    private func setupUI() {
        guard let address = address else {
            return
        }
        if let colorIndex = info?.0,
           let hexStr = DIDMotifUtils.backgroundColors.objectAtIndexSafely(index: colorIndex) {
            shapeLayer.fillColor = UIColor(hex: hexStr).cgColor
        }

        clipToShape()
        layoutItems()
    }
    
    private func clipToShape() {
        guard let shape = info?.2 else {
            return
        }
        let side = self.frame.width
        switch shape {
        case .square:
            shapeLayer.path = DIDMotifUtils.squarePathWith(side: side).cgPath
        case .rectangle:
            shapeLayer.path = DIDMotifUtils.rectanglePathWith(side: side).cgPath
        case .circle:
            shapeLayer.path = DIDMotifUtils.circlePathWith(side: side).cgPath
        case .hexagon:
            shapeLayer.path = DIDMotifUtils.hexagonPathWith(side: side).cgPath
        }
        
        let mask = CAShapeLayer()
        mask.path = shapeLayer.path
        layer.mask = mask
    }
    
    private func layoutItems() {
        guard let address = address else {
            return
        }
        let gridWidth = min(self.frame.width/9, self.frame.height)
        
        let points = info?.1.map({ CGPoint(x: CGFloat($0/8 + 1)*gridWidth, y: CGFloat($0%8 + 1)*gridWidth) })
                
        let sideLength = self.frame.width*0.25
        let itemWidth = sideLength*2
        for (index, subLayer) in hexagonLayers.enumerated() {
            subLayer.isHidden = false
            subLayer.path = DIDMotifUtils.hexagonPathWith(side: itemWidth).cgPath
            subLayer.bounds = CGRect(x: 0, y: 0, width: itemWidth, height: itemWidth)
            subLayer.fillColor = UIColor(white: 1, alpha: 0.3).cgColor
            let point = points?.objectAtIndexSafely(index: index) ?? CGPoint.zero
            subLayer.position = point
            subLayer.add(animTo(point: point), forKey: "move")
        }
    }
    
    private func animTo(point: CGPoint) -> CASpringAnimation {
        let anim = CASpringAnimation(keyPath: "position")
        anim.repeatCount = 1
        anim.duration = 0.5
        anim.beginTime = CACurrentMediaTime()
        anim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        anim.fromValue = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        anim.toValue = point
        anim.damping = 6.5
        anim.stiffness = 80
        anim.initialVelocity = 4
        return anim
    }
}
// MARK: - Action Functions
extension DIDMotifView {
    private func decodeAddress() {
        guard let address = address else {
            return
        }
        info = DIDMotifUtils.getMotifInfo(did: address)
        if let shape = shape {
            info?.2 = shape
        }
        setupUI()
    }
}

// MARK: Public
extension DIDMotifView {
    func renderWith(address: String, shape: DIDMotifShage?) {
        self.address = address
        self.shape = shape
        
        decodeAddress()
    }
}
