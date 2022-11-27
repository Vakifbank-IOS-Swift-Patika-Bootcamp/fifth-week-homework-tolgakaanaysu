//
//  ViewController.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 22.11.2022.
//

import UIKit

final class CharactersVC: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var characterCollectionView: UICollectionView!{
        didSet{
            characterCollectionView.dataSource = self
            characterCollectionView.delegate = self
        }
    }
    
    //MARK: Properties
    private var characterList: [CharacterModel] = [] {
        didSet{
            characterCollectionView.reloadData()
        }
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fetchData()
    }
    
    //MARK: Private methods
    private func fetchData(){
        indicator.startAnimating()
        NetworkClient.getAllCharacters { [weak self] response, error in
            guard let response = response,
                  let self = self else {
                //Alert
                
                return
            }
            self.characterList = response
            self.indicator.stopAnimating()
        }
    }
}

//MARK:  Collection View Setup
extension CharactersVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(characterList.count)
        return characterList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterListCell", for: indexPath) as? CharacterListCell
        else {
            print("hata 1")
            return UICollectionViewCell()
        }
        let characterModel = characterList[indexPath.row]
        cell.configure(model: characterModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailsVC = storyboard?.instantiateViewController(identifier: "CharacterDetailsVC_ID") as? CharacterDetailsVC else { return }
        let character = characterList[indexPath.row]
        detailsVC.initCharacter(character)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

