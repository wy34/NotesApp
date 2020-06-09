//
//  NoteViewController.swift
//  JournalApp
//
//  Created by William Yeung on 6/8/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    // MARK: - Properties
    var note: Note?
    var notesModel: NotesModel?
    
    private let titleInputField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        tf.font = UIFont.boldSystemFont(ofSize: 17)
        return tf
    }()
    
    private let bodyInputField: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        return tv
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.addTarget(self, action: #selector(deleteNote), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2011116743, green: 0.582910955, blue: 0.8470978141, alpha: 1)
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.addTarget(self, action: #selector(starTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        anchorElements()
        
        if note != nil {
            titleInputField.text = note?.title
            bodyInputField.text = note?.body
            setStarButton()
        } else {
            let note = Note(docId: UUID().uuidString, title: titleInputField.text ?? "", body: bodyInputField.text ?? "", isStarred: false, createdAt: Date(), lastUpdated: Date())
            self.note = note
        }
    }
    
    // MARK: - Helper
    func anchorElements() {
        let inputFieldStack = UIStackView(arrangedSubviews: [titleInputField, bodyInputField])
        inputFieldStack.axis = .vertical
        inputFieldStack.translatesAutoresizingMaskIntoConstraints = false
        inputFieldStack.spacing = 20
        
        let buttonStack = UIStackView(arrangedSubviews: [deleteButton, saveButton, favoriteButton])
        buttonStack.spacing = 30
        buttonStack.distribution = .fill
        
        let combinedStack = UIStackView(arrangedSubviews: [inputFieldStack, buttonStack])
        combinedStack.axis = .vertical
        combinedStack.spacing = 20
        view.addSubview(combinedStack)
        combinedStack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 50, paddingRight: 20)
    }
    
    func setStarButton() {
        let imageName = note!.isStarred ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    // MARK: - Selectors
    @objc func deleteNote() {
        guard let note = note else { return }
        notesModel?.deleteNote(note)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveNote() {
        note?.title = titleInputField.text ?? ""
        note?.body = bodyInputField.text ?? ""
        note?.lastUpdated = Date()
        
        notesModel?.saveNote(self.note!)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func starTapped() {
        note?.isStarred.toggle()
        notesModel?.updateFavStatus(note!.docId, note!.isStarred)
        setStarButton()
    }
}
