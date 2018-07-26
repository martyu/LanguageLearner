//
//  SwiftExtensions.swift
//  LanguageLearner
//
//  Created by Marty Ulrich on 7/26/18.
//  Copyright © 2018 marty. All rights reserved.
//

import Foundation
import CoreGraphics

extension Array where Element == CGPoint {
	mutating func filterPoints(closeTo point: CGPoint, leeway: CGFloat) {
		self = filter { return point.isCloseEnough(to: $0, leeway: leeway) }
	}
}
