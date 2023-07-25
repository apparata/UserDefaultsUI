import SwiftUI

struct BoolValueEditor: View {
    
    @Binding var value: Bool
       
    var body: some View {
        Toggle("", isOn: $value)
            .labelsHidden()
    }
}

// Comment out until Xcode 15 goes live.
/*
#Preview {
    BoolValueEditor(value: .constant(true))
}
*/
