//
//  DataManager.swift
//  LanguageLearner
//
//  Created by Marty Ulrich on 7/19/18.
//  Copyright © 2018 marty. All rights reserved.
//

import Foundation

protocol DataManager {
	associatedtype DataType
	typealias CompletionHandler = (DataType?, Error?) -> ()
}
