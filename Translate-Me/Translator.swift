//
//  Translator.swift
//  Translate-Me
//
//  Created by Yulia E on 4/11/25.
//

import Foundation

@Observable
class Translator {
    var translatedText: String = ""
    var isTranslating = false

    func translate(text: String, from sourceLang: String = "en", to targetLang: String = "es") {
        guard let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Failed to encode text")
            return
        }

        let urlString = "https://api.mymemory.translated.net/get?q=\(encodedText)&langpair=\(sourceLang)|\(targetLang)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        isTranslating = true

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isTranslating = false
            }

            if let error = error {
                print("Translation error: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoded = try JSONDecoder().decode(TranslationResponse.self, from: data)
                DispatchQueue.main.async {
                    self.translatedText = decoded.responseData.translatedText
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}
struct TranslationResponse: Decodable {
    let responseData: ResponseData
}

struct ResponseData: Decodable {
    let translatedText: String
}
