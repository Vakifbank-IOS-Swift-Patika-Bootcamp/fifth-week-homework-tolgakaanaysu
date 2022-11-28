//
//  QuoteModel.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 22.11.2022.
//

import Foundation

struct QuoteModel: Codable {
    let quoteID: Int
    let quote: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case quoteID = "quote_id"
        case author
        case quote
    }
}
