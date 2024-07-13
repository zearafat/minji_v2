//
//  Project.swift
//  useminji_3
//
//  Created by Alzea Arafat on 30/04/24.
//

import Foundation
import SwiftData

enum Statuses: String, CaseIterable, Codable, RawRepresentable {
    case all = "All"
    case upcoming = "Upcoming"
    case ongoing = "Ongoing"
    case completed = "Completed"
}

@Model
final class Project: Hashable {
    var title: String
    var budget: Double
    var startingDate: Date
    var status: Statuses
    var creationDate: Date = Date()
    
    @Relationship(deleteRule: .noAction, inverse: \Client.projects)
    var client: Client?
    
    init(title: String, budget: Double, startingDate: Date, status: Statuses) {
        self.title = title
        self.budget = budget
        self.startingDate = startingDate
        self.status = status
        self.creationDate = creationDate
    }
}
