//
//  NotesModel.swift
//  JournalApp
//
//  Created by William Yeung on 6/8/20.
//  Copyright © 2020 William Yeung. All rights reserved.
//

import Foundation
import Firebase

protocol NotesModelProtocol {
    func notesRetrieved(notes: [Note])
}

class NotesModel {
    var delegate: NotesModelProtocol?
    var listenerRegistration: ListenerRegistration!
    
    deinit {
        // Unregister listener
        listenerRegistration?.remove()
    }
    
    func getNotes() {
        self.listenerRegistration = Firestore.firestore().collection("notes").addSnapshotListener({ (snap, error) in
            if error == nil && snap != nil {
                var notes = [Note]()

                for doc in snap!.documents {
                    let createdAtDate: Date = Timestamp.dateValue(doc["createdAt"] as! Timestamp)()
                    let lastUpdatedDate: Date = Timestamp.dateValue(doc["lastUpdatedAt"] as! Timestamp)()
                    
                    let note = Note(docId: doc["docId"] as! String, title: doc["title"] as! String, body: doc["body"] as! String, isStarred: doc["isStarred"] as! Bool, createdAt: createdAtDate, lastUpdated: lastUpdatedDate)
                    notes.append(note)
                }
                DispatchQueue.main.async {
                    self.delegate?.notesRetrieved(notes: notes)
                }
            }
        })
    }
    
    func deleteNote(_ n: Note) {
        Firestore.firestore().collection("notes").document(n.docId).delete()
    }
    
    func saveNote(_ n: Note) {
        Firestore.firestore().collection("notes").document(n.docId).setData(noteToDictionary(n))
    }
    
    func noteToDictionary(_ n: Note) -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary["docId"] = n.docId
        dictionary["title"] = n.title
        dictionary["body"] = n.body
        dictionary["createdAt"] = n.createdAt
        dictionary["lastUpdatedAt"] = n.lastUpdated
        dictionary["isStarred"] = n.isStarred
        return dictionary
    }
}
