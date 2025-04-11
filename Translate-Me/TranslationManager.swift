//
//  TranslationManager.swift
//  Translate-Me
//
//  Created by Yulia E on 4/11/25.
//

/*import Foundation
import FirebaseFirestore


@Observable
class TranslationManager {
    var translations: [Translation] = []
    private let db = Firestore.firestore()

    init() {
        fetchHistory()
    }

    func saveTranslation(original: String, translated: String) {
        let translation = Translation(
            originalText: original,
            translatedText: translated,
            timestamp: Date()
        )

        do {
            _ = try db.collection("translations").addDocument(from: translation)
        } catch {
            print("❌ Error saving translation: \(error)")
        }
    }

    func fetchHistory() {
        db.collection("translations")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("❌ Error fetching translations: \(String(describing: error))")
                    return
                }

                self.translations = documents.compactMap { doc in
                    try? doc.data(as: Translation.self)
                }
            }
    }

    func clearHistory() {
        db.collection("translations").getDocuments { snapshot, error in
            guard let docs = snapshot?.documents else { return }
            for doc in docs {
                doc.reference.delete()
            }
        }
    }
}
*/


import Foundation
import FirebaseFirestore

@Observable
class TranslationManager {
    var translations: [Translation] = []
    private let db = Firestore.firestore()

    init() {
        fetchHistory()
    }

    func saveTranslation(original: String, translated: String) {
        let data: [String: Any] = [
            "originalText": original,
            "translatedText": translated,
            "timestamp": FieldValue.serverTimestamp()
        ]

        db.collection("translations").addDocument(data: data) { error in
            if let error = error {
                print("❌ Error saving translation: \(error)")
            }
        }
    }

    func fetchHistory() {
        db.collection("translations")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("❌ Error fetching translations: \(String(describing: error))")
                    return
                }

                self.translations = documents.compactMap { doc in
                    return Translation(id: doc.documentID, data: doc.data())
                }
            }
    }

    func clearHistory() {
        db.collection("translations").getDocuments { snapshot, error in
            guard let docs = snapshot?.documents else { return }
            for doc in docs {
                doc.reference.delete()
            }
        }
    }
}

