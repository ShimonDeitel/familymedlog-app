import Foundation

struct MedVisit: Identifiable, Codable, Equatable {
    let id: UUID
    var personName: String
    var date: Date
    var reason: String
    var prescription: String
    var notes: String

    init(id: UUID = UUID(), personName: String = "", date: Date = Date(), reason: String = "", prescription: String = "", notes: String = "") {
        self.id = id
        self.personName = personName
        self.date = date
        self.reason = reason
        self.prescription = prescription
        self.notes = notes
    }
}
