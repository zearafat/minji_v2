//
//  ContentView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 30/04/24.
//

import SwiftUI
import SwiftData
import Lottie

struct ContentView: View {
    
    @Query(sort: \Project.creationDate, order: .reverse) var projects: [Project]
    @State private var totalEarning: Double = 0.0
    @State private var ongoingProject: Int = 0
    @State private var selectedStatus: Statuses = .all
    @State private var illustrationOffset: Double = 0.0
    @State private var lottieEmpty: String = "lottie-empty"
    
    var filteredStatus: [Project] {
        if selectedStatus == .all {
            return projects
        } else {
            return projects.filter {
                $0.status == selectedStatus
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(height: 200)
                        .ignoresSafeArea(.all)
                    
                    Image("illustration")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160)
                        .padding(.trailing, 0)
                        .padding(.leading, 220)
                        .padding(.top, -30)
                        .offset(y: illustrationOffset)
                        .onAppear {
                            withAnimation(.bouncy) {
                                illustrationOffset = -20.0
                            } completion: {
                                withAnimation(.bouncy) {
                                    illustrationOffset = 0.0
                                }
                            }
                        }
                }
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Today \(Date.now.formattedDate())")
                            .roundedFont(forSize: .regular)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .background(.black)
                            .clipShape(Capsule())
                        
                        WidgetEarningView(
                            totalEarning: totalEarning,
                            ongoingProject: ongoingProject,
                            titleWidget1: "Total earning",
                            titleWidget2: "Ongoing project"
                        )
                        .onAppear {
                            self.totalEarning = calculateTotalEarning()
                            self.ongoingProject = calculateOngoingProjects()
                        }
                    }
                    .padding(16)

                    ScrollView {
                        HStack {
                            Text("Current projects")
                                .roundedFont(forSize: .large)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Picker("Status", selection: $selectedStatus) {
                                ForEach(Statuses.allCases, id: \.self) { status in
                                    Text(status.rawValue).tag(status)
                                }
                            }
                        }
                        .padding(.bottom, 14)
                        
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
                                
                                NavigationLink(destination: ProjectView(), label: {
                                    Text("Add project")
                                })
                            }
                        } else if filteredStatus.isEmpty {
                            VStack(alignment: .center, spacing: 14) {
                                Image("notfound")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 200)
                                Text("No project with this status. Create one to display here.")
                                    .roundedFont(forSize: .medium)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.slate500)
                                    .frame(width: 300)
                            }
                            .padding(.vertical, 34)
                        }
                        else {
                            ForEach(filteredStatus, id: \.id) { project in
                                NavigationLink(destination: EditProjectView(project: project)) {
                                    ProjectCardView(project: project)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .padding(16)
                }
            }
            .background(.slate50)
        }
    }
    
    private func calculateTotalEarning() -> Double {
        return projects.reduce(0.0) { $0 + ($1.budget)}
    }
    
    private func calculateOngoingProjects() -> Int {
        return projects.filter { $0.status == .ongoing }.count
    }
}

#Preview {
    ContentView()
}
