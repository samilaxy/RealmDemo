    //
    //  ContentView.swift
    //  NewRealmDemo
    //
    //  Created by Samuel on 7/17/24.
    //

import SwiftUI

struct ContentView: View {
    @State private var showAddTaskView = false
    @StateObject var viewModel = ViewModel()
    
    var data: [Todo] {
        viewModel.todoData
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    
                    ForEach(data, id: \._id) { task in
                        VStack(alignment: .leading) {
                            Text(task.name)
                                .font(.headline)
                            Text("Owner: \(task.ownerId)")
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: viewModel.delete)
                }
                .sheet(isPresented: $showAddTaskView) {
                    TodoFormView()
                        .environmentObject(viewModel)
                }
                .navigationBarItems(trailing: Button(action: {
                    showAddTaskView = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                })
                .navigationTitle("Tasks")
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}


struct TodoFormView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var name: String = ""
    @State var ownerId: String = ""
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Name", text: $name)
                    TextField("Owner ID", text: $ownerId)
                }
                Section {
                    Button(action: {
                        viewModel.save(todo: Todo(name: name, ownerId: ownerId))
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add Task")
                    }
                    .disabled(name.isEmpty || ownerId.isEmpty)
                }
            }
            .navigationTitle("Add New Task")
        }
    }
}

