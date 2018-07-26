////
////  CharacterDrawView.swift
////  LanguageLearner
////
////  Created by Marty Ulrich on 7/18/18.
////  Copyright © 2018 marty. All rights reserved.
////
//
//import Foundation
//import UIKit
//import PureLayout
//import FLAnimatedImage
//import CoreGraphics
//
//let RECORD_MODE = false
//
//
//class CharacterDrawView: UIView {
//	private let animatedImgView = FLAnimatedImageView()
//	private let drawingView = DrawingView(delegate: self)//TODO: This shouldn't be managed by this class
//	private let recordedPathImgView = UIImageView(image: UIImage())
//
//	var characterInfo = CharacterInfo() {
//		didSet {
//			reset()
//			guard let character = characterInfo.character else { return }
//			
//			try? animatedImgView.load(character)
//
//			characterInfo.strokes.compactMap { $0.first }.forEach { drawSquare(at: $0, color: .green) }
//			characterInfo.strokes.compactMap { $0.last }.forEach { drawSquare(at: $0, color: .red) }
//			
//			DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) { [weak self] in
//				self?.characterInfo.strokes.forEach { self?.drawingView.drawPath($0) }
//			}
//		}
//	}
//	
//	init() {
//		super.init(frame: .zero)
//		
//		addSubview(animatedImgView)
//		animatedImgView.autoPinEdgesToSuperviewMargins()
//		animatedImgView.contentMode = .center
//		animatedImgView.isUserInteractionEnabled = true
//		
//		animatedImgView.addSubview(drawingView)
//		drawingView.autoPinEdgesToSuperviewEdges()
//		animatedImgView.isUserInteractionEnabled = true
//	}
//	
//	required init?(coder aDecoder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
//	
//	//MARK: - Touch handlers
//	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//		superview?.touchesBegan(touches, with: event)
//		
//		if strokesToErase == characterInfo.strokes {
//			reset()
//		}
//		
//		guard let touchPoint = touches.first?.location(in: self) else {
//			print("No touch point")
//			reset()
//			return
//		}
//		
//		guard let currentStrokeIndex = currentStrokeIndex else {
//			print("No current stroke index")
//			reset()
//			return
//		}
//		
//		guard let expectedFirstTouchPoint = characterInfo.strokes[currentStrokeIndex].first else {
//			print("No expected first touch point")
//			reset()
//			return
//		}
//		
//		guard touchPoint.isCloseEnough(to: expectedFirstTouchPoint) else {
//			print("Wrong first point for current stroke.")
//			reset()
//			return
//		}
//		
//		erasePointsFromCurrentStroke(around: touchPoint)
//	}
//	
//	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//		superview?.touchesMoved(touches, with: event)
//		guard let touchPoint = touches.first?.location(in: self) else { return }
//		
//		if erasePointsFromCurrentStroke(around: touchPoint) == false {
//			touches.first?.view?.isUserInteractionEnabled = false
//			touches.first?.view?.isUserInteractionEnabled = true
//		}
//	}
//	
//	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//		superview?.touchesMoved(touches, with: event)
//		guard let touchPoint = touches.first?.location(in: self) else {
//			print("No touch point")
//			reset()
//			return
//		}
//		
//		guard let currentStrokeIndex = currentStrokeIndex else {
//			print("No current stroke index")
//			reset()
//			return
//		}
//		
//		guard let expectedLastTouchPoint = characterInfo.strokes[currentStrokeIndex].last else {
//			print("No expected last touch point")
//			reset()
//			return
//		}
//		
//		guard touchPoint.isCloseEnough(to: expectedLastTouchPoint) else {
//			print("Wrong end point for current stroke.  Expected: \(expectedLastTouchPoint)\tActual: \(touchPoint)")
//			reset()
//			return
//		}
//
//		erasePointsFromCurrentStroke(around: touchPoint)
//		
//		if (strokesToErase?[currentStrokeIndex].isEmpty ?? false) == false {
//			print("User didn't erase all stroke points.")
//			reset()
//		}
//	}
//	//MARK: -
//	
//	func drawSquare(at center: CGPoint, color: UIColor) {
//		let square = UIView(frame: CGRect(center: center, edgeLength: leeway*2))
//		square.backgroundColor = color
//		square.alpha = 0.5
//		square.isUserInteractionEnabled = false
//		
//		addSubview(square)
//	}
//	
//	
//	private func reset() {
//		drawingView.image = nil
//		strokesToErase = Array(characterInfo.strokes)
//	}
//	
//	//MARK: - Recording
//	private func recordModeTouchesMovedOrEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//		guard
//			RECORD_MODE == true,
//			let touchPoint = touches.first?.location(in: self)
//		else { return }
//		
//		characterInfo.addPointToLastStroke(touchPoint)
//	}
//	
//	private func recordModeTouchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//		guard
//			RECORD_MODE == true,
//			let touchPoint = touches.first?.location(in: self)
//		else { return }
//		
//		characterInfo.addNewStroke(at: touchPoint)
//	}
//	//MARK: -
//}
//
//
//
