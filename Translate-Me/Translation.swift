import Foundation
import FirebaseFirestore

struct Translation: Identifiable {
    var id: String
    var originalText: String
    var translatedText: String
    var timestamp: Date

    init(id: String, originalText: String, translatedText: String, timestamp: Date) {
        self.id = id
        self.originalText = originalText
        self.translatedText = translatedText
        self.timestamp = timestamp
    }

    init?(id: String, data: [String: Any]) {
        guard
            let originalText = data["originalText"] as? String,
            let translatedText = data["translatedText"] as? String,
            let timestamp = data["timestamp"] as? Timestamp
        else {
            return nil
        }

        self.id = id
        self.originalText = originalText
        self.translatedText = translatedText
        self.timestamp = timestamp.dateValue()
    }
}
