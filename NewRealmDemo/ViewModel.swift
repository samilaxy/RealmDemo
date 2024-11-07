    //
    //  ViewModel.swift
    //  NewRealmDemo
    //
    //  Created by Samuel on 7/17/24.
    //

import Foundation
import RealmSwift

class ViewModel: ObservableObject {
    
    private var realm: Realm
    
    
    @Published var todoData: [Todo] = []
    var notificationToken: NotificationToken?
    
    init() {
        do {
            realm = try Realm()
            fetch()
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    func save(todo: Todo) {
            
        do {
            try realm.write {
                realm.add(todo)
                fetch()
            }
        } catch {
            print("Failed to add Todo: \(error.localizedDescription)")
        }
    }
    
    func fetch() {
        let results = realm.objects(Todo.self)
        todoData = Array(results)
    }
    
    func update() {
           
        let todoToUpdate = todoData[0]
        do {
            try realm.write {
                todoToUpdate.status = "InProgress"
            }
        } catch {
            print("Failed to add Todo: \(error.localizedDescription)")
        }
    }
    
    func delete(at offsets: IndexSet) {
        do {
            try realm.write {
                offsets.forEach { index in
                    realm.delete(todoData[index])
                    fetch()
                }
            }
        } catch {
            print("Failed to add Todo: \(error.localizedDescription)")
        }
    }
        // Retain notificationToken as long as you want to observe
        //    func setupObserver() {
        //        notificationToken = todoData.observe { [weak self] (changes: RealmCollectionChange<Results<Todo>>) in
        //            guard let self = self else { return }
        //            switch changes {
        //                case .initial:
        //                        // Results are now populated and can be accessed without blocking the UI

       
    
    deinit {
        notificationToken?.invalidate()
    }
}
