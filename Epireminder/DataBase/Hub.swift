//
//  Hub.swift
//  Epireminder
//
//  Created by Maxime Gernath on 09/06/2019.
//  Copyright © 2019 MaximeCorp. All rights reserved.
//  let hub = try? newJSONDecoder().decode(Hub.self, from: jsonData)

import Foundation

// MARK: - Hub
struct Hub: Codable {
    let activites: [Activite]
}

// MARK: - Activite
struct Activite: Codable {
    let title: String
    let events: [Event]
}

// MARK: - Event
struct Event: Codable {
    let userStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case userStatus = "user_status"
    }
}
