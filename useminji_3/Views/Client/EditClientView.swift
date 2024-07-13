//
//  EditClientView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 30/05/24.
//

import SwiftUI

struct EditClientView: View {
    
    @Bindable var client: Client
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presntationMode
    
    var isFormValid: Bool {
        !client.name.isEmpty && !client.email.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Name", text: $client.name)
                        .autocorrectionDisabled(true)
                    
                    TextField("Email", text: $client.email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(true)
                }
            }
            .navigationTitle("Add client")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        presntationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                    })
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

//#Preview {
//    EditClientView()
//}
