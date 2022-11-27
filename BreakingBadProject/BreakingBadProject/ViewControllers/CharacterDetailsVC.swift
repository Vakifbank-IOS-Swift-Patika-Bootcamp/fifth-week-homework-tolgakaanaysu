//
//  CharacterDetailsVC.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 24.11.2022.
//

import UIKit
import Kingfisher

final class CharacterDetailsVC: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var birthdayLabel: UILabel!
    @IBOutlet private weak var episodesLabel: UILabel!
    @IBOutlet private weak var nicknameLabel: UILabel!
    
    //MARK: Properties
    private var character: CharacterModel?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageViewAttributes()
        configure()
    }
    
    //MARK: - IBActions
    @IBAction func quotesButtonClicked(_ sender: Any) {
        guard let character,
              let quotesVC = storyboard?.instantiateViewController(withIdentifier: "QuotesVC_ID") as? QuotesVC else { return }
        quotesVC.initName(character.name)
        present(quotesVC, animated: true)
    }
    
    func initCharacter(_ character: CharacterModel){
        self.character = character
    }
    
    //MARK: - Private methods
    private func configure(){
        guard let character else { return }
        imageView.kf.setImage(with: URL(string: character.imageString),
        placeholder: UIImage(systemName: "placeholder"))
        nameLabel.text = character.name
        nicknameLabel.text = character.nickname
        birthdayLabel.text = character.birthday
        episodesLabel.text = "Seasons: " + character.appearance.convertString()
    }
   
    private func setImageViewAttributes(){
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
}

extension Array where Element == Int {
    func convertString() -> String{
        let strArr = self.map({String($0)})
        return strArr.joined(separator: ", ")
    }
}
