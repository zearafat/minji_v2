//
//  EditProjectView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 28/05/24.
//

import SwiftUI
import SwiftData

struct EditProjectView: View {
    
    @Bindable var project: Project
    @Environment(\.dismiss) var dismiss
    
    @Query var clients: [Client]
    @State private var isNewClientPresented: Bool = false
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.isLenient = true
        return formatter
    }()
    
    // Filter statuses to exclude "All"
    var statuses: [Statuses] {
        Statuses.allCases.filter { $0 != .all }
    }
    
    var isFormValid: Bool {
        !project.title.isEmpty && project.budget > 0
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Title (e.g Netflix App Design)", text: $project.title)
                        .autocorrectionDisabled(false)
                    
                    HStack {
                        Image(systemName: "creditcard")
                            .padding(.leading, 0)
                        
                        TextField("Budget (e.g 3000)", text: Binding(
                            get: {
                                numberFormatter.string(from: NSNumber(value: project.budget)) ?? ""
                            },
                            set: { newValue in
                                if let number = numberFormatter.number(from: newValue) {
                                    project.budget = number.doubleValue
                                } else {
                                    project.budget = 0.0
                                }
                            })
                        )
                        .keyboardType(.numberPad)
                    }
                    
                    DatePicker("Starting date", selection: $project.startingDate, displayedComponents: .date)
                    
                    HStack {
                        Picker("Client", selection: $project.client) {
                            ForEach(clients, id: \.self) { client in
                                Text(client.name.capitalized).tag(client as Client?)
                            }
                        }
                        
                        Divider()
                        
                        Button {
                            isNewClientPresented.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                        }
                        .padding(.leading, 12)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isNewClientPresented.toggle()
                        }
                        .sheet(isPresented: $isNewClientPresented) {
                            AddClientView()
                                .presentationDetents([.medium, .large])
                        }
                    }
                    
                    Picker("Status", selection: $project.status) {
                        ForEach(statuses, id: \.self) { status in
                            Text(status.rawValue.capitalized).tag(status as Statuses)
                        }
                    }
                }
            }
            .navigationTitle("Edit")
            .toolbar {
                ToolbarItem {
                    Button {
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

//#Preview {
//    EditProjectView()
//}
