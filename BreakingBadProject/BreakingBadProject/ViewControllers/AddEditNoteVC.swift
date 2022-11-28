//
//  AddEditNoteVC.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 28.11.2022.
//

import UIKit

protocol AddEditNoteVCDelegate: AnyObject{
    func reloadNotes()
}


final class AddEditNoteVC: BaseViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var seasonTextField: UITextField!
    @IBOutlet private weak var episodeTextField: UITextField!
    @IBOutlet private weak var noteTextView: UITextView!
    @IBOutlet private weak var addButton: UIButton!
    
    //MARK: - Property
    weak var delegate: AddEditNoteVCDelegate?
    var note: Notes?
    var isEditable: Bool?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        //Configure ui as Empty
        super.viewDidLoad()
        if isEditable != nil {
            configureUIAsEmpty()
        }
        configureUI(note: note,isEditable: false)
    }
    
    //MARK: - Methods
    private func configureUI(note: Notes?,isEditable: Bool?){
        print("Configure ui as editable")
        guard let note else { return }
        print(note)
        addButton.removeFromSuperview()
        seasonTextField.text = note.season
        episodeTextField.text = note.episode
        noteTextView.text = note.text
        configureUIAsNotEditable(isEditable: isEditable)
    }
    
    private func configureUIAsNotEditable(isEditable: Bool?){
        guard isEditable == false else  { return }
        print("Configure ui as not editable")
        seasonTextField.isUserInteractionEnabled = false
        episodeTextField.isUserInteractionEnabled = false
        noteTextView.isUserInteractionEnabled = false
    }
    
    private func configureUIAsEmpty(){
        seasonTextField.text = ""
        episodeTextField.text = ""
        noteTextView.text = ""
    }
 
    @IBAction func addButtonClicked(_ sender: Any) {
        guard let text = noteTextView.text,
              let season = seasonTextField.text,
              let episode = episodeTextField.text else { return }
        
        guard let newNote = CoreDataManager.shared.saveNote(episode: episode, season: season, text: text) else { return }
        print(newNote)
        delegate?.reloadNotes()
        self.dismiss(animated: true)
    }
}
