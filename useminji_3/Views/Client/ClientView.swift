//
//  ClientView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 30/04/24.
//

import SwiftUI
import SwiftData
import Lottie

struct ClientView: View {
    
    @Query var clients: [Client]
    @Environment(\.modelContext) var modelContext
    @State private var isAddClientPresented: Bool = false
    @State private var searchQuery: String = ""
    @State private var lottieEmpty: String = "lottie-empty"
    
    var filteredClients: [Client] {
        if searchQuery.isEmpty {
            return clients
        }
        
        let filteredClients = clients.compactMap { client in
            let titleContainsQuery = client.name.range(of: searchQuery, options: .caseInsensitive) != nil
            
            return titleContainsQuery ? client : nil
        }
        
        return filteredClients
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if clients.isEmpty {
                    VStack(alignment: .center, spacing: 14) {
                        LottieView(animation: .named(lottieEmpty))
                            .configure({ lottieAnimationView in
                                lottieAnimationView.contentMode = .scaleAspectFit
                            })
                            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                            .scaledToFit()
                            .frame(maxWidth: 240)
                        
                        Text("No client yet. Create one to display here.")
                            .roundedFont(forSize: .medium)
                            .foregroundColor(.slate500)
                        
                        ButtonView(
                            textButton: "Add client",
                            textColor: .white,
                            backgroundButton: .black) {
                                isAddClientPresented.toggle()
                            }
                            .sheet(isPresented: $isAddClientPresented, content: {
                                AddClientView()
                                    .presentationDetents([.medium])
                            })
                            .padding(.vertical, 14)
                    }
                } else {
                    List {
                        ForEach(filteredClients) { client in
                            NavigationLink(destination: EditClientView(client: client)) {
                                HStack {
                                    Text(client.name)
                                        .roundedFont(forSize: .medium)
                                    
                                    Spacer()
                                    
                                    Text(client.email)
                                        .roundedFont(forSize: .medium)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .onDelete(perform: deleteClient)
                    }
                    .scrollIndicators(.hidden)
                    .searchable(text: $searchQuery, prompt: "Search client").autocorrectionDisabled(true).autocapitalization(.none)
                    .overlay {
                        if filteredClients.isEmpty, !searchQuery.isEmpty {
                            /// In case there aren't any search results, we can
                            /// show the new content unavailable view.
                            // ContentUnavailableView.search(text: searchQuery)
                            ContentUnavailableView {
                                Label("No Result",
                                      image: "notfound"
                                )
                            } description: {
                                Text("Check the spelling or try a new search.")
                            }
                        }
                    }
                    .navigationTitle("Clients")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationDestination(for: Client.self) { client in
                        EditClientView(client: client)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                isAddClientPresented.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .sheet(isPresented: $isAddClientPresented, content: {
                                AddClientView()
                                    .presentationDetents([.medium])
                            })
                        }
                    }
                }
            }
        }
    }
    
    private func deleteClient(at offsets: IndexSet) {
        for offset in offsets {
            let client = clients[offset]
            modelContext.delete(client)
        }
    }
}

#Preview {
    ClientView()
}
