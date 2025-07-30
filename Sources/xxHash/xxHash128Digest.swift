//
//  xxHash128Digest.swift
//  xxHash
//
//  Created by Khan Winter on 7/30/25.
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
