//
//  AutoLayoutExtensions.swift
//  LanguageLearner
//
//  Created by Marty Ulrich on 7/26/18.
//  Copyright © 2018 marty. All rights reserved.
//

import Foundation
import PureLayout

extension UIView {
	func autoPinEdges(to otherView: UIView) {
		autoPinEdge(.left, to: .left, of: otherView, withOffset: 0)
		autoPinEdge(.right, to: .right, of: otherView, withOffset: 0)
		autoPinEdge(.bottom, to: .bottom, of: otherView, withOffset: 0)
		autoPinEdge(.top, to: .top, of: otherView, withOffset: 0)
	}
}
