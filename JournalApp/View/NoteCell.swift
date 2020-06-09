//
//  NoteCell.swift
//  JournalApp
//
//  Created by William Yeung on 6/8/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    // MARK: - Properties
    private let _titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TitleTitleTitleTitleTitle"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        //label.backgroundColor = .red
        return label
    }()
    
    private let _bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "BodyBodyBodyBodyBodyBodyBodyBodyBodyBodyBo"
        label.numberOfLines = 0
        //label.backgroundColor = .blue
        return label
    }()
    
    var titleLabel: UILabel {
        return self._titleLabel
    }
    
    var bodyLabel: UILabel {
        return self._bodyLabel
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let noteStack = UIStackView(arrangedSubviews: [_titleLabel, _bodyLabel])
        noteStack.axis = .vertical
        noteStack.distribution = .fillProportionally
        noteStack.spacing = 0
        noteStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(noteStack)
        noteStack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
