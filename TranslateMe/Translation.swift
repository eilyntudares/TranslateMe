import Foundation

struct Translation: Identifiable, Codable {
    var id: String?                
    var inputText: String
    var translatedText: String
    var sourceLang: String
    var targetLang: String
    var createdAt: Date = Date()
}

