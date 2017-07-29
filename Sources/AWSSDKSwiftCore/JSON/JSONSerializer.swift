//
//  JSONSerializable.swift
//  AWSSDKSwift
//
//  Created by Yuki Takei on 2017/03/23.
//
//

import Foundation

private func dquote(_ str: String) -> String {
    return "\"\(str)\""
}

protocol NumericType {
    static func +(lhs: Self, rhs: Self) -> Self
    static func -(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Self) -> Self
    static func /(lhs: Self, rhs: Self) -> Self
    static func truncatingRemainder(lhs: Self, rhs: Self) -> Self
    init(_ v: Int)
}

extension Double : NumericType {
    static func truncatingRemainder(lhs: Double, rhs: Double) -> Double {
        return lhs.truncatingRemainder(dividingBy: rhs)
    }
}
extension Float  : NumericType {
    static func truncatingRemainder(lhs: Float, rhs: Float) -> Float {
        return lhs.truncatingRemainder(dividingBy: rhs)
    }
}
extension Int    : NumericType {
    static func truncatingRemainder(lhs: Int, rhs: Int) -> Int {
        return Int(Double(lhs).truncatingRemainder(dividingBy: Double(rhs)))
    }
}
extension Int8   : NumericType {
    static func truncatingRemainder(lhs: Int8, rhs: Int8) -> Int8 {
        return Int8(Double(lhs).truncatingRemainder(dividingBy: Double(rhs)))
    }
}
extension Int16  : NumericType {
    static func truncatingRemainder(lhs: Int16, rhs: Int16) -> Int16 {
        return Int16(Double(lhs).truncatingRemainder(dividingBy: Double(rhs)))
    }
}
extension Int32  : NumericType {
    static func truncatingRemainder(lhs: Int32, rhs: Int32) -> Int32 {
        return Int32(Double(lhs).truncatingRemainder(dividingBy: Double(rhs)))
    }
}
extension Int64  : NumericType {
    static func truncatingRemainder(lhs: Int64, rhs: Int64) -> Int64 {
        return Int64(Double(lhs).truncatingRemainder(dividingBy: Double(rhs)))
    }
}
extension UInt   : NumericType {
    static func truncatingRemainder(lhs: UInt, rhs: UInt) -> UInt {
        return UInt(Double(lhs).truncatingRemainder(dividingBy: Double(rhs)))
    }
}
extension UInt8  : NumericType {
    static func truncatingRemainder(lhs: UInt8, rhs: UInt8) -> UInt8 {
        return UInt8(Double(lhs).truncatingRemainder(dividingBy: Double(rhs)))
    }
}
extension UInt16 : NumericType {
    static func truncatingRemainder(lhs: UInt16, rhs: UInt16) -> UInt16 {
        return UInt16(Double(lhs).truncatingRemainder(dividingBy: Double(rhs)))
    }
}
extension UInt32 : NumericType {
    static func truncatingRemainder(lhs: UInt32, rhs: UInt32) -> UInt32 {
        return UInt32(Double(lhs).truncatingRemainder(dividingBy: Double(rhs)))
    }
}
extension UInt64 : NumericType {
    static func truncatingRemainder(lhs: UInt64, rhs: UInt64) -> UInt64 {
        return UInt64(Double(lhs).truncatingRemainder(dividingBy: Double(rhs)))
    }
}

private func _serialize(value: Any) throws -> String {
    var s = ""
    switch value {
    case let dict as [String: Any]:
        s += try "{" + _serialize(dictionary: dict) + "}"
        
    case let elements as [Any]:
        s += try _serialize(array: elements)
        
    case let v as NumericType:
        s += "\(v)"
        
    case let v as Bool:
        s += "\(v)".lowercased()
        
    case let v as Data:
        s += dquote(v.base64EncodedString())
        
    default:
        s += dquote("\(value)")
    }
    
    return s
}

private func _serialize(array: [Any]) throws -> String {
    var s = ""
    for (index, item) in array.enumerated() {
        s += try _serialize(value: item)
        if array.count - index > 1 { s += ", " }
    }
    return "[" + s + "]"
}

private func _serialize(dictionary: [String: Any]) throws -> String {
    var s = ""
    for (offset: index, element: (key: key, value: value)) in dictionary.enumerated() {
        s += dquote(key)+": "
        s += try _serialize(value: value)
        if dictionary.count - index > 1 { s += ", " }
    }
    return s
}

public struct JSONSerializer {
    public static func serialize(_ dictionary: [String: Any]) throws -> Data {
        let jsonString = try "{" + _serialize(dictionary: dictionary) + "}"
        return jsonString.data(using: .utf8) ?? Data()
    }
}
