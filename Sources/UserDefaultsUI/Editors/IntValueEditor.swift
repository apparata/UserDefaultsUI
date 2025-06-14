import SwiftUI

struct IntValueEditor: View {
    
    @State private var text: String
    
    @FocusState private var isFocused: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    private var apply: (Int) -> Void
    
    init(value: Int, apply: @escaping (Int) -> Void) {
        _text = State(initialValue: String(value))
        self.apply = apply
    }
    
    var body: some View {
        VStack {
            TextField("", text: $text)
                .labelsHidden()
                #if !os(macOS)
                .keyboardType(.numbersAndPunctuation)
                #endif
                .focused($isFocused)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color(white: 0, opacity: 0.05))
                .cornerRadius(8)
                .padding()
                .onAppear {
                    isFocused = true
                }
            Button {
                let value = Int(text) ?? 0
                apply(value)
                text = "\(value)"
            } label: {
                Text("Apply")
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
            Spacer()
        }
    }
}

#if swift(>=5.9)

#Preview {
    IntValueEditor(value: 1337, apply: { value in print(value) })
}

#endif
