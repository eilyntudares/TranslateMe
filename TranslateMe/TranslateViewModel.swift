import Foundation
import FirebaseFirestore


@MainActor
final class TranslateViewModel: ObservableObject {
    @Published var inputText = ""
    @Published var outputText = ""
    @Published var sourceLang = "en"
    @Published var targetLang = "es"
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var history: [Translation] = []

    private let service = MyMemoryService()
    private let db = Firestore.firestore()
    private let collection = "translations"

    func translateAndSave() async {
        errorMessage = nil
        isLoading = true
        do {
            let translated = try await service.translate(text: inputText, from: sourceLang, to: targetLang)
            outputText = translated

            let item = Translation(inputText: inputText,
                                   translatedText: translated,
                                   sourceLang: sourceLang,
                                   targetLang: targetLang,
                                   createdAt: Date())
            try db.collection(collection).addDocument(from: item)
            await fetchHistory()
        } catch {
            errorMessage = "Translation failed: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func fetchHistory() async {
        do {
            let snap = try await db.collection(collection)
                .order(by: "createdAt", descending: true)
                .limit(to: 50)
                .getDocuments()
            history = try snap.documents.compactMap { try $0.data(as: Translation.self) }
        } catch {
            errorMessage = "Failed to load history: \(error.localizedDescription)"
        }
    }

    func clearAll() async {
        do {
            let snap = try await db.collection(collection).getDocuments()
            for doc in snap.documents {
                try await db.collection(collection).document(doc.documentID).delete()
            }
            history.removeAll()
        } catch {
            errorMessage = "Failed to clear: \(error.localizedDescription)"
        }
    }
}

