import Testing
@testable import xxHash

@Test func testHash() {
    var hasher = xxHash128()
    hasher.combine(1234)
    let digest = hasher.finalize()

    var hasher2 = xxHash128()
    hasher2.combine(1234)
    let digest2 = hasher2.finalize()

    #expect(digest == digest2)
}

@Test func testOneOff() {
    #expect(xxHash128.digest([12]) == xxHash128.digest([12]))
}
