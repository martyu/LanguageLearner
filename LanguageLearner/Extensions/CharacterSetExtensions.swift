//
//  CharacterSetExtensions.swift
//  LanguageLearner
//
//  Created by Marty Ulrich on 7/26/18.
//  Copyright © 2018 marty. All rights reserved.
//

import Foundation

extension CharacterSet {
	public static var hiragana: String {
		return "あいうえおかがきぎくぐけげこごさざしじすずせぜそぞただちぢつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをん"
	}
	
	public static var hiraganaBase: String {
		return "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわゐゑをん"
	}
	
	public static var hiraganaVowels: String {
		return "あいうえお"
	}
	
	//TODO: Finish into groups
}
