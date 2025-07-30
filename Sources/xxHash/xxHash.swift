//
//  xxHash.swift
//  xxHash
//
//  Copyright (C) 2025  Khan Winter
//  See the LICENSE file distributed with this program for applicable license and warranty.
//

import CxxHash

public struct xxHash128Digest: Sendable, Hashable, Equatable, Codable {
    public static let empty = xxHash128Digest()

    let value: XXH_NAMESPACEXXH128_hash_t

    init(_ value: XXH_NAMESPACEXXH128_hash_t) {
        self.value = value
    }

    init() {
        value = .init(low64: 0, high64: 0)
    }

    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let digest = (
            try container.decode(UInt8.self), // 1
            try container.decode(UInt8.self),
            try container.decode(UInt8.self),
            try container.decode(UInt8.self),
            try container.decode(UInt8.self),
            try container.decode(UInt8.self),
            try container.decode(UInt8.self),
            try container.decode(UInt8.self), // 8
            try container.decode(UInt8.self),
            try container.decode(UInt8.self),
            try container.decode(UInt8.self),
            try container.decode(UInt8.self),
            try container.decode(UInt8.self),
            try container.decode(UInt8.self),
            try container.decode(UInt8.self),
            try container.decode(UInt8.self), // 16
        )

        let canonical = XXH_NAMESPACEXXH128_canonical_t(digest: digest)
        let hash = withUnsafePointer(to: canonical) { ptr in
            XXH_INLINE_XXH128_hashFromCanonical(ptr)
        }
        self.value = hash
    }

    public func encode(to encoder: any Encoder) throws {
        var canonical: XXH_NAMESPACEXXH128_canonical_t = .init()
        withUnsafeMutablePointer(to: &canonical) { ptr in
            XXH_INLINE_XXH128_canonicalFromHash(ptr, value)
        }

        var container = encoder.unkeyedContainer()
        try container.encode(canonical.digest.0)
        try container.encode(canonical.digest.1)
        try container.encode(canonical.digest.2)
        try container.encode(canonical.digest.3)
        try container.encode(canonical.digest.4)
        try container.encode(canonical.digest.5)
        try container.encode(canonical.digest.6)
        try container.encode(canonical.digest.7)
        try container.encode(canonical.digest.8)
        try container.encode(canonical.digest.9)
        try container.encode(canonical.digest.10)
        try container.encode(canonical.digest.11)
        try container.encode(canonical.digest.12)
        try container.encode(canonical.digest.13)
        try container.encode(canonical.digest.14)
        try container.encode(canonical.digest.15)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(value.high64)
        hasher.combine(value.low64)
    }

    public static func == (lhs: xxHash128Digest, rhs: xxHash128Digest) -> Bool {
        lhs.value.high64 == rhs.value.high64 && lhs.value.low64 == lhs.value.low64
    }
}

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
        withUnsafePointer(to: value.bigEndian) {
            self.combine(UnsafeRawBufferPointer(start: $0, count: 1))
        }
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
        for unit in value { combine(unit) }
    }

    public mutating func combine<T: Collection>(_ value: T) where T.Element == Bool {
        for unit in value { combine(unit) }
    }

    public mutating func combine<T: Collection>(_ value: T) where T.Element == Float {
        for unit in value { combine(unit) }
    }

    public mutating func combine<T: Collection>(_ value: T) where T.Element == Double {
        for unit in value { combine(unit) }
    }

    public mutating func combine<T: Collection>(_ value: T) where T.Element == String {
        for unit in value { combine(unit) }
    }

    public mutating func combine<T: StableHashable>(_ value: T) throws {
        try value.hash(into: &self)
    }

    public mutating func combine(_ digest: xxHash128Digest) {
        combine(digest.value.high64)
        combine(digest.value.low64)
    }

    public consuming func finalize() -> xxHash128Digest {
        let hash = XXH_INLINE_XXH3_128bits_digest(state)
        return xxHash128Digest(hash)
    }

    public static func digest(_ data: ArraySlice<UInt8>) -> xxHash128Digest {
        xxHash128Digest(
            data.withUnsafeBytes({ ptr in
                XXH_INLINE_XXH3_128bits(ptr.baseAddress, ptr.count)
            })
        )
    }
}
