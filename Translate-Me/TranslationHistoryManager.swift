//
//  TranslationHistoryManager.swift
//  Translate-Me
//
//  Created by Yulia E on 4/11/25.
//

import Foundation
import FirebaseFirestore

class TranslationHistoryManager: ObservableObject {
    @Published var history: [TranslationHistoryItem] = []
    
    private let db = Firestore.firestore()

    init() {
        fetchHistory()
    }

    func fetchHistory() {
        db.collection("translations")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching history: \(error.localizedDescription)")
                    return
                }

                self.history = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: TranslationHistoryItem.self)
                } ?? []
            }
    }
}
