import Foundation
import XCTest
@testable import ViaPlayKit
import ViaPlayAPI
import CoreData
import Mocker
import SnapshotTesting
import SharedModel

final class LoadRootPageInteractorTests: XCTestCase {
    private static let local = PersistenceController(inMemory: true)
    private var api: ViaPlayAPIClient!

    private var subject: LoadRootPageInteractor!

    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        self.api = .viaPlayProd(configuration: configuration)
        isRecording = false

        self.subject = makeLoadRootPageInteractor(
            withLocal: Self.local,
            api: self.api
        )
    }

    override func tearDown() {
        Self.local.container.viewContext.reset()
    }

    func test_CallRemote_WhenAttemptToFetch() async throws {
        let expectation = self.expectation(description: #function)
        stubRootPageApiCall { expectation.fulfill() }

        let result = try await self.subject()

        wait(for: [expectation], timeout: 0.1)

        assertSnapshot(matching: result, as: .dump)
    }

    func test_SaveLocally_AfterFetchFromRemote() async throws {
        self.stubRootPageApiCall()

        let _ = try await self.subject()

        let result = try Self.local.container.viewContext.fetch(LocalLinkSection.fetchRequest())

        let expectedIds = ["35bb8a90-d40e-11e2-8b8b-0800200c9a66",
                     "2037b330-d411-11e2-8b8b-0800200c9a66",
                     "8e5febf0-d4e0-11e2-8b8b-0800200c9a66",
                     "1a6a2ec0-d4e2-11e2-8b8b-0800200c9a66"].sorted()



        XCTAssertEqual(result.compactMap { $0.id }.sorted(), expectedIds)
    }

    func test_ReturnLocally_WhenFailsFromRemote() async throws {
        let localSection = LocalLinkSection(context: Self.local.container.viewContext)
        localSection.id = "10"
        localSection.title = "test"
        localSection.name = #function

        stubFailRootPageApiCall()

        let result = try await self.subject()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, localSection.id)
        XCTAssertEqual(result.first?.title, localSection.title)
        XCTAssertEqual(result.first?.name, localSection.name)
    }

    private func stubRootPageApiCall(_ onRequest: @escaping () -> Void = {}) {
        let featureURL = URL(string: "https://content.viaplay.se/ios-se")!

        var mock = Mock(url: featureURL, dataType: .json, statusCode: 200, data: [
            .get : rootPageResponse.data(using: .utf8)!
        ])

        mock.onRequest = { _, _ in onRequest() }

        mock.register()
    }

    private func stubFailRootPageApiCall(_ onRequest: @escaping () -> Void = {}) {
        let featureURL = URL(string: "https://content.viaplay.se/ios-se")!

        var mock = Mock(url: featureURL, dataType: .json, statusCode: 500, data: [
            .get : "".data(using: .utf8)!
        ])

        mock.onRequest = { _, _ in onRequest() }

        mock.register()
    }
}
