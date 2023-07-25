import SwiftUI

struct StringValueEditor: View {
    
    @State private var text: String
    
    @FocusState private var isFocused: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    private var apply: (String) -> Void
    
    init(text: String, apply: @escaping (String) -> Void) {
        _text = State(initialValue: text)
        self.apply = apply
    }
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .focused($isFocused)
                .padding(.vertical, 2)
                .padding(.horizontal, 4)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(white: 0, opacity: 0.1), lineWidth: 1)
                )
                .padding()
                .onAppear {
                    isFocused = true
                }
            Button {
                apply(text)
                dismiss()
            } label: {
                Text("Apply")
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
            Spacer()
        }
    }
}

// Comment out until Xcode 15 goes live.
/*
#Preview {
    StringValueEditor(text: "Hello", apply: { text in print(text) })
}
*/
