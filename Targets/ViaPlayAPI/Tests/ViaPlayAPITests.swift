import Foundation
import XCTest
@testable import ViaPlayAPI
import Mocker
import Difference
import SharedModel
import SnapshotTesting

final class ViaPlayAPITests: XCTestCase {
    var client: ViaPlayAPIClient!

    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        self.client = .viaPlayProd(configuration: configuration)
        isRecording = false
    }

    func test_SectionsResource() async throws {
        self.stubRootPageApiCall()

        let content = try await client.loadRootPage()

        assertSnapshot(matching: content, as: .dump)
    }

    private func stubRootPageApiCall() {
        let featureURL = URL(string: "https://content.viaplay.se/ios-se")!

        let mock = Mock(url: featureURL, dataType: .json, statusCode: 200, data: [
            .get : rootPageResponse.data(using: .utf8)!
        ])

        mock.register()
    }

    func test_SectionResource() async throws {
        let url = "https://content.viaplay.se/ios-se/serier"
        self.stubSectionApiCall(for: url)

        let content = try await client.loadSection(
            for: Links.Section(id: "1", title: "", href: "\(url){?something}")
        )

        assertSnapshot(matching: content, as: .dump)
    }

    private func stubSectionApiCall(
        for url: String
    ) {
        let featureURL = URL(string: url)!

        let mock = Mock(url: featureURL, dataType: .json, statusCode: 200, data: [
            .get : sectionResponse.data(using: .utf8)!
        ])

        mock.register()
    }
}




