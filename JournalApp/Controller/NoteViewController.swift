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
    private let titleInputField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let bodyInputField: UITextView = {
        let tv = UITextView()
        tv.text = "sdflkasldkfjalsdjf;asdjf;aksjdf;adjsfk;asjd;fakjsdkfa;sdkfja;skdfj;aksjdf;klajsf;kjas;dfja;sdkfj;asfaskjda;jkdskasjd;kasdfj;asdjf;ajsdf;jasd;ja;sdfj;asdj;klasdjfkjasd;asdfj;ksafjasd;kjd;jsad;fj;sdfj;dj;dsfjsdkjs;djf;asjdf;adsjsdf;sdj;sdjf;sdjf;sdjf;ajsdad;jas;djf;sdj;sdsdf;sd"
        return tv
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        anchorElements()
    }

    // MARK: - Helper
    func anchorElements() {
        let inputFieldStack = UIStackView(arrangedSubviews: [titleInputField, bodyInputField])
        inputFieldStack.axis = .vertical
        inputFieldStack.translatesAutoresizingMaskIntoConstraints = false
        inputFieldStack.spacing = 20
        
        let buttonStack = UIStackView(arrangedSubviews: [deleteButton, saveButton])
        buttonStack.spacing = 30
        buttonStack.distribution = .fill
        
        let combinedStack = UIStackView(arrangedSubviews: [inputFieldStack, buttonStack])
        combinedStack.axis = .vertical
        combinedStack.spacing = 20
        view.addSubview(combinedStack)
        combinedStack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 20, paddingBottom: 50, paddingRight: 20)
    }
}
