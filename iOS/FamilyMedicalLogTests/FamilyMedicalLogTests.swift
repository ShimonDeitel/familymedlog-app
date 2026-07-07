import XCTest
@testable import FamilyMedicalLog

@MainActor
final class FamilyMedicalLogTests: XCTestCase {
    func testSeedDataIsBelowFreeLimit() {
        let store = Store()
        XCTAssertLessThan(store.items.count, Store.freeLimit)
    }

    func testAddIncreasesCount() {
        let store = Store()
        let before = store.items.count
        let added = store.add(MedVisit())
        XCTAssertTrue(added)
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testDeleteRemovesItem() {
        let store = Store()
        let item = MedVisit()
        _ = store.add(item)
        let before = store.items.count
        store.delete(item)
        XCTAssertEqual(store.items.count, before - 1)
    }

    func testUpdateModifiesItem() {
        let store = Store()
        let item = MedVisit()
        _ = store.add(item)
        let updated = item
        store.update(updated)
        XCTAssertTrue(store.items.contains(where: { $0.id == item.id }))
    }

    func testFreeLimitBlocksAddWhenReached() {
        let store = Store()
        store.isPro = false
        for _ in 0..<(Store.freeLimit + 5) {
            _ = store.add(MedVisit())
        }
        let result = store.add(MedVisit())
        XCTAssertFalse(result)
        XCTAssertTrue(store.isAtFreeLimit)
    }

    func testProUserNeverHitsLimit() {
        let store = Store()
        store.isPro = true
        for _ in 0..<(Store.freeLimit + 5) {
            _ = store.add(MedVisit())
        }
        XCTAssertFalse(store.isAtFreeLimit)
    }

    func testDeleteAtOffsetsRemovesCorrectItem() {
        let store = Store()
        let before = store.items.count
        store.delete(at: IndexSet(integer: 0))
        XCTAssertEqual(store.items.count, before - 1)
    }
}
