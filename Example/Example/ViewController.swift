//
//  ViewController.swift
//  Example
//
//  Created by zY on 2022/3/21.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var motifView1: DIDMotifView = {
        let view = DIDMotifView()
        return view
    }()
    
    private lazy var didLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var motifView2: DIDMotifView = {
        let view = DIDMotifView()
        return view
    }()

    private lazy var didLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var motifView3: DIDMotifView = {
        let view = DIDMotifView()
        return view
    }()

    private lazy var didLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var motifView4: DIDMotifView = {
        let view = DIDMotifView()
        return view
    }()

    private lazy var didLabel4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var changeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = UIColor.systemBlue
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.setTitle("Change", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(changeAction), for: .touchUpInside)
        btn.layer.cornerRadius = 24
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let offset: CGFloat = 30
        let itemHeight = (screenHeight - offset*5 - 160)/4
        let beginY: CGFloat = 60
        
        view.addSubview(motifView1)
        view.addSubview(motifView2)
        view.addSubview(motifView3)
        view.addSubview(motifView4)

        view.addSubview(didLabel1)
        view.addSubview(didLabel2)
        view.addSubview(didLabel3)
        view.addSubview(didLabel4)
        
        view.addSubview(changeBtn)
        
        let beginX = (screenWidth - itemHeight)/2
        
        motifView1.frame = CGRect(x: beginX,
                                       y: beginY,
                                       width: itemHeight,
                                       height: itemHeight)
        
        motifView2.frame = CGRect(x: beginX,
                                  y: motifView1.frame.maxY + offset,
                                       width: itemHeight,
                                       height: itemHeight)
        
        motifView3.frame = CGRect(x: beginX,
                                          y: motifView2.frame.maxY + offset,
                                          width: itemHeight,
                                          height: itemHeight)
        
        motifView4.frame = CGRect(x: beginX,
                                        y: motifView3.frame.maxY + offset,
                                        width: itemHeight,
                                        height: itemHeight)
        
        didLabel1.frame = CGRect(x: 0, y: motifView1.frame.maxY + 10, width: screenWidth, height: 20)
        didLabel2.frame = CGRect(x: 0, y: motifView2.frame.maxY + 10, width: screenWidth, height: 20)
        didLabel3.frame = CGRect(x: 0, y: motifView3.frame.maxY + 10, width: screenWidth, height: 20)
        didLabel4.frame = CGRect(x: 0, y: motifView4.frame.maxY + 10, width: screenWidth, height: 20)

        changeBtn.frame = CGRect(x: 60, y: motifView4.frame.maxY + 60, width: screenWidth - 120, height: 44)
        
        renderWithOriginShage()
    }
    
    private func renderWithSpecificShape() {
        motifView1.renderWith(address: "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3", shape: .square)
        didLabel1.text = "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3"

        motifView2.renderWith(address: "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3", shape: .circle)
        didLabel2.text = "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3"
        
        motifView3.renderWith(address: "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3", shape: .rectangle)
        didLabel3.text = "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3"
        
        motifView4.renderWith(address: "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3", shape: .hexagon)
        didLabel4.text = "zNKb2kbCvDHo9APDhD1trbAV1EVoYF6PcSJ3"
    }
    
    private func renderWithOriginShage() {
        // DApp
        motifView1.renderWith(address: "zNKeLKixvCM32TkVM1zmRDdAU3bvm3dTtAcM", shape: nil)
        didLabel1.text = "zNKeLKixvCM32TkVM1zmRDdAU3bvm3dTtAcM"

        // TOKEN: PLAY 3
        motifView2.renderWith(address: "z35n3kwEXMakjzfaf24DLd67dTJRByTf8y1FN", shape: nil)
        didLabel2.text = "z35n3kwEXMakjzfaf24DLd67dTJRByTf8y1FN"
        
        // Account
        motifView3.renderWith(address: "z1imdeFgjsR7n1PhBpyW7uu1zr617sCN64x", shape: nil)
        didLabel3.text = "z1imdeFgjsR7n1PhBpyW7uu1zr617sCN64x"
        
        // NFT
        motifView4.renderWith(address: "zjdov4taExQmjyFV4Jt5YPGF5yVUg57pPtQY", shape: nil)
        didLabel4.text = "zjdov4taExQmjyFV4Jt5YPGF5yVUg57pPtQY"
    }

}

extension ViewController {
    @objc func changeAction() {
        changeBtn.isSelected = !changeBtn.isSelected
        if changeBtn.isSelected {
            renderWithSpecificShape()
        } else {
            renderWithOriginShage()
        }
    }
}

