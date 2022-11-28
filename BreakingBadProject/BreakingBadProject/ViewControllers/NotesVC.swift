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
        let size = notesTableView.frame.size
        let frame = CGRect(x: size.width / 2 - 10, y: size.height + 10, width: 56, height: 56)
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
        self.notes = CoreDataManager.shared.getNotes()
    }
    
}
//MARK: - TableView Protocols
extension NotesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell") as? NotesListCell
        else { return UITableViewCell() }
        let note = notes[indexPath.row]
        cell.configure(note: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let addEditVC = storyboard?.instantiateViewController(withIdentifier: "AddEditNoteVC_ID") as? AddEditNoteVC
        else { return  }
        let note = notes[indexPath.row]
        addEditVC.note = note
        addEditVC.isEditable = false
        addEditVC.delegate = self
        present(addEditVC, animated: true)
    }
}

//MARK: - AddNoteButtonDelegate
extension NotesVC: AddNoteButtonDelegate {
    func presentAddEditNoteVC() {
        guard let addEditVC = storyboard?.instantiateViewController(withIdentifier: "AddEditNoteVC_ID") as? AddEditNoteVC
        else { return  }
        addEditVC.delegate = self
        present(addEditVC, animated: true)
        
    }
}

//MARK: - AddEditNoteDelegate
extension NotesVC: AddEditNoteVCDelegate {
    func reloadNotes() {
        loadNotes()
    }
}
