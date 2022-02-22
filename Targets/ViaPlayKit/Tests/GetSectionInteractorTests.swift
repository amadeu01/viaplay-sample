import Foundation
import XCTest
@testable import ViaPlayKit
import ViaPlayAPI
import CoreData
import Mocker
import SnapshotTesting
import SharedModel

final class GetSectionInteractorTests: XCTestCase {
    private static let local = PersistenceController(inMemory: true)
    private var api: ViaPlayAPIClient!

    private var subject: GetSectionInteractor!

    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        self.api = .viaPlayProd(configuration: configuration)
        isRecording = false

        self.subject = makeGetSectionInteractor(
            withLocal: Self.local,
            api: self.api
        )
    }

    override func tearDown() {
        Self.local.container.viewContext.reset()
    }

    func test_CallRemote_WhenAttemptToFetch() async throws {
        let expectation = self.expectation(description: #function)
        let url = "https://content.viaplay.se/ios-se/serier{?dtg}"
        let mockSection = Links.Section(id: "1", title: "Title", href: url)
        stubSectionPageApiCall { expectation.fulfill() }

        let result = try await self.subject(mockSection)

        wait(for: [expectation], timeout: 0.1)

        assertSnapshot(matching: result, as: .dump)
    }

    func test_SaveLocally_AfterFetchFromRemote() async throws {
        self.stubSectionPageApiCall()
        let url = "https://content.viaplay.se/ios-se/serier{?dtg}"
        let mockSection = Links.Section(id: "1", title: "Title", href: url)

        let _ = try await self.subject(mockSection)

        let result = try Self.local.container.viewContext.fetch(LocalSection.fetchRequest())

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, "2037b330-d411-11e2-8b8b-0800200c9a66")
        XCTAssertEqual(result.first?.title, "Film på nätet - Streama film online eller ladda ned")
    }

    func test_ReturnLocally_WhenFailsFromRemote() async throws {
        let localSection = LocalSection(context: Self.local.container.viewContext)
        localSection.id = "10"
        localSection.title = "test"
        localSection.sectionDescription = #function
        let url = "https://content.viaplay.se/ios-se/serier{?dtg}"
        let mockSection = Links.Section(id: "10", title: "test", href: url)

        stubFailSectionPageApiCall()

        let result = try await self.subject(mockSection)

        XCTAssertEqual(result.sectionId, localSection.id)
        XCTAssertEqual(result.title, localSection.title)
        XCTAssertEqual(result.sectionDescription, localSection.sectionDescription)
    }

    private func stubSectionPageApiCall(_ onRequest: @escaping () -> Void = {}) {
        let featureURL = URL(string: "https://content.viaplay.se/ios-se/serier")!

        var mock = Mock(url: featureURL, dataType: .json, statusCode: 200, data: [
            .get : sectionResponse.data(using: .utf8)!
        ])

        mock.onRequest = { _, _ in onRequest() }

        mock.register()
    }

    private func stubFailSectionPageApiCall(_ onRequest: @escaping () -> Void = {}) {
        let featureURL = URL(string: "https://content.viaplay.se/ios-se/serier")!

        var mock = Mock(url: featureURL, dataType: .json, statusCode: 500, data: [
            .get : "".data(using: .utf8)!
        ])

        mock.onRequest = { _, _ in onRequest() }

        mock.register()
    }
}
