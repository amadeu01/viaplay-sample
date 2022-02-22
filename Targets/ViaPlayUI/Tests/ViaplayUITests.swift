import Foundation
import XCTest
import SnapshotTesting
import ViaPlayUI

// Run this test with iPhone 13 mini
// iOS 15.2
// Otherwise the test will break
final class ViaplayUITests: XCTestCase {

    override func setUp() {
        isRecording = false
    }

    func test_RootView_When_IsLoading() {
        let view = RootView(content: .isLoading)
        assertSnapshot(
            matching: view,
            as: .image(
                layout: .device(config: .iPhoneSe),
                traits: .init(userInterfaceStyle: .light)
            ),
            named: "device"
        )
    }

    func test_RootView_When_IsLoaded() {
        let view = RootView(content: .loaded([.mock]))
        assertSnapshot(
            matching: view,
            as: .image(
                layout: .device(config: .iPhoneSe),
                traits: .init(userInterfaceStyle: .light)
            ),
            named: "device"
        )
    }


    func test_SectionView_When_IsLoading() {
        let view = SectionView(section: .mock, content: .isLoading)
        assertSnapshot(
            matching: view,
            as: .image(
                layout: .device(config: .iPhoneSe),
                traits: .init(userInterfaceStyle: .light)
            ),
            named: "device"
        )
    }

    func test_SectionView_When_IsLoaded() {
        let view = SectionView(section: .mock, content: .loaded(.mock))
        assertSnapshot(
            matching: view,
            as: .image(
                layout: .device(config: .iPhoneSe),
                traits: .init(userInterfaceStyle: .light)
            ),
            named: "device"
        )
    }
}
