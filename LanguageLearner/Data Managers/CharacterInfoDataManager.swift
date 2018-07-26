//
//  CharacterInfoDataManager.swift
//  LanguageLearner
//
//  Created by Marty Ulrich on 7/19/18.
//  Copyright © 2018 marty. All rights reserved.
//

import Foundation
import FLAnimatedImage

class CharacterInfoDataManager: DataManager {
	typealias DataType = [CharacterInfo]
	let characterInfoFilename = "/Users/martyulrich/Desktop/character-info.txt"

	func fetch(_ completionHandler: CompletionHandler) {
		if let characterInfoString = try? String(contentsOfFile: characterInfoFilename),
			let characterInfoData = characterInfoString.data(using: .utf8),
			let characterInfos = try? JSONDecoder().decode([CharacterInfo].self, from: characterInfoData) {
			completionHandler(characterInfos, nil)
		}
		
//		let characterInfoString = try String(data: JSONEncoder().encode(characterInfos), encoding: .utf8)
//		try characterInfoString?.write(toFile: characterInfoFilename, atomically: true, encoding: .utf8)
	}
}

