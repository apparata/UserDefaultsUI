import SwiftUI

struct UserDefaultEntryEditor: View {
    
    let entry: UserDefaultEntry
    
    let model: UserDefaultsModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                if let prefix = entry.prefix {
                    Text(prefix)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, -6)
                }
                Text(entry.title)
            }
            .padding()
            switch entry.value {
            
            case .boolean(_):
                BoolValueEditor(value: Binding(get: {
                    model.actions.valueForKey(entry.key)
                }, set: { newValue in
                    model.actions.setValue(newValue, forKey: entry.key)
                }))
                .labelsHidden()
            
            case .integer(let value):
                IntValueEditor(value: value) { value in
                    model.actions.setValue(value, forKey: entry.key)
                }

            case .float(let value):
                FloatValueEditor(value: value) { value in
                    model.actions.setValue(value, forKey: entry.key)
                }

            case .double(let value):
                DoubleValueEditor(value: value) { value in
                    model.actions.setValue(value, forKey: entry.key)
                }

            case .string(let value):
                StringValueEditor(text: value) { text in
                    model.actions.setValue(text, forKey: entry.key)
                }

            case .date(let value):
                DateValueEditor(date: value) { date in
                    model.actions.setValue(date, forKey: entry.key)
                }
            
            case .other(_):
                Text("\(entry.type) is not editable")
            }
            
            Spacer()
        }
    }
}
