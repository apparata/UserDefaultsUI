import Foundation

extension UserDefaultsActions where Self == StandardUserDefaultsActions {
    public static var standard: Self { Self() }
}

public struct StandardUserDefaultsActions: UserDefaultsActions {
    
    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public var defaultsAsDictionary: [String: Any] {
        userDefaults.dictionaryRepresentation()
    }

    public func removeValueForKey(_ key: String) {
        userDefaults.removeObject(forKey: key)
    }

    public func setValue<T>(_ value: T?, forKey key: String) {
        userDefaults.setValue(value, forKey: key)
    }
    
    public func valueForKey(_ key: String) -> Bool {
        userDefaults.bool(forKey: key)
    }
    
    public func valueForKey(_ key: String) -> Int {
        userDefaults.integer(forKey: key)
    }

    public func valueForKey(_ key: String) -> Float {
        userDefaults.float(forKey: key)
    }

    public func valueForKey(_ key: String) -> Double {
        userDefaults.double(forKey: key)
    }
    
    public func valueForKey(_ key: String) -> String? {
        userDefaults.string(forKey: key)
    }
    
    public func valueForKey(_ key: String) -> Date? {
        userDefaults.object(forKey: key) as? Date
    }

    public func valueForKey(_ key: String) -> Any? {
        userDefaults.object(forKey: key)
    }
}
