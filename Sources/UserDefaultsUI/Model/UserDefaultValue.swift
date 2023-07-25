import Foundation

enum UserDefaultValue: Identifiable {
        
    case boolean(Bool)
    case integer(Int)
    case float(Float)
    case double(Double)
    case string(String)
    case other(Any)
    
    var id: String {
        switch self {
        case .boolean(let value):
            return "boolean(\(value))"
        case .integer(let value):
            return "integer(\(value))"
        case .float(let value):
            return "float(\(value))"
        case .double(let value):
            return "double(\(value))"
        case .string(let value):
            return "string(\(value))"
        case .other(_):
            return "other"
        }
    }
    
    init(_ value: Any) {
        switch value {
        case let value as Bool:
            self = .boolean(value)
        case let value as NSNumber:
            self = value.asUserDefaultValue
        case let value as NSString:
            self = .string(value as String)
        default:
            self = .other(value)
        }
    }
}

// MARK: - Helpers

fileprivate extension NSNumber {
    var numberType: CFNumberType {
        return CFNumberGetType(self as CFNumber)
    }
}

fileprivate extension NSNumber {
    var asUserDefaultValue: UserDefaultValue {
        switch numberType {
        case .sInt8Type, .charType,
             .sInt16Type, .shortType,
             .sInt32Type, .longType,
            .sInt64Type, .longLongType,
            .intType, .cfIndexType, .nsIntegerType:
            return .integer(intValue)
        case .float32Type, .floatType:
            return .float(floatValue)
        case .float64Type, .doubleType:
            return .double(doubleValue)
        case .cgFloatType:
            switch MemoryLayout<CGFloat>.size {
            case 4:
                return .float(floatValue)
            default:
                return .double(doubleValue)
            }
        @unknown default:
            return .integer(intValue)
        }
    }
}
