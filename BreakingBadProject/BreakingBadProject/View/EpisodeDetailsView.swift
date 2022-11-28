//
//  EpisodeDetailsView.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 25.11.2022.
//

import UIKit




final class EpisodeDetailsView: UIView {

    //MARK: - IBOutlet
    @IBOutlet private weak var charactersTextView: UITextView!
    
    //MARK: - Property
    weak var delegate: EpisodeVCDelegate?
    
    //MARK: - initilize
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit() {
        let nib = UINib(nibName: "EpisodeDetailsView", bundle: nil)
        if let view = nib.instantiate(withOwner: self).first as? UIView {
            view.backgroundColor = .white
            view.layer.cornerRadius = 10
            view.layer.borderColor = UIColor.systemGray3.cgColor
            view.layer.borderWidth = 1
            addSubview(view)
            view.frame = self.bounds
        }
    }

    //MARK: - IBActions
    @IBAction func closeButtonClicked(_ sender: Any) {
        delegate?.setTableViewAlpha()
        removeFromSuperview()
    }
    
    //MARK: - methods
    
    func configure(episode: EpisodeModel ) {
//        titleLabel.text = episode.title
//        episodeLabel.text = "Episode: " + episode.episode
//        seasonLabel.text = "Season: " + episode.season
//        dateLabel.text = episode.date
        charactersTextView.text = episode.characters.joined(separator: " \n ")
    }
}




