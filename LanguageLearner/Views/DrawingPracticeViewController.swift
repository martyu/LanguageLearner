//
//  DrawingPracticeViewController.swift
//  LanguageLearner
//
//  Created by Marty Ulrich on 7/12/18.
//  Copyright © 2018 marty. All rights reserved.
//

import UIKit
import Foundation
import FLAnimatedImage
import PureLayout

protocol DrawingPracticeViewControllerDelegate {
	func next()
}

let leeway: CGFloat = 40.0

class DrawingPracticeViewController: UIViewController, DrawingViewDelegate {
	//MARK: - Record mode
	private var characterEnumerator = CharacterSet.hiraganaVowels.makeIterator()
	//MARK: -
	
	let strokeManager: StrokeManager
	var delegate: DrawingPracticeViewControllerDelegate?
	var characterInfo: CharacterInfo
	let nextButton = UIButton()//TODO: Move this to flow controller
	var gifView = FLAnimatedImageView()
	let drawingView = DrawingView()
	
	init(characterInfo: CharacterInfo) {
		self.characterInfo = characterInfo
		strokeManager = StrokeManager(strokes: characterInfo.strokes, leeway: leeway)
		super.init(nibName: nil, bundle: nil)
		drawingView.delegate = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
		
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		
		view.addSubview(gifView)

		gifView.autoCenterInSuperview()
		NSLayoutConstraint.autoSetPriority(.defaultLow) {
			gifView.autoPinEdge(toSuperviewMargin: .left, relation: .lessThanOrEqual)
			gifView.autoPinEdge(toSuperviewMargin: .right, relation: .greaterThanOrEqual)
			gifView.autoPinEdge(toSuperviewMargin: .top, relation: .lessThanOrEqual)
			gifView.autoPinEdge(toSuperviewMargin: .bottom, relation: .greaterThanOrEqual)
		}
		gifView.contentMode = .center
		do {
			try gifView.load(characterInfo.character)
		} catch {
			print(error)
		}
		
		view.addSubview(drawingView)
		drawingView.autoPinEdges(to: gifView)
		characterInfo.strokes.forEach { drawingView.drawPath($0) }
	}
	
	private func reset() {
		drawingView.reset()
		strokeManager.reset()
	}
	
	@objc func nextCharacter() {
//		if RECORD_MODE { characterInfos.append(gifView.characterInfo) }
//
//		if let nextChar = characterEnumerator.next() {
//
//		gifView.characterInfo =
//		} else {
//			do {
//				let characterInfoString = try String(data: JSONEncoder().encode(characterInfos), encoding: .utf8)
//				try characterInfoString?.write(toFile: characterInfoFilename, atomically: true, encoding: .utf8)
//			} catch {
//				NSLog("Error writing to file")
//			}
//		}
//
//		if let nextCharacterInfo = characterInfosIterator?.next() {
//			gifView.characterInfo = nextCharacterInfo
//
//		}
		
		delegate?.next()
	}
	
	private func completed() {
		print("\(characterInfo.character) complete!")
	}
	
	//MARK: - DrawingViewDelegate
	func touchesBegan(at point: CGPoint) {
		do {
			drawingView.shouldDrawTouches = try strokeManager.beginCurrentStroke(at: point)
		} catch {
			print(error)
			reset()
			return
		}
	}
	
	func touchesMoved(at point: CGPoint) {
		strokeManager.erasePointsFromCurrentStroke(around: point)
	}
	
	func touchesEnded(at point: CGPoint) {
		do {
			let hasMoreStrokes = try strokeManager.endCurrentStroke(at: point)
			if hasMoreStrokes == false {
				completed()
			}
		} catch {
			print(error)
			reset()
			return
		}
	}
	//MARK: -
}



