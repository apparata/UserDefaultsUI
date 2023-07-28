import SwiftUI

public struct UserDefaultsBrowser: View {
    
    @StateObject private var model: UserDefaultsModel
    
    @State private var valueToAdd: UserDefaultValue?
    
    public init(hidePrefixes: [String]) {
        let userDefaultsModel = UserDefaultsModel(hidePrefixes: hidePrefixes)
        _model = StateObject(wrappedValue: userDefaultsModel)
    }
    
    public init(model: UserDefaultsModel) {
        _model = StateObject(wrappedValue: model)
    }
    
    public var body: some View {
        listOfEntries()
            .sheet(item: $valueToAdd) { value in
                AddUserDefaultEditor(value: value, model: model)
            }
            .navigationTitle("User Defaults")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Bool") {
                            valueToAdd = .boolean(false)
                        }
                        Button("Integer") {
                            valueToAdd = .integer(0)
                        }
                        Button("Float") {
                            valueToAdd = .float(0.0)
                        }
                        Button("Double") {
                            valueToAdd = .double(0.0)
                        }
                        Button("String") {
                            valueToAdd = .string("Placeholder")
                        }
                    } label: {
                        Label("Add Key", systemImage: "plus")
                    }
                }
            }
    }

    // MARK: List of Entries
    
    @ViewBuilder func listOfEntries() -> some View {
        List {
            ForEach(model.entries) { entry in
                NavigationLink {
                    UserDefaultEntryEditor(entry: entry, model: model)
                } label: {
                    HStack(spacing: 2) {
                        VStack(alignment: .leading) {
                            if let prefix = entry.prefix {
                                Text(prefix)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                    .padding(.bottom, -6)
                            }
                            Text(entry.title)
                        }
                        Spacer()
                        Group {
                            switch entry.value {
                            case .boolean: boolEntryView(entry)
                            case .integer(let value):
                                Text("\(String(value))")
                            case .float(let value):
                                Text("\(String(value))")
                            case .double(let value):
                                Text("\(String(value))")
                            case .string(let value):
                                Text(value)
                            case .other(_):
                                Text("<\(entry.type)>")
                                    .foregroundStyle(.tertiary)
                            }
                        }
                        .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 2)
                }
            }
            .onDelete(perform: model.deleteUserDefault)
        }
    }
    
    // MARK: Entry Views
    
    @ViewBuilder func boolEntryView(_ entry: UserDefaultEntry) -> some View {
        Toggle("", isOn: Binding(get: {
            model.actions.valueForKey(entry.key)
        }, set: { newValue in
            model.actions.setValue(newValue, forKey: entry.key)
        }))
        .labelsHidden()
    }
}

// MARK: - Preview

#if swift(>=5.9)

#Preview {
    NavigationView {
        let actions = MockUserDefaultsActions(defaults: [
            "io.apparata.BoolKey": true,
            "IntKey": 1,
            "FloatKey": 3.14,
            "DoubleKey": 9.81,
            "StringKey": "String Value",
            "DataKey": Data()
        ])
        let model = UserDefaultsModel(actions: actions, hidePrefixes: ["io.apparata."])
        UserDefaultsBrowser(model: model)
    }
}

#endif
