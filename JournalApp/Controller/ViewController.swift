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
    
    private let mainTableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tv
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        anchorElements()
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}
