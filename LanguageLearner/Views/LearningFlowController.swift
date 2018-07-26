//
//  LearningFlowController.swift
//  LanguageLearner
//
//  Created by Marty Ulrich on 7/26/18.
//  Copyright © 2018 marty. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class LearningFlowController: UIViewController {
	let navController = UINavigationController()
	var characterInfos: [CharacterInfo]?
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.view.backgroundColor = .white
		present(navController, animated: false)
		CharacterInfoDataManager().fetch { characterInfos, error in
			self.characterInfos = characterInfos
			if let characterInfo = characterInfos?.first {
				let drawingPracticeVC = DrawingPracticeViewController(characterInfo: characterInfo)
				navController.pushViewController(drawingPracticeVC, animated: false)
			}
		}
	}
}
