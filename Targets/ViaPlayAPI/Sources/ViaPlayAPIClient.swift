import Foundation
import WebClient
import SharedModel

public typealias ViaPlayAPIClient = APIClient

public extension APIClient {
    static func viaPlayProd(
        configuration: URLSessionConfiguration = .default
    ) -> APIClient {
        return .init(
            host: "content.viaplay.se",
            configuration: configuration
        )
    }
}

public extension APIClient {
    func loadRootPage() async throws -> [Links.Section] {
        try await self.send(
            ViaPlayResources.sections().get
        ).links?.sections ?? []
    }

    func loadSection(for section: Links.Section) async throws -> Section {
        guard let url = section.href else {
            throw URLError(.badURL)
        }

        return try await self.send(
            ViaPlayResources.section(for: url).get
        )
    }
}
