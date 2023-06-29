//
//  GridView.swift
//  StickerCam
//
//  Created by Łukasz Kudzia on 26/06/2023.
//

import UIKit

class GridView: UIView {
    var color: CGColor = UIColor.white.cgColor {
        didSet {
            self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            self.setNeedsDisplay()
        }
    }

    init() {
        super.init(frame: .zero)
        isHidden = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        createGridOfSize(horizontal: 2, vertical: 2)
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return false
    }

    private func createGridOfSize(horizontal: Int, vertical: Int) {
        let distanceY = bounds.height / CGFloat(horizontal + 1)
        let distanceX = bounds.width / CGFloat(vertical + 1)

        let path = UIBezierPath()
        for index in 1...horizontal {
            path.move(to: CGPoint(x: .zero, y: distanceY * CGFloat(index)))
            path.addLine(to: CGPoint(x: bounds.width, y: distanceY * CGFloat(index)))
        }

        for index in 1...vertical {
            path.move(to: CGPoint(x: distanceX * CGFloat(index), y: .zero))
            path.addLine(to: CGPoint(x: distanceX * CGFloat(index), y: bounds.height))
        }
        let gridLayer = gridLayer()
        gridLayer.path = path.cgPath
        layer.addSublayer(gridLayer)
    }

    private func gridLayer() -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 1.2
        shapeLayer.strokeColor = color
        shapeLayer.frame = bounds
        shapeLayer.fillColor = nil
        return shapeLayer
    }
}
