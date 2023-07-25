import Foundation

struct UserDefaultEntry: Identifiable {
    
    var id: String { key }
    
    let key: String
    let title: String
    let prefix: String?
    
    let value: UserDefaultValue
    let type: String
}

extension UserDefaultEntry: Hashable, Comparable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
    
    static func < (lhs: UserDefaultEntry, rhs: UserDefaultEntry) -> Bool {
        lhs.title < rhs.title
    }
    
    static func == (lhs: UserDefaultEntry, rhs: UserDefaultEntry) -> Bool {
        lhs.id == rhs.id
    }
}
