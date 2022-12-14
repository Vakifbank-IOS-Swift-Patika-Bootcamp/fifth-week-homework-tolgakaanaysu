//
//  NotesListCell.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 28.11.2022.
//

import UIKit

final class NotesListCell: UITableViewCell {

    @IBOutlet private weak var seasonLabel: UILabel!
    @IBOutlet private weak var episodeLabel: UILabel!
    
    func configure(note: Notes){
        seasonLabel.text = "season: " + (note.season ?? "")
        episodeLabel.text = "episode: " + (note.episode ?? "")
    }
}
