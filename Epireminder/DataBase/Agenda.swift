// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let agenda = try? newJSONDecoder().decode(Agenda.self, from: jsonData)

import Foundation

// MARK: - AgendaElement
struct AgendaElement: Codable {
    let scolaryear, codemodule: String
    let codeinstance: Codeinstance
    let codeacti, codeevent: String
    let semester: Int
    let instanceLocation: InstanceLocation
    let titlemodule: String
    let actiTitle: String
    let numEvent: Int
    let start, end: String
    let totalStudentsRegistered: Int
    let title: String?
    let typeTitle: TypeTitle
    let typeCode: TypeCode
    let isRdv, nbHours, allowedPlanningStart, allowedPlanningEnd: String
    let nbGroup: Int
    let nbMaxStudentsProjet: String?
    let room: Room?
    let dates: JSONNull?
    let moduleAvailable, moduleRegistered, past, allowRegister: Bool
    let eventRegistered: EventRegistered
    let display: String
    let project: Bool
    let rdvGroupRegistered: String?
    let rdvIndivRegistered: JSONNull?
    let allowToken, registerStudent, registerProf, registerMonth: Bool
    let inMoreThanOneMonth: Bool
    
    enum CodingKeys: String, CodingKey {
        case scolaryear, codemodule, codeinstance, codeacti, codeevent, semester
        case instanceLocation = "instance_location"
        case titlemodule
        case actiTitle = "acti_title"
        case numEvent = "num_event"
        case start, end
        case totalStudentsRegistered = "total_students_registered"
        case title
        case typeTitle = "type_title"
        case typeCode = "type_code"
        case isRdv = "is_rdv"
        case nbHours = "nb_hours"
        case allowedPlanningStart = "allowed_planning_start"
        case allowedPlanningEnd = "allowed_planning_end"
        case nbGroup = "nb_group"
        case nbMaxStudentsProjet = "nb_max_students_projet"
        case room, dates
        case moduleAvailable = "module_available"
        case moduleRegistered = "module_registered"
        case past
        case allowRegister = "allow_register"
        case eventRegistered = "event_registered"
        case display, project
        case rdvGroupRegistered = "rdv_group_registered"
        case rdvIndivRegistered = "rdv_indiv_registered"
        case allowToken = "allow_token"
        case registerStudent = "register_student"
        case registerProf = "register_prof"
        case registerMonth = "register_month"
        case inMoreThanOneMonth = "in_more_than_one_month"
    }
}

enum Codeinstance: String, Codable {
    case fr71 = "FR-7-1"
    case par01 = "PAR-0-1"
    case par02 = "PAR-0-2"
    case par07 = "PAR-0-7"
    case par08 = "PAR-0-8"
    case par101 = "PAR-10-1"
    case par11 = "PAR-1-1"
    case par16 = "PAR-1-6"
    case par17 = "PAR-1-7"
    case par21 = "PAR-2-1"
    case par41 = "PAR-4-1"
    case par52 = "PAR-5-2"
    case par61 = "PAR-6-1"
    case par71 = "PAR-7-1"
    case par81 = "PAR-8-1"
    case par91 = "PAR-9-1"
    case par92 = "PAR-9-2"
    case par93 = "PAR-9-3"
    case par94 = "PAR-9-4"
    case par95 = "PAR-9-5"
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

enum InstanceLocation: String, Codable {
    case fr = "FR"
    case frPar = "FR/PAR"
}

// MARK: - Room
struct Room: Codable {
    let code: String?
    let type: RoomType?
    let seats: Int?
}

enum RoomType: String, Codable {
    case bureau = "bureau"
    case exterieur = "exterieur"
    case salleDeCours = "salle_de_cours"
    case salleMachine = "salle_machine"
}

enum TypeCode: String, Codable {
    case exam = "exam"
    case other = "other"
    case proj = "proj"
    case rdv = "rdv"
    case tp = "tp"
    case typeCodeClass = "class"
}

enum TypeTitle: String, Codable {
    case accompagnement = "Accompagnement"
    case bootstrap = "Bootstrap"
    case bttf = "BTTF"
    case conference = "Conference"
    case course = "Course"
    case cusAI = "CUS - AI"
    case cusCybersecurity = "CUS - Cybersecurity"
    case cusDataArchitecture = "CUS - Data Architecture"
    case cusNetwork = "CUS - Network"
    case debriefing = "Debriefing"
    case defense = "Defense"
    case event = "Event"
    case followUp = "Follow-up"
    case keynote = "Keynote"
    case kickOff = "Kick-off"
    case oldFollowUp = "(OLD) Follow Up"
    case oldRdvAdm = "(OLD) RDV ADM"
    case pitch = "Pitch"
    case project = "Project"
    case review = "Review"
    case stumper = "Stumper"
    case tePitech = "TEPitech"
    case workshop = "Workshop"
}

typealias Agenda = [AgendaElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public func hash(into hasher: inout Hasher) {
        // No-op
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
