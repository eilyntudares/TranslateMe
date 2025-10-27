import Foundation

struct MyMemoryResponse: Decodable {
    let responseData: ResponseData
    struct ResponseData: Decodable { let translatedText: String }
}

enum MyMemoryError: Error { case invalidURL, badResponse }

final class MyMemoryService {
    func translate(text: String, from source: String, to target: String) async throws -> String {
        let clean = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !clean.isEmpty else { return "" }

        var comps = URLComponents(string: "https://api.mymemory.translated.net/get")
        comps?.queryItems = [
            URLQueryItem(name: "q", value: clean),
            URLQueryItem(name: "langpair", value: "\(source)|\(target)")
        ]
        guard let url = comps?.url else { throw MyMemoryError.invalidURL }

        let (data, resp) = try await URLSession.shared.data(from: url)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else { throw MyMemoryError.badResponse }

        let decoded = try JSONDecoder().decode(MyMemoryResponse.self, from: data)
        return decoded.responseData.translatedText
    }
}

