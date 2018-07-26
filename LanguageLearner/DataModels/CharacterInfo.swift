//
//  CharacterInfo.swift
//  LanguageLearner
//
//  Created by Marty Ulrich on 7/19/18.
//  Copyright © 2018 marty. All rights reserved.
//

import Foundation
import CoreGraphics

extension Array where Element == CGPoint {
	init(startPoint: CGPoint) {
		self.init()
		append(startPoint)
	}
}

typealias Stroke = CharacterInfo.Stroke
struct CharacterInfo: Codable {
	typealias Stroke = [CGPoint]
	
	var strokes = [Stroke]()
	var character: String
	
	//MARK: Recording
	mutating func addPointToLastStroke(_ touchPoint: CGPoint) {
		if var currentStroke = strokes.popLast() {
			currentStroke.append(touchPoint)
			strokes.append(currentStroke)
		}
	}
	
	mutating func addNewStroke(at startPoint: CGPoint) {
		strokes.append(Stroke(startPoint: startPoint))
	}
	////
}

