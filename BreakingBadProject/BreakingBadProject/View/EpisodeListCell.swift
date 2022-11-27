//
//  EpisodeListCell.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 25.11.2022.
//

import UIKit

final class EpisodeListCell: UITableViewCell {

    @IBOutlet private weak var seasonLabel: UILabel!
    @IBOutlet private weak var episodeLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    func configure(episode: EpisodeModel){
        seasonLabel.text = "Season: " + episode.season
        episodeLabel.text = "Episode: " + episode.episode
        titleLabel.text = episode.title
        dateLabel.text = episode.date
    }
    
}
