import Foundation

extension UserDefaultsActions where Self == StandardUserDefaultsActions {
    public static var mock: Self { Self() }
}

public class MockUserDefaultsActions: UserDefaultsActions {
    
    private var defaults: [String: Any]
    
    init(defaults: [String: Any] = [:]) {
        self.defaults = defaults
    }
    
    public var defaultsAsDictionary: [String: Any] {
        defaults
    }

    public func removeValueForKey(_ key: String) {
        defaults.removeValue(forKey: key)
    }

    public func setValue<T>(_ value: T?, forKey key: String) {
        if let value {
            defaults[key] = value
        } else {
            defaults.removeValue(forKey: key)
        }
    }

    public func valueForKey(_ key: String) -> Bool {
        defaults[key] as? Bool ?? false
    }
    
    public func valueForKey(_ key: String) -> Int {
        defaults[key] as? Int ?? 0
    }

    public func valueForKey(_ key: String) -> Float {
        defaults[key] as? Float ?? 0
    }

    public func valueForKey(_ key: String) -> Double {
        defaults[key] as? Double ?? 0
    }
    
    public func valueForKey(_ key: String) -> String? {
        defaults[key] as? String
    }
    
    public func valueForKey(_ key: String) -> Any? {
        defaults[key]
    }
}
