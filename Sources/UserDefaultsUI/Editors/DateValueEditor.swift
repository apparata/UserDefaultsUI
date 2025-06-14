import SwiftUI

struct DateValueEditor: View {

    @State private var date: Date
    
    @Environment(\.dismiss) private var dismiss
    
    private var apply: (Date) -> Void

    init(date: Date, apply: @escaping (Date) -> Void) {
        self.date = date
        self.apply = apply
    }
    
    var body: some View {
        VStack {
            Text(date.ISO8601Format(.iso8601))
                .frame(maxWidth: .infinity)
                #if os(macOS)
                .border(Color(NSColor.labelColor), width: 0.5)
                #else
                .border(Color(UIColor.label), width: 0.5)
                #endif
            DatePicker(selection: $date) {
                Text("New date")
            }
            .datePickerStyle(.graphical)
            .padding(.vertical, 2)
            .padding(.horizontal, 4)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(white: 0, opacity: 0.1), lineWidth: 1)
            )
            .padding()

            Button {
                apply(date)
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

#if swift(>=5.9)

#Preview {
    DateValueEditor(date: Date.now, apply: { date in print(date) })
}

#endif
