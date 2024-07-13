//
//  AddClientView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 30/04/24.
//

import SwiftUI
import SwiftData

struct AddClientView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    
    var onClientAdded: ((Client) -> Void)?
    
    var isFormValid: Bool {
        !name.isEmpty && !email.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Name", text: $name)
                        .autocorrectionDisabled(true)
                    
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(true)
                }
            }
            .navigationTitle("Add client")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { // Correct placement
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) { // Correct placement
                    Button(action: {
                        let newClient = save()
                        onClientAdded?(newClient)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
    
    private func save() -> Client {
        let client = Client(name: name, email: email)
        modelContext.insert(client)
        return client
    }
}

//#Preview {
//    AddClientView()
//}
