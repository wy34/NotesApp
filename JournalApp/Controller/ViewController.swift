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
    private var notesModel = NotesModel()
    
    private let mainTableView: UITableView = {
        let tv = UITableView()
        tv.separatorInset.left = 0
        tv.register(NoteCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tv
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
        view.addSubview(mainTableView)
        mainTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}


// MARK: - UITableView delegate methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NoteCell
        cell.titleLabel.text = notes[indexPath.row].title
        //cell.bodyLabel.text = notes[indexPath.row].body
        return cell
    }
}

// MARK: - NotesModelProtocol methods
extension ViewController: NotesModelProtocol {
    func notesRetrieved(notes: [Note]) {
        self.notes = notes
        mainTableView.reloadData()
    }
}
