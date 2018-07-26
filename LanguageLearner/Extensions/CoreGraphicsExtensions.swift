//
//  CoreGraphicsExtensions.swift
//  LanguageLearner
//
//  Created by Marty Ulrich on 7/26/18.
//  Copyright © 2018 marty. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGRect {
	init(center: CGPoint, edgeLength: CGFloat) {
		self.init(x: center.x - edgeLength/2.0,
				  y: center.y - edgeLength/2.0,
				  width: edgeLength,
				  height: edgeLength)
	}
}

extension CGPoint {
	func isCloseEnough(to point: CGPoint?, leeway: CGFloat) -> Bool {
		guard let point = point else { return false }
		return (point.y - y).magnitude < leeway && (point.x - x).magnitude < leeway
	}
}
