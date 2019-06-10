//
//  Profil.swift
//  Epireminder
//
//  Created by Maxime Gernath on 09/06/2019.
//  Copyright © 2019 MaximeCorp. All rights reserved.
//
//   let profil = try? newJSONDecoder().decode(Profil.self, from: jsonData)

import Foundation

// MARK: - Profil
struct Profil: Codable {
    let login, title, internalEmail, lastname: String
    let firstname: String
    let userinfo: Userinfo
    let referentUsed: Bool
    let picture, scolaryear: String
    let promo, semester: Int
    let location, documents, ctime, mtime: String
    let courseCode, semesterCode, schoolID, schoolCode: String
    let schoolTitle: String
    let studentyear: Int
    let groups: [Group]
    let credits: Int
    let gpa: [Gpa]
    let nsstat: Nsstat
    
    enum CodingKeys: String, CodingKey {
        case login, title
        case internalEmail = "internal_email"
        case lastname, firstname, userinfo
        case referentUsed = "referent_used"
        case picture, scolaryear, promo, semester, location, documents, ctime, mtime
        case courseCode = "course_code"
        case semesterCode = "semester_code"
        case schoolID = "school_id"
        case schoolCode = "school_code"
        case schoolTitle = "school_title"
        case studentyear, groups, credits, gpa, nsstat
    }
}

// MARK: - Gpa
struct Gpa: Codable {
    let gpa, cycle: String
}

// MARK: - Group
struct Group: Codable {
    let title, name: String
    let count: Int
}

// MARK: - Nsstat
struct Nsstat: Codable {
    let active: Double
    let idle, outActive, outIdle, nslogNorm: Int
    
    enum CodingKeys: String, CodingKey {
        case active, idle
        case outActive = "out_active"
        case outIdle = "out_idle"
        case nslogNorm = "nslog_norm"
    }
}

// MARK: - Userinfo
struct Userinfo: Codable {
}
