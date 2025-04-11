//
//  TranslationTestView.swift
//  Translate-Me
//
//  Created by Yulia E on 4/11/25.
//

import SwiftUI

struct TranslationTestView: View {
    @State private var inputText = ""
    @State private var sourceLang = "en"
    @State private var targetLang = "es"

    @State private var translator = Translator()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Enter text to translate", text: $inputText)
                    .textFieldStyle(.roundedBorder)

                HStack {
                    Text("From: \(sourceLang)")
                    Text("To: \(targetLang)")
                }

                Button(action: {
                    translator.translate(text: inputText, from: sourceLang, to: targetLang)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if !translator.translatedText.isEmpty {
                            let manager = TranslationManager()
                            manager.saveTranslation(original: inputText, translated: translator.translatedText)
                        }
                    }
                }) {
                    Text("Translate")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                }
                .padding(.horizontal)


                if translator.isTranslating {
                    ProgressView("Translating...")
                } else {
                    Text("Translation:")
                    Text(translator.translatedText)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.green)
                }

                // 🔘 View History Button
                NavigationLink(destination: TranslationHistoryView()) {
                    Text("View History")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding()
            
        }
    }
}
