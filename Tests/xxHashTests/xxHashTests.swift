//
//  xxHashTests.swift
//  xxHash
//
//  Copyright (C) 2025  Khan Winter
//  See the LICENSE file distributed with this program for applicable license and warranty.
//

import Testing
import Foundation
@testable import xxHash

@Suite("xxHash128 Tests")
struct xxHash128Tests {

    @Suite("Combine Methods")
    struct CombineMethods {

        @Test("Combine UnsafeRawBufferPointer")
        func combineUnsafeRawBufferPointer() {
            let data: [UInt8] = [1, 2, 3, 4, 5]

            var hasher1 = xxHash128()
            data.withUnsafeBytes { buffer in
                hasher1.combine(buffer)
            }
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            data.withUnsafeBytes { buffer in
                hasher2.combine(buffer)
            }
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }

        @Test("Combine ArraySlice<UInt8>")
        func combineArraySlice() {
            let data: ArraySlice<UInt8> = [1, 2, 3, 4, 5][1...3]

            var hasher1 = xxHash128()
            hasher1.combine(data)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(data)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }

        @Test("Combine [UInt8]")
        func combineUInt8Array() {
            let data: [UInt8] = [1, 2, 3, 4, 5]

            var hasher1 = xxHash128()
            hasher1.combine(data)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(data)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }

        @Test("Combine FixedWidthInteger")
        func combineFixedWidthInteger() {
            let value: UInt64 = 12345

            var hasher1 = xxHash128()
            hasher1.combine(value)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(value)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }

        @Test("Combine Bool")
        func combineBool() {
            var hasher1 = xxHash128()
            hasher1.combine(true)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(true)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)

            var hasher3 = xxHash128()
            hasher3.combine(false)
            let digest3 = hasher3.finalize()

            #expect(digest1 != digest3)
        }

        @Test("Combine Float")
        func combineFloat() {
            let value: Float = 3.14159

            var hasher1 = xxHash128()
            hasher1.combine(value)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(value)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }

        @Test("Combine Double")
        func combineDouble() {
            let value: Double = 3.141592653589793

            var hasher1 = xxHash128()
            hasher1.combine(value)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(value)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }

        @Test("Combine String")
        func combineString() {
            let value = "Hello, World!"

            var hasher1 = xxHash128()
            hasher1.combine(value)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(value)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }

        @Test("Combine Collection of FixedWidthInteger")
        func combineFixedWidthIntegerCollection() {
            let values: [UInt32] = [1, 2, 3, 4, 5]

            var hasher1 = xxHash128()
            hasher1.combine(values)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(values)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }

        @Test("Combine Collection of Bool")
        func combineBoolCollection() {
            let values: [Bool] = [true, false, true, false]

            var hasher1 = xxHash128()
            hasher1.combine(values)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(values)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }

        @Test("Combine Collection of Float")
        func combineFloatCollection() {
            let values: [Float] = [1.0, 2.5, 3.14159, 4.0]

            var hasher1 = xxHash128()
            hasher1.combine(values)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(values)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }

        @Test("Combine Collection of Double")
        func combineDoubleCollection() {
            let values: [Double] = [1.0, 2.5, 3.141592653589793, 4.0]

            var hasher1 = xxHash128()
            hasher1.combine(values)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(values)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }

        @Test("Combine Collection of String")
        func combineStringCollection() {
            let values: [String] = ["Hello", "World", "Swift", "Testing"]

            var hasher1 = xxHash128()
            hasher1.combine(values)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(values)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }

        @Test("Combine xxHash128Digest")
        func combineDigest() {
            let originalDigest = xxHash128.digest([1, 2, 3, 4, 5])

            var hasher1 = xxHash128()
            hasher1.combine(originalDigest)
            let digest1 = hasher1.finalize()

            var hasher2 = xxHash128()
            hasher2.combine(originalDigest)
            let digest2 = hasher2.finalize()

            #expect(digest1 == digest2)
        }
    }

    @Suite("Static Digest Methods")
    struct StaticDigestMethods {

        @Test("Digest UnsafeRawBufferPointer")
        func digestUnsafeRawBufferPointer() {
            let data: [UInt8] = [1, 2, 3, 4, 5]

            let digest1 = data.withUnsafeBytes { buffer in
                xxHash128.digest(buffer)
            }
            let digest2 = data.withUnsafeBytes { buffer in
                xxHash128.digest(buffer)
            }

            #expect(digest1 == digest2)
        }

        @Test("Digest ArraySlice<UInt8>")
        func digestArraySlice() {
            let data: ArraySlice<UInt8> = [1, 2, 3, 4, 5][1...3]

            let digest1 = xxHash128.digest(data)
            let digest2 = xxHash128.digest(data)

            #expect(digest1 == digest2)
        }

        @Test("Digest [UInt8]")
        func digestUInt8Array() {
            let data: [UInt8] = [1, 2, 3, 4, 5]

            let digest1 = xxHash128.digest(data)
            let digest2 = xxHash128.digest(data)

            #expect(digest1 == digest2)
        }

        @Test("Digest FixedWidthInteger")
        func digestFixedWidthInteger() {
            let value: UInt64 = 12345

            let digest1 = xxHash128.digest(value)
            let digest2 = xxHash128.digest(value)

            #expect(digest1 == digest2)
        }

        @Test("Digest Bool")
        func digestBool() {
            let digest1 = xxHash128.digest(true)
            let digest2 = xxHash128.digest(true)
            let digest3 = xxHash128.digest(false)

            #expect(digest1 == digest2)
            #expect(digest1 != digest3)
        }

        @Test("Digest Float")
        func digestFloat() {
            let value: Float = 3.14159

            let digest1 = xxHash128.digest(value)
            let digest2 = xxHash128.digest(value)

            #expect(digest1 == digest2)
        }

        @Test("Digest Double")
        func digestDouble() {
            let value: Double = 3.141592653589793

            let digest1 = xxHash128.digest(value)
            let digest2 = xxHash128.digest(value)

            #expect(digest1 == digest2)
        }

        @Test("Digest String")
        func digestString() {
            let value = "Hello, World!"

            let digest1 = xxHash128.digest(value)
            let digest2 = xxHash128.digest(value)

            #expect(digest1 == digest2)
        }

        @Test("Digest Collection of FixedWidthInteger")
        func digestFixedWidthIntegerCollection() {
            let values: [UInt32] = [1, 2, 3, 4, 5]

            let digest1 = xxHash128.digest(values)
            let digest2 = xxHash128.digest(values)

            #expect(digest1 == digest2)
        }

        @Test("Digest Collection of Bool")
        func digestBoolCollection() {
            let values: [Bool] = [true, false, true, false]

            let digest1 = xxHash128.digest(values)
            let digest2 = xxHash128.digest(values)

            #expect(digest1 == digest2)
        }

        @Test("Digest Collection of Float")
        func digestFloatCollection() {
            let values: [Float] = [1.0, 2.5, 3.14159, 4.0]

            let digest1 = xxHash128.digest(values)
            let digest2 = xxHash128.digest(values)

            #expect(digest1 == digest2)
        }

        @Test("Digest Collection of Double")
        func digestDoubleCollection() {
            let values: [Double] = [1.0, 2.5, 3.141592653589793, 4.0]

            let digest1 = xxHash128.digest(values)
            let digest2 = xxHash128.digest(values)

            #expect(digest1 == digest2)
        }

        @Test("Digest Collection of String")
        func digestStringCollection() {
            let values: [String] = ["Hello", "World", "Swift", "Testing"]

            let digest1 = xxHash128.digest(values)
            let digest2 = xxHash128.digest(values)

            #expect(digest1 == digest2)
        }

        @Test("Digest xxHash128Digest")
        func digestHashDigest() {
            let originalDigest = xxHash128.digest([1, 2, 3, 4, 5])

            let digest1 = xxHash128.digest(originalDigest)
            let digest2 = xxHash128.digest(originalDigest)

            #expect(digest1 == digest2)
        }
    }

    @Suite("Consistency Between Combine and Digest")
    struct ConsistencyTests {

        @Test("UInt8 Array Consistency")
        func uint8ArrayConsistency() {
            let data: [UInt8] = [1, 2, 3, 4, 5]

            var hasher = xxHash128()
            hasher.combine(data)
            let combineDigest = hasher.finalize()

            let digestResult = xxHash128.digest(data)

            #expect(combineDigest == digestResult)
        }

        @Test("ArraySlice Consistency")
        func arraySliceConsistency() {
            let data: ArraySlice<UInt8> = [1, 2, 3, 4, 5][1...3]

            var hasher = xxHash128()
            hasher.combine(data)
            let combineDigest = hasher.finalize()

            let digestResult = xxHash128.digest(data)

            #expect(combineDigest == digestResult)
        }

        @Test("FixedWidthInteger Consistency")
        func fixedWidthIntegerConsistency() {
            let value: UInt64 = 12345

            var hasher = xxHash128()
            hasher.combine(value)
            let combineDigest = hasher.finalize()

            let digestResult = xxHash128.digest(value)

            #expect(combineDigest == digestResult)
        }

        @Test("Bool Consistency")
        func boolConsistency() {
            var hasher1 = xxHash128()
            hasher1.combine(true)
            let combineDigest1 = hasher1.finalize()

            let digestResult1 = xxHash128.digest(true)

            #expect(combineDigest1 == digestResult1)

            var hasher2 = xxHash128()
            hasher2.combine(false)
            let combineDigest2 = hasher2.finalize()

            let digestResult2 = xxHash128.digest(false)

            #expect(combineDigest2 == digestResult2)
        }

        @Test("Float Consistency")
        func floatConsistency() {
            let value: Float = 3.14159

            var hasher = xxHash128()
            hasher.combine(value)
            let combineDigest = hasher.finalize()

            let digestResult = xxHash128.digest(value)

            #expect(combineDigest == digestResult)
        }

        @Test("Double Consistency")
        func doubleConsistency() {
            let value: Double = 3.141592653589793

            var hasher = xxHash128()
            hasher.combine(value)
            let combineDigest = hasher.finalize()

            let digestResult = xxHash128.digest(value)

            #expect(combineDigest == digestResult)
        }

        @Test("String Consistency")
        func stringConsistency() {
            let value = "Hello, World!"

            var hasher = xxHash128()
            hasher.combine(value)
            let combineDigest = hasher.finalize()

            let digestResult = xxHash128.digest(value)

            #expect(combineDigest == digestResult)
        }

        @Test("Collection Consistency")
        func collectionConsistency() {
            let values: [UInt32] = [1, 2, 3, 4, 5]

            var hasher = xxHash128()
            hasher.combine(values)
            let combineDigest = hasher.finalize()

            let digestResult = xxHash128.digest(values)

            #expect(combineDigest == digestResult)
        }

        @Test("Digest Consistency")
        func digestConsistency() {
            let originalDigest = xxHash128.digest([1, 2, 3, 4, 5])

            var hasher = xxHash128()
            hasher.combine(originalDigest)
            let combineDigest = hasher.finalize()

            let digestResult = xxHash128.digest(originalDigest)

            #expect(combineDigest == digestResult)
        }
    }

    @Suite("Edge Cases")
    struct EdgeCases {

        @Test("Empty Arrays")
        func emptyArrays() {
            let emptyUInt8: [UInt8] = []
            let emptySlice: ArraySlice<UInt8> = [][...]

            let digest1 = xxHash128.digest(emptyUInt8)
            let digest2 = xxHash128.digest(emptySlice)

            #expect(digest1 == digest2)
        }

        @Test("Empty String")
        func emptyString() {
            let digest1 = xxHash128.digest("")
            let digest2 = xxHash128.digest("")

            #expect(digest1 == digest2)
        }

        @Test("Large Collections")
        func largeCollections() {
            let largeArray = Array(0..<10000)

            let digest1 = xxHash128.digest(largeArray)
            let digest2 = xxHash128.digest(largeArray)

            #expect(digest1 == digest2)
        }
    }

    @Suite("Benchmarks")
    struct Benchmarks {
        @inline(never)
        func blackHole<T>(_ x: T) {}

        @Test("UInt64 Speed Test")
        func speedTest() {
            var info = mach_timebase_info()
            guard mach_timebase_info(&info) == KERN_SUCCESS else { return }
            let start = mach_absolute_time()

            for _ in 0..<1_000_000 {
                blackHole(xxHash128.digest(UInt64(1234)))
            }

            let end = mach_absolute_time()
            let elapsed = end - start
            let nanos = elapsed * UInt64(info.numer) / UInt64(info.denom)
            let msec = TimeInterval(nanos) / TimeInterval(NSEC_PER_MSEC)
            let sec = TimeInterval(nanos) / TimeInterval(NSEC_PER_SEC)

            let formatter = NumberFormatter()
            formatter.numberStyle = .scientific
            formatter.positiveFormat = "0.###E+0"
            formatter.exponentSymbol = "e"

            print("\(msec)ms, \(formatter.string(from: NSNumber(value: (1.0 / sec) * 1_000_000)) ?? "")/second")
        }

        @Test("UInt8 Speed Test")
        func byteSpeedTest() {
            var info = mach_timebase_info()
            guard mach_timebase_info(&info) == KERN_SUCCESS else { return }
            let start = mach_absolute_time()

            for _ in 0..<1_000_000 {
                blackHole(xxHash128.digest(UInt8(12)))
            }

            let end = mach_absolute_time()
            let elapsed = end - start
            let nanos = elapsed * UInt64(info.numer) / UInt64(info.denom)
            let msec = TimeInterval(nanos) / TimeInterval(NSEC_PER_MSEC)
            let sec = TimeInterval(nanos) / TimeInterval(NSEC_PER_SEC)

            let formatter = NumberFormatter()
            formatter.numberStyle = .scientific
            formatter.positiveFormat = "0.###E+0"
            formatter.exponentSymbol = "e"

            print("\(msec)ms, \(formatter.string(from: NSNumber(value: (1.0 / sec) * 1_000_000)) ?? "")/second")
        }
    }
}
