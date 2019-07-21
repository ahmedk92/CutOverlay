//
//  CutOverlayView.swift
//  CutOverlay
//
//  Created by Ahmed Khalaf on 7/21/19.
//  Copyright © 2019 Ahmed Khalaf. All rights reserved.
//

import UIKit

class CutOverlayView: UIView {
    private lazy var smallView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        addSubview(view)
        return view
    }()
    
    private lazy var panGR: UIPanGestureRecognizer = {
        let gr = UIPanGestureRecognizer(target: self, action: #selector(smallViewPanned(_:)))
        return gr
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        smallView.addGestureRecognizer(panGR)
    }
    
    @objc private func refresh() {
        setNeedsDisplay()
    }
    
    @objc private func smallViewPanned(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        smallView.center = smallView.center.applying(CGAffineTransform(translationX: translation.x, y: translation.y))
        recognizer.setTranslation(.zero, in: self)
        
        setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var smallViewFrame = smallView.frame
        smallViewFrame.size = bounds.size.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))
        smallView.frame = smallViewFrame
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let holePath = CGMutablePath()
        
        holePath.addRect(smallView.frame)
        holePath.addRect(bounds)

        let holeLayer = CAShapeLayer()
        holeLayer.path = holePath
        holeLayer.fillRule = .evenOdd
        self.layer.mask = holeLayer
    }
}
