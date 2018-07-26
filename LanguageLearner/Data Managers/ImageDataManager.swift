//
//  ImageDataManager.swift
//  LanguageLearner
//
//  Created by Marty Ulrich on 7/19/18.
//  Copyright © 2018 marty. All rights reserved.
//

import Foundation
import FLAnimatedImage


extension FLAnimatedImageView {
	enum ImageLoadError: Error {
		case characterStringNot1Long
	}

	func load(_ character: String) throws {
		guard character.count == 1, let character = character.first else { throw ImageLoadError.characterStringNot1Long }
		let files = try FileManager.default.contentsOfDirectory(atPath: Bundle.main.bundlePath)
		if let file = files.first(where: { $0.contains(character) }) {
			let data = try Data(contentsOf: URL(fileReferenceLiteralResourceName: file))
			loopCompletionBlock = { [weak self] int in
				self?.stopAnimating()
			}
			animatedImage = FLAnimatedImage(animatedGIFData: data)
		}
	}
}
