//
//  ViewModel.swift
//  NewRealmDemo
//
//  Created by Samuel on 7/17/24.
//

import Foundation
import RealmSwift

class ViewModel: ObservableObject {
    let realm = try! Realm()
    @Published var todoData: [Todo] = []
    var notificationToken: NotificationToken?

    
    func save(todo: Todo) {
        // todo = Todo(name: "Do laundry", ownerId: user.id)
        try! realm.write {
            realm.add(todo)
        }
    }
    
    func fetch() {
        let results = realm.objects(Todo.self)
        todoData = Array(results)
    }
    
    func update() {
            // All modifications to a realm must happen in a write block.
        let todoToUpdate = todoData[0]
        try! realm.write {
            todoToUpdate.status = "InProgress"
        }
    }
    
    func delete() {
            // All modifications to a realm must happen in a write block.
        let todoToDelete = todoData[0]
        try! realm.write {
                // Delete the Todo.
            realm.delete(todoToDelete)
        }
    }
        // Retain notificationToken as long as you want to observe
    func setupObserver() {
        notificationToken = todoData.observe { [weak self] (changes) in
            guard let self = self else { return }
            switch changes {
                case .initial:
                        // Results are now populated and can be accessed without blocking the UI
                    break
                case .update(_, let deletions, let insertions, let modifications):
                        // Query results have changed.
                    print("Deleted indices: ", deletions)
                    print("Inserted indices: ", insertions)
                    print("Modified modifications: ", modifications)
                case .error(let error):
                        // An error occurred while opening the Realm file on the background worker thread
                    fatalError("\(error)")
            }
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}
