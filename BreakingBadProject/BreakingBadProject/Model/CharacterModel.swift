//
//  CharacterModel.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 22.11.2022.
//

import Foundation

struct CharacterModel: Codable {
    let characterID: Int
    let name: String
    let birthday: String
    let imageString: String
    let nickname: String
    let appearance: [Int]
    private enum CodingKeys: String, CodingKey {
        case name, birthday, nickname, appearance
        case characterID = "char_id"
        case imageString = "img"
    }
}




