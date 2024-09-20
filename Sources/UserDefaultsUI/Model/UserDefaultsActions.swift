import Foundation

// MARK: - UserDefaults Actions

public protocol UserDefaultsActions {
    
    var defaultsAsDictionary: [String: Any] { get }

    func removeValueForKey(_ key: String)

    func setValue<T>(_ value: T?, forKey key: String)
        
    func valueForKey(_ key: String) -> Bool
    func valueForKey(_ key: String) -> Int
    func valueForKey(_ key: String) -> Float
    func valueForKey(_ key: String) -> Double
    func valueForKey(_ key: String) -> String?
    func valueForKey(_ key: String) -> Date?
    func valueForKey(_ key: String) -> Any?
}
