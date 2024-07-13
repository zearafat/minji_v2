//
//  ProjectCardView.swift
//  useminji_3
//
//  Created by Alzea Arafat on 03/05/24.
//

import SwiftUI

struct ProjectCardView: View {
    
    let project: Project
    
    var title: String = "Createstudio desktop app"
    var budget: Double = 3000
    var client: String? = "Josh Ratta"
    var startingDate: Date = .now
    var status: Statuses? = .ongoing
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(project.title)
                        .roundedFont(forSize: .medium)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
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

            Divider()
                .frame(height: 0.5)
                .overlay(.slate200)
            
            HStack {
                
                Text(project.client?.name ?? "None")
                    .roundedFont(forSize: .regular)
                    .foregroundColor(.slate500)

                Spacer()
                
                Text("Start: \(project.startingDate.formattedDate())")
                    .roundedFont(forSize: .regular)
                    .foregroundColor(.slate500)
            }
        }
        .padding(14)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
             RoundedRectangle(cornerRadius: 14)
                .stroke(.slate200, lineWidth: 0.5)
         )
        .shadow(color: .slate200.opacity(0.3), radius: 10, x: 0.0, y: 0.0)
    }
}

//#Preview {
//    ProjectCardView()
//}
