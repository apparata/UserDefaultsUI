import SwiftUI
import Combine
import os.log

public class UserDefaultsModel: ObservableObject {
    
    @Published var entries: [UserDefaultEntry] = []
    
    let actions: any UserDefaultsActions

    let hiddenPrefixes: [String]
    
    private var didChangeSubscription: AnyCancellable?
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "N/A",
                                category: "UserDefaultsModel")
        
    public init(actions: any UserDefaultsActions = .standard, hidePrefixes: [String]) {
        self.actions = actions
        self.hiddenPrefixes = hidePrefixes
        
        didChangeSubscription = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.refresh()
            }
        
        refresh()
    }
        
    // MARK: - Actions
    
    func refresh() {
        var entries: [UserDefaultEntry] = []
        
        for (key, value) in actions.defaultsAsDictionary {
            guard key.isUserKey else { continue }
            let string = "\(key): \(type(of: value))"
            logger.trace("\(string, privacy: .public)")
            
            var title = key
            var prefix: String?
            for hiddenPrefix in hiddenPrefixes {
                if title.hasPrefix(hiddenPrefix) {
                    title = title.trimmingPrefix(hiddenPrefix)
                    prefix = hiddenPrefix
                    break
                }
            }
            
            let entry = UserDefaultEntry(
                key: key,
                title: title,
                prefix: prefix,
                value: UserDefaultValue(value),
                type: "\(type(of: value))")
            entries.append(entry)
        }
        
        self.entries = entries.sorted()
    }
    
    func deleteUserDefault(at offsets: IndexSet) {
        for offset in offsets {
            let entry = entries[offset]
            actions.removeValueForKey(entry.key)
        }
    }
}

// MARK: - String Extensions

private extension String {
    func trimmingPrefix(_ prefix: String) -> String {
        if let prefixRange = range(of: prefix) {
            if prefixRange.upperBound >= endIndex {
                return String(self[startIndex..<prefixRange.lowerBound])
            } else {
                return String(self[prefixRange.upperBound..<endIndex])
            }
        }
        return self
    }
}

private extension String {
    
    var isUserKey: Bool {
        !hasSystemPrefix
    }
    
    var isSystemKey: Bool {
        hasSystemPrefix
    }
    
    var hasSystemPrefix: Bool {
        
        let prefixes = [
            "AddingEmojiKeybordHandled",
            "AK",
            "Apple",
            "com.apple.",
            "INNext",
            "internalSettings.",
            "METAL_",
            "NS",
            "PK",
            "WebKit"
        ]

        for prefix in prefixes {
            if hasPrefix(prefix) {
                return true
            }
        }
        return false
    }
}
