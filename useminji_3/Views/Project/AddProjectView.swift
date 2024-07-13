//
//  AddProjectVIew.swift
//  useminji_3
//
//  Created by Alzea Arafat on 01/05/24.
//

import SwiftUI
import SwiftData

struct AddProjectView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    @Query var clients: [Client] = []
    
    @State private var title: String = ""
    @State private var budget: Double = 0.0
    @State private var startingDate: Date = Date.now
    @State private var selectedStatus: Statuses = .ongoing
    @State private var selectedClient: Client? = nil
    @State var isNewClientPresented: Bool = false
    
    // Filter statuses to exclude "All"
    var statuses: [Statuses] {
        Statuses.allCases.filter { $0 != .all }
    }
    
    var isFormValid: Bool {
        !title.isEmpty && budget > 0
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Title (e.g Netflix App Design)", text: $title)
                        .autocorrectionDisabled(true)
                    
                    HStack {
                        Image(systemName: "creditcard")
                            .padding(.leading, 0)
                        
                        TextField("Bugdet (e.g 3000)", value: $budget, formatter: numberFormatter)
                            .keyboardType(.numberPad)
                    }
                    
                    DatePicker("Starting date", selection: $startingDate, displayedComponents: .date)
                    
                    HStack {
                        Picker("Client", selection: $selectedClient) {
                            Text("None").tag(Client?.none)
                            ForEach(clients, id: \.self) { client in
                                Text(client.name.capitalized).tag(Optional(client))
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
                            AddClientView { newClient in
                                selectedClient = newClient
                            }.presentationDetents([.medium, .large])
                        }
                    }

                    Picker("Status", selection: $selectedStatus) {
                        ForEach(statuses, id: \.self) { status in
                            Text(status.rawValue.capitalized).tag(status as Statuses)
                        }
                    }
                }
            }
            .navigationTitle("Add Project   ")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            save()
                            presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Save")
                    }
                    .disabled(!isFormValid)
                }
            }
            .padding(.bottom, 0)
        }
    }
    
    private func save() {
        let projectSave = Project(
            title: title,
            budget: Double(budget),
            startingDate: startingDate,
            status: selectedStatus
        )
        
        if let selectedClient = selectedClient {
            projectSave.client = selectedClient
        }
        
        modelContext.insert(projectSave)
    }
}

//#Preview {
//    AddProjectView()
//}
