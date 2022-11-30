//
//  NotesVC.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 28.11.2022.
//

import UIKit

final class NotesVC: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var notesTableView: UITableView!{
        didSet{
            notesTableView.delegate = self
            notesTableView.dataSource = self
        }
    }
    
    //MARK: - Property
    var notes: [Notes] = [] {
        didSet{
            notesTableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        let frame = CGRect(x: notesTableView.frame.size.width / 2 - 10,
                           y: view.frame.height - 175, width: 56, height: 56)
        let newNoteView = AddNoteButtonView(frame: frame)
        newNoteView.delegate = self
        view.addSubview(newNoteView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotes()
    }
    
    //MARK: - Private Methods
    private func loadNotes(){
        CoreDataManager.shared.getNotes {[weak self] notes, error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.notes = notes
                return
            }
            self.showErrorAlert(message: error.message, completion: {})
        }
    }
    
    private func prepare(note: Notes? = nil, viewType: AddEditNoteViewType){
        guard let addEditVC = storyboard?.instantiateViewController(withIdentifier: "AddEditNoteVC_ID") as? AddEditNoteVC else { return }
        addEditVC.delegate = self
        addEditVC.viewType = viewType
        addEditVC.note = note
        present(addEditVC, animated: true)
    }
    
}
//MARK: - TableView Protocols
extension NotesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell") as? NotesListCell else { return UITableViewCell() }
        
        let note = notes[indexPath.row]
        cell.configure(note: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        prepare(note: note, viewType: .preview)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = notes[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") { _, _, _ in
            CoreDataManager.shared.deleteNote(note: note) { [weak self] error, success in
                guard let self = self else { return }
                guard let error = error else {
                    self.showSuccesAlert(message: success!.message) {}
                    return
                }
                self.showErrorAlert(message: error.message) {}
                self.loadNotes()
            }
        }
            
        let editAction = UIContextualAction(style: .normal, title: "EDİT", handler: { [weak self]_, view,_ in
            guard let self = self else { return }
            view.backgroundColor = .systemYellow
            self.prepare(note: note, viewType: .edit)
        })
        editAction.backgroundColor = .systemYellow
        
        
        return UISwipeActionsConfiguration(actions: [editAction,deleteAction])
    }
}

//MARK: - AddNoteButtonDelegate
extension NotesVC: AddNoteButtonDelegate {
    func presentAddEditNoteVC() {
        prepare(viewType: .save)
    }
}

//MARK: - AddEditNoteDelegate
extension NotesVC: AddEditNoteVCDelegate {
    func reloadNotes() {
        loadNotes()
    }
}
