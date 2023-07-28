import SwiftUI

struct BoolValueEditor: View {
    
    @Binding var value: Bool
       
    var body: some View {
        Toggle("", isOn: $value)
            .labelsHidden()
    }
}

#if swift(>=5.9)

#Preview {
    BoolValueEditor(value: .constant(true))
}

#endif
