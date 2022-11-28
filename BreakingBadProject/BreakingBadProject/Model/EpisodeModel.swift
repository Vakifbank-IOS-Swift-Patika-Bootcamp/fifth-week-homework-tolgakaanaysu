//
//  EpisodeModel.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 22.11.2022.
//

import Foundation

struct EpisodeModel: Codable {
    let episodeID: Int
    let episode: String
    let title: String
    let season: String
    let date: String
    let characters: [String]
    
    private enum CodingKeys: String, CodingKey {
        case episodeID = "episode_id"
        case episode
        case title
        case season
        case date = "air_date"
        case characters
    }
    
}
