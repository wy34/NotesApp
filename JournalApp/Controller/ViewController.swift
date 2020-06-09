//
//  ViewController.swift
//  JournalApp
//
//  Created by William Yeung on 6/8/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MainTableViewCell"

class ViewController: UIViewController {
    // MARK: - Properties
    private var notes = [Note]()
    private var favoriteNotes = [Note]()
    private var showFavorites = false
    private var notesModel = NotesModel()
    
    private let mainTableView: UITableView = {
        let tv = UITableView()
        tv.separatorInset.left = 0
        tv.register(NoteCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tv
    }()
    
    private lazy var filterFavoritesButton: UIBarButtonItem = {
        let bbItem = UIBarButtonItem()
        bbItem.image = UIImage(systemName: "star")
        bbItem.style = .plain
        bbItem.target = self
        bbItem.action = #selector(starClicked)
        return bbItem
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        notesModel.delegate = self
        anchorElements()
        notesModel.getNotes()
    }

    // MARK: - Helper
    func anchorElements() {
        navigationItem.leftBarButtonItem = filterFavoritesButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        view.addSubview(mainTableView)
        mainTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func filterFavorites() {
        if showFavorites {
            favoriteNotes = notes.filter { (note) -> Bool in
                note.isStarred == true
            }
        }
    }
    // MARK: - Selector
    @objc func addNote() {
        let vcToGoTo = NoteViewController()
        vcToGoTo.notesModel = self.notesModel
        present(vcToGoTo, animated: true)
    }
    
    @objc func starClicked() {
        showFavorites.toggle()
        
        filterFavoritesButton.image = showFavorites ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        filterFavorites()

        mainTableView.reloadData()
    }
}


// MARK: - UITableView delegate methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showFavorites ? favoriteNotes.count : notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NoteCell
        cell.titleLabel.text = showFavorites ? favoriteNotes[indexPath.row].title : notes[indexPath.row].title
        cell.bodyLabel.text = showFavorites ? favoriteNotes[indexPath.row].body : notes[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcToGoTo = NoteViewController()
        vcToGoTo.note = showFavorites ? favoriteNotes[indexPath.row] : notes[indexPath.row]
        vcToGoTo.notesModel = self.notesModel
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: false)
        present(vcToGoTo, animated: true)
    }
}

// MARK: - NotesModelProtocol methods
extension ViewController: NotesModelProtocol {
    func notesRetrieved(notes: [Note]) {
        self.notes = notes
        filterFavorites()
        mainTableView.reloadData()
    }
}
