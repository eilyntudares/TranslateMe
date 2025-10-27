import SwiftUI

struct TranslateView: View {
    @StateObject private var vm = TranslateViewModel()

    let languages = [
        ("English", "en"),
        ("Spanish", "es"),
        ("French", "fr"),
        ("German", "de"),
        ("Italian", "it"),
        ("Portuguese", "pt")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {

                    // Language pickers
                    HStack {
                        Picker("From", selection: $vm.sourceLang) {
                            ForEach(languages, id: \.1) { name, code in
                                Text("\(name) (\(code))").tag(code)
                            }
                        }
                        .pickerStyle(.menu)

                        Image(systemName: "arrow.left.arrow.right")

                        Picker("To", selection: $vm.targetLang) {
                            ForEach(languages, id: \.1) { name, code in
                                Text("\(name) (\(code))").tag(code)
                            }
                        }
                        .pickerStyle(.menu)
                    }

                    // Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Text to translate").font(.caption).foregroundStyle(.secondary)
                        TextEditor(text: $vm.inputText)
                            .frame(minHeight: 90)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(.gray.opacity(0.3)))
                    }

                    // Translate button
                    Button {
                        Task { await vm.translateAndSave() }
                    } label: {
                        HStack {
                            if vm.isLoading { ProgressView() }
                            Text("Translate").fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue.opacity(0.9))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .disabled(vm.isLoading || vm.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                    // Output
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Translation").font(.caption).foregroundStyle(.secondary)
                        TextEditor(text: $vm.outputText)
                            .frame(minHeight: 90)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(.gray.opacity(0.3)))
                    }

                    if let err = vm.errorMessage, !err.isEmpty {
                        Text(err).foregroundColor(.red).font(.footnote)
                    }

                    Divider().padding(.vertical, 8)

                    // History
                    HStack {
                        Text("History").font(.headline)
                        Spacer()
                        Button("Clear") { Task { await vm.clearAll() } }
                            .foregroundColor(.red)
                    }

                    VStack(spacing: 0) {
                        ForEach(vm.history) { item in
                            VStack(alignment: .leading, spacing: 6) {
                                Text("\(item.sourceLang) → \(item.targetLang)")
                                    .font(.caption).foregroundStyle(.secondary)
                                Text(item.inputText).font(.subheadline)
                                Text(item.translatedText)
                                    .font(.callout)
                                    .foregroundStyle(.blue)
                            }
                            .padding(.vertical, 10)
                            Divider()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("TranslateMe")
            .task { await vm.fetchHistory() }
        }
    }
}

#Preview { TranslateView() }

