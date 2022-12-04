//
//  AddEditNoteVC.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 28.11.2022.
//

import UIKit

//MARK: - Enum
enum AddEditNoteViewType {
    case save
    case edit
    case preview
}

//MARK: - Protocol
protocol AddEditNoteVCDelegate: AnyObject{
    func reloadNotes()
}

final class AddEditNoteVC: BaseViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var seasonTextField: UITextField!
    @IBOutlet private weak var episodeTextField: UITextField!
    @IBOutlet private weak var noteTextView: UITextView!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    
    //MARK: - Property
    weak var delegate: AddEditNoteVCDelegate?
    var note: Notes?
    var viewType: AddEditNoteViewType = .save
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    //MARK: - Private Methods
    private func configure(){
        switch viewType {
        case .save:
            configureAsSaveable()
        case .edit:
            configureAsEditable()
        case .preview:
            configureAsPreview()
        }
    }
    
    private func configureAsSaveable(){
        editButton.removeFromSuperview()
        titleLabel.text = "Save Note"
        seasonTextField.text = ""
        episodeTextField.text = ""
        noteTextView.text = ""
    }
    private func configureAsEditable(){
        setUIByNote()
        titleLabel.text = "Edit Note"
        
    }
    
    private func configureAsPreview(){
        setUIByNote()
        titleLabel.text = "Preview"
        editButton.removeFromSuperview()
        seasonTextField.isUserInteractionEnabled = false
        episodeTextField.isUserInteractionEnabled = false
        noteTextView.isUserInteractionEnabled = false
    }
    
    private func setUIByNote(){
        guard let note  = self.note else { return }
        addButton.removeFromSuperview()
        seasonTextField.text = note.season
        episodeTextField.text = note.episode
        noteTextView.text = note.text
    }
    
    //MARK: - IBActions
    @IBAction func addButtonClicked(_ sender: Any) {
        guard let text = noteTextView.text,
              let season = seasonTextField.text,
              let episode = episodeTextField.text else { return }
        
        CoreDataManager.shared.saveNote(episode: episode, season: season, text: text) { [weak self]  success,error in
            guard let self = self else { return }
            
            guard let success = success else {
                self.showErrorAlert(message: error!.message, completion: {})
                return
            }
            self.dismiss(animated: true)
            self.delegate?.reloadNotes()
            
            self.showSuccesAlert(message: success.message, completion: {})
        }
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        guard let note = self.note,
              let text = noteTextView.text,
              let season = seasonTextField.text,
              let episode = episodeTextField.text else { return }
        
        note.text = text
        note.episode = episode
        note.season = season
        
        CoreDataManager.shared.updateNote(model: note) { [weak self] success, error in
            guard let self = self else { return}
            guard let success = success else {
                self.showErrorAlert(message: error!.message, completion: {})
                return
            }
            self.dismiss(animated: true)
            self.delegate?.reloadNotes()
            self.showSuccesAlert(message: success.message, completion: {})
                    
        }
    }
}
