//
//  ProjectView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 01/05/24.
//

import SwiftUI
import SwiftData
import Lottie

struct ProjectView: View {
    
    @Query(sort: \Project.creationDate, order: .reverse) var projects: [Project]
    @Environment(\.modelContext) var modelContext
    @State private var isAddNewProjectPresented = false
    @State private var searchQuery: String = ""
    @State private var lottieEmpty: String = "lottie-empty"
    @State private var selectedStatus: Statuses = .all
    
    var filteredProjects: [Project] {
        let filteredByStatus = selectedStatus == .all ? projects : projects.filter { $0.status == selectedStatus }
        if searchQuery.isEmpty {
            return filteredByStatus
        }
        return projects.filter { project in
            let matchesSearch = project.title.range(of: searchQuery, options: .caseInsensitive) != nil
            return matchesSearch
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if projects.isEmpty {
                    VStack(alignment: .center, spacing: 14) {
                        LottieView(animation: .named(lottieEmpty))
                            .configure({ lottieAnimationView in
                                lottieAnimationView.contentMode = .scaleAspectFit
                            })
                            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                            .scaledToFit()
                            .frame(maxWidth: 240)
                        
                        Text("No projects yet. Create one to display here.")
                            .roundedFont(forSize: .medium)
                            .foregroundColor(.slate500)
                        
                        ButtonView(
                            textButton: "Add project",
                            textColor: .white,
                            backgroundButton: .black) {
                                isAddNewProjectPresented.toggle()
                            }
                            .sheet(isPresented: $isAddNewProjectPresented, content: {
                                AddProjectView()
                                    .presentationDetents([.medium])
                            })
                            .padding(.vertical, 14)
                    }
                } else {
                    List {
                        if searchQuery.isEmpty {
                            Picker("Status", selection: $selectedStatus) {
                                ForEach(Statuses.allCases, id: \.self) { status in
                                    Text(status.rawValue).tag(status)
                                }
                            }
                        }
                        
                        if filteredProjects.isEmpty {
                            Text("No projects with this status.")
                                .roundedFont(forSize: .medium)
                                .foregroundColor(.slate500)
                        } else {
                            ForEach(filteredProjects, id: \.id) { project in
                                NavigationLink(destination: EditProjectView(project: project)) {
                                    HStack(alignment: .center, spacing: 0) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(project.title)
                                                .roundedFont(forSize: .medium)
                                            
                                            Text("Start: \(project.startingDate.formattedDate())")
                                                .roundedFont(forSize: .small)
                                                .foregroundColor(.slate500)
                                            
                                            HStack {
                                                Text("\(project.client?.name ?? "None")")
                                                    .roundedFont(forSize: .small)
                                                if project.status.rawValue == "Upcoming" {
                                                    Text("\(project.status.rawValue.capitalized)")
                                                        .roundedFont(forSize: .small)
                                                        .padding(.horizontal , 8)
                                                        .padding(.vertical, 4)
                                                        .background(.slate100)
                                                        .foregroundColor(.black)
                                                        .clipShape(RoundedRectangle(cornerRadius: 100, style: .continuous))
                                                } else if project.status.rawValue == "Ongoing" {
                                                    Text("\(project.status.rawValue.capitalized)")
                                                        .roundedFont(forSize: .small)
                                                        .padding(.horizontal , 8)
                                                        .padding(.vertical, 4)
                                                        .background(.yellow50)
                                                        .foregroundColor(.yellow600)
                                                        .clipShape(RoundedRectangle(cornerRadius: 100, style: .continuous))
                                                } else if project.status.rawValue == "Completed" {
                                                    Text("\(project.status.rawValue.capitalized)")
                                                        .roundedFont(forSize: .small)
                                                        .padding(.horizontal , 8)
                                                        .padding(.vertical, 4)
                                                        .background(.green50)
                                                        .foregroundColor(.green)
                                                        .clipShape(RoundedRectangle(cornerRadius: 100, style: .continuous))
                                                }
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        Text(project.budget.formattedAsDollar())
                                            .roundedFont(forSize: .medium)
                                    }
                                }
                            }
                            .onDelete(perform: deleteProject)
                        }
                    }
                    .scrollIndicators(.hidden)
                    .searchable(text: $searchQuery, prompt: "Search project").autocorrectionDisabled(true).autocapitalization(.none)
                    .overlay {
                        if filteredProjects.isEmpty, !searchQuery.isEmpty {
                            /// In case there aren't any search results, we can
                            /// show the new content unavailable view.
                            ContentUnavailableView {
                                Label("No Result",
                                      image: "notfound"
                                )
                            } description: {
                                Text("Check the spelling or try a new search.")
                            }
                        }
                    }
                    .navigationTitle("Projects")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationDestination(for: Project.self) { project in
                        EditProjectView(project: project)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                isAddNewProjectPresented.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .sheet(isPresented: $isAddNewProjectPresented, content: {
                                AddProjectView()
                                    .presentationDetents([.medium])
                            })
                        }
                    }
                }
            }
        }
    }
    
    private func deleteProject(at offsets: IndexSet) {
        for offset in offsets {
            // find this project in our query
            let project = projects[offset]
            // delete it from the context
            modelContext.delete(project)
        }
    }
}

#Preview {
    ProjectView()
}
