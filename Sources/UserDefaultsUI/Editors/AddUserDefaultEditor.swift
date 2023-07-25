import SwiftUI

struct AddUserDefaultEditor: View {

    let value: UserDefaultValue
    
    let model: UserDefaultsModel

    @Environment(\.dismiss) private var dismiss

    @State private var key: String = "example.key"
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Key")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    TextField("", text: $key)
                        .labelsHidden()
                        .keyboardType(.numbersAndPunctuation)
                        .padding(4)
                        .background(Color(white: 0, opacity: 0.05))
                        .cornerRadius(4)
                }
                .padding()
                switch value {
                    
                case .boolean(let value):
                    AddBoolEditor(value: value) { value in
                        let key = key.trimmingCharacters(in: .whitespacesAndNewlines)
                        model.actions.setValue(value, forKey: key)
                        dismiss()
                    }
                    
                case .integer(let value):
                    IntValueEditor(value: value) { value in
                        let key = key.trimmingCharacters(in: .whitespacesAndNewlines)
                        model.actions.setValue(value, forKey: key)
                        dismiss()
                    }
                    
                case .float(let value):
                    FloatValueEditor(value: value) { value in
                        let key = key.trimmingCharacters(in: .whitespacesAndNewlines)
                        model.actions.setValue(value, forKey: key)
                        dismiss()
                    }
                    
                case .double(let value):
                    DoubleValueEditor(value: value) { value in
                        let key = key.trimmingCharacters(in: .whitespacesAndNewlines)
                        model.actions.setValue(value, forKey: key)
                        dismiss()
                    }
                    
                case .string(let value):
                    StringValueEditor(text: value) { text in
                        let key = key.trimmingCharacters(in: .whitespacesAndNewlines)
                        model.actions.setValue(text, forKey: key)
                        dismiss()
                    }
                    
                case .other(_):
                    Text("Type is not editable")
                }
                
                Spacer()
            }
            .navigationTitle("Add User Default")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

private struct AddBoolEditor: View {
    
    @State private var value: Bool
    
    private var apply: (Bool) -> Void
    
    init(value: Bool, apply: @escaping (Bool) -> Void) {
        _value = State(initialValue: value)
        self.apply = apply
    }
    
    var body: some View {
        VStack {
            Toggle("", isOn: $value)
                .labelsHidden()
            Button {
                apply(value)
            } label: {
                Text("Apply")
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
            Spacer()
        }
    }
}
