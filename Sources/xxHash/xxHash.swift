//
//  xxHash.swift
//  xxHash
//
//  Copyright (C) 2025  Khan Winter
//  See the LICENSE file distributed with this program for applicable license and warranty.
//

import CxxHash

public struct xxHash128 {
    var state: OpaquePointer

    public init() {
        state = XXH_INLINE_XXH3_createState()
        XXH_INLINE_XXH3_128bits_reset(state)
    }

    public mutating func combine(_ buffer: UnsafeRawBufferPointer) {
        XXH_INLINE_XXH3_128bits_update(state, buffer.baseAddress, buffer.count)
    }

    public mutating func combine(_ data: ArraySlice<UInt8>)  {
        data.withUnsafeBytes { buffer in combine(buffer) }
    }

    public mutating func combine(_ data: [UInt8])  {
        data.withUnsafeBytes { buffer in combine(buffer) }
    }

    public mutating func combine<T: FixedWidthInteger>(_ value: T) {
        withUnsafePointer(to: value.bigEndian) { ptr in self.combine(UnsafeRawBufferPointer(start: ptr, count: 1)) }
    }

    public mutating func combine(_ value: Bool) {
        if value {
            combine(UInt8.zero)
        } else {
            combine(UInt8(1))
        }
    }

    public mutating func combine(_ value: Float) {
        combine(value.bitPattern)
    }

    public mutating func combine(_ value: Double) {
        combine(value.bitPattern)
    }

    public mutating func combine(_ value: String) {
        for unit in value.utf8 { combine(unit) }
    }

    public mutating func combine<T: Collection>(_ value: T) where T.Element: FixedWidthInteger {
        withUnsafeBytes(of: value, { ptr in combine(ptr) })
    }

    public mutating func combine<T: Collection>(_ value: T) where T.Element == Bool {
        withUnsafeBytes(of: value, { ptr in combine(ptr) })
    }

    public mutating func combine<T: Collection>(_ value: T) where T.Element == Float {
        withUnsafeBytes(of: value, { ptr in combine(ptr) })
    }

    public mutating func combine<T: Collection>(_ value: T) where T.Element == Double {
        withUnsafeBytes(of: value, { ptr in combine(ptr) })
    }

    public mutating func combine<T: Collection>(_ value: T) where T.Element == String {
        withUnsafeBytes(of: value, { ptr in combine(ptr) })
    }

    public mutating func combine<T: StableHashable>(_ value: T) throws {
        try value.hash(into: &self)
    }

    public mutating func combine(_ digest: xxHash128Digest) {
        withUnsafeBytes(of: digest.value) { ptr in combine(ptr) }
    }

    public consuming func finalize() -> xxHash128Digest {
        let hash = XXH_INLINE_XXH3_128bits_digest(state)
        return xxHash128Digest(hash)
    }

    public static func digest(_ buffer: UnsafeRawBufferPointer) -> xxHash128Digest {
        xxHash128Digest(XXH_INLINE_XXH3_128bits(buffer.baseAddress, buffer.count))
    }

    public static func digest(_ data: ArraySlice<UInt8>) -> xxHash128Digest {
        data.withUnsafeBytes { ptr in digest(ptr) }
    }

    public static func digest(_ data: [UInt8]) -> xxHash128Digest {
        data.withUnsafeBytes { ptr in digest(ptr) }
    }

    public static func digest<T: FixedWidthInteger>(_ value: T) -> xxHash128Digest {
        withUnsafePointer(to: value.bigEndian) { ptr in digest(UnsafeRawBufferPointer(start: ptr, count: 1)) }
    }

    public static func digest(_ value: Bool) -> xxHash128Digest {
        if value {
            digest(UInt8.zero)
        } else {
            digest(UInt8(1))
        }
    }

    public static func digest(_ value: Float) -> xxHash128Digest {
        digest(value.bitPattern)
    }

    public static func digest(_ value: Double) -> xxHash128Digest {
        digest(value.bitPattern)
    }

    public static func digest(_ value: String) -> xxHash128Digest {
        var hasher = xxHash128()
        hasher.combine(value)
        return hasher.finalize()
    }

    public static func digest<T: Collection>(_ value: T) -> xxHash128Digest where T.Element: FixedWidthInteger {
        var hasher = xxHash128()
        hasher.combine(value)
        return hasher.finalize()
    }

    public static func digest<T: Collection>(_ value: T) -> xxHash128Digest where T.Element == Bool {
        var hasher = xxHash128()
        hasher.combine(value)
        return hasher.finalize()
    }

    public static func digest<T: Collection>(_ value: T) -> xxHash128Digest where T.Element == Float {
        var hasher = xxHash128()
        hasher.combine(value)
        return hasher.finalize()
    }

    public static func digest<T: Collection>(_ value: T) -> xxHash128Digest where T.Element == Double {
        var hasher = xxHash128()
        hasher.combine(value)
        return hasher.finalize()
    }

    public static func digest<T: Collection>(_ value: T) -> xxHash128Digest where T.Element == String {
        var hasher = xxHash128()
        hasher.combine(value)
        return hasher.finalize()
    }

    public static func digest<T: StableHashable>(_ value: T) throws -> xxHash128Digest {
        var hasher = xxHash128()
        try hasher.combine(value)
        return hasher.finalize()
    }

    public static func digest(_ value: xxHash128Digest) -> xxHash128Digest {
        withUnsafeBytes(of: value.value) { ptr in digest(ptr) }
    }
}
