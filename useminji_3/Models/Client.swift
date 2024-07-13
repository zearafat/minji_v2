//
//  Client.swift
//  useminji_3
//
//  Created by Alzea Arafat on 30/04/24.
//

import Foundation
import SwiftData

@Model
final class Client: Hashable, Identifiable {
    var uuid: UUID
    var name: String
    var email: String
    
    var projects: [Project]?
    
    init(name: String, email: String) {
        self.uuid = UUID()
        self.name = name
        self.email = email
    }
}
