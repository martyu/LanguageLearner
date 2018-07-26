//
//  StrokeManager.swift
//  LanguageLearner
//
//  Created by Marty Ulrich on 7/26/18.
//  Copyright © 2018 marty. All rights reserved.
//

import Foundation
import CoreGraphics

/// Manages the strokes for a character, and deleting points in those strokes.
class StrokeManager {
	enum StrokeManagerError: Error {
		case CurrentStrokeToDeleteNotEmpty
		case UserBeganAtWrongPoint
		case UserEndedAtWrongPoint
	}
	
	private var originalStrokes: [Stroke]
	private var strokesToDelete: [Stroke]
	private var currentStrokeIndex = 0
	private let leeway: CGFloat
	
	init(strokes: [Stroke], leeway: CGFloat) {
		self.leeway = leeway
		originalStrokes = strokes
		strokesToDelete = Array(strokes)
	}
	
	func reset() {
		strokesToDelete = Array(originalStrokes)
		currentStrokeIndex = 0
	}
	
	/// Remove points from the current stroke that are within `leeway` of the point.
	///
	/// - Parameter sourcePoint: The point around which to delete points.
	/// - Returns: A Bool indicating whether or not any points were removed.
	func erasePointsFromCurrentStroke(around sourcePoint: CGPoint) {
		strokesToDelete[currentStrokeIndex].filterPoints(closeTo: sourcePoint, leeway: leeway)
	}
	
	private var firstPointInCurrentOriginalStrokes: CGPoint? {
		return originalStrokes[currentStrokeIndex].first
	}
	
	private var firstPointInCurrentStrokesToDelete: CGPoint? {
		return originalStrokes[currentStrokeIndex].first
	}

	private var lastPointInCurrentOriginalStrokes: CGPoint? {
		return originalStrokes[currentStrokeIndex].last
	}
	
	private var lastPointInCurrentStrokesToDelete: CGPoint? {
		return originalStrokes[currentStrokeIndex].last
	}

	func beginCurrentStroke(at point: CGPoint) throws -> Bool {
		guard point.isCloseEnough(to: originalStrokes[currentStrokeIndex].first, leeway: leeway) else {
			throw StrokeManagerError.UserBeganAtWrongPoint
		}
		return true
	}

	func endCurrentStroke(at point: CGPoint) throws -> Bool {
		guard strokesToDelete[currentStrokeIndex].count == 0 else {
			reset()
			throw StrokeManagerError.CurrentStrokeToDeleteNotEmpty
		}
		
		guard point.isCloseEnough(to: originalStrokes[currentStrokeIndex].last, leeway: leeway) else {
			reset()
			throw StrokeManagerError.UserEndedAtWrongPoint
		}
		
		currentStrokeIndex += 1
		
		print("\nStroke \(currentStrokeIndex) complete!\n")
		
		return strokesToDelete.reduce(into: 0) { result, stroke in return result += stroke.count } > 0
	}
}
