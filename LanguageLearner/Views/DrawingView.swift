//
//  DrawingView.swift
//  LanguageLearner
//
//  Created by Marty Ulrich on 7/20/18.
//  Copyright © 2018 marty. All rights reserved.
//

import Foundation
import UIKit

protocol DrawingViewDelegate {
	func touchesBegan(at point: CGPoint)
	func touchesMoved(at point: CGPoint)
	func touchesEnded(at point: CGPoint)
}

class DrawingView: UIImageView {
	var shouldDrawTouches = false
	private var lastPoint: CGPoint? = nil
	var delegate: DrawingViewDelegate?
	
	init() {
		super.init(image: nil)
		isUserInteractionEnabled = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func reset() {
		image = nil
		shouldDrawTouches = false
	}
	
	//MARK: - Touch handling
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touchPoint = touches.first?.location(in: self) else { return }
		
		delegate?.touchesBegan(at: touchPoint)
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touchPoint = touches.first?.location(in: self) else { return }
		
		delegate?.touchesMoved(at: touchPoint)

		if let lastPoint = lastPoint {
			drawLine(from: lastPoint, to: touchPoint)
		}
		
		lastPoint = touchPoint
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard
			let touchPoint = touches.first?.location(in: self),
			let lastPoint = lastPoint
		else { return }
		
		delegate?.touchesEnded(at: touchPoint)

		drawLine(from: lastPoint, to: touchPoint)
		self.lastPoint = nil
	}
	//MARK: - Drawing
	func drawPath(_ points: [CGPoint]) {
		guard points.count >= 2 else { return }

		for i in 1..<points.count {
			drawLine(from: points[i-1], to: points[i])
		}
	}
	
	private func drawLine(from pointA: CGPoint, to pointB: CGPoint) {
		guard shouldDrawTouches else { return }
		UIGraphicsBeginImageContext(frame.size)
		let context = UIGraphicsGetCurrentContext()
		image?.draw(in: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
		context?.move(to: pointA)
		context?.addLine(to: pointB)
		context?.setLineWidth(10)
		context?.setLineJoin(.round)
		context?.setStrokeColor(UIColor.black.cgColor)
		context?.setLineCap(.round)
		context?.strokePath()
		image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
	}
	//MARK: -
}

