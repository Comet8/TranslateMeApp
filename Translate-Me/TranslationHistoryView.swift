//
//  TranslationHistoryView.swift
//  Translate-Me
//
//  Created by Yulia E on 4/11/25.
//

/*import SwiftUI

struct TranslationHistoryView: View {
    @State var manager = TranslationManager()

    var body: some View {
        NavigationStack {
            VStack {
                if $manager.translations.isEmpty {
                    Text("No history yet.")
                        .foregroundStyle(.secondary)
                        .padding()
                } else {
                    List(manager.translations) { translation in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(translation.originalText)
                                .font(.headline)
                            Text(translation.translatedText)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Button("Clear History") {
                    manager.clearHistory()
                }
                .foregroundColor(.red)
                .padding(.top)
            }
            .navigationTitle("History")
        }
    }
}
*/


import SwiftUI
import FirebaseFirestore

struct TranslationHistoryView: View {
    @State private var translations: [Translation] = []

    var body: some View {
        NavigationView {
            List(translations) { translation in
                VStack(alignment: .leading, spacing: 4) {
                    Text("Original: \(translation.originalText)")
                        .font(.headline)
                    Text("Translated: \(translation.translatedText)")
                        .foregroundColor(.secondary)
                    Text(translation.timestamp.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Translation History")
            .onAppear(perform: fetchHistory)
        }
    }

    private func fetchHistory() {
        let db = Firestore.firestore()
        db.collection("translations")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching history: \(error)")
                    return
                }

                guard let documents = snapshot?.documents else { return }

                translations = documents.compactMap { doc in
                    Translation(id: doc.documentID, data: doc.data())
                }
            }
    }
}
