//
//  CharacterListCell.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 23.11.2022.
//

import UIKit

final class CharacterListCell: UICollectionViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var birthdayLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
   
    
    func configure(model characterModel: CharacterModel){
        nameLabel.text = characterModel.name
        birthdayLabel.text = characterModel.birthday
        usernameLabel.text = characterModel.nickname
        configureCell()
    }
    
    func configureCell(){
        layer.borderColor = UIColor.systemGreen.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
    }
}
