// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//   let agenda = try? newJSONDecoder().decode(Agenda.self, from: jsonData)

import Foundation

// MARK: - AgendaElement
struct AgendaElement: Codable {
    let scolaryear, actiTitle, start, end: String?
    let room: Room?
    let eventRegistered: EventRegistered?
    
    enum CodingKeys: String, CodingKey {
        case scolaryear
        case actiTitle = "acti_title"
        case start, end, room
        case eventRegistered = "event_registered"
    }
}

enum EventRegistered: Codable {
    case bool(Bool)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(EventRegistered.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for EventRegistered"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Room
struct Room: Codable {
    let code: String?
}

typealias Agenda = [AgendaElement]
