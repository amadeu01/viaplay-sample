import Foundation
import SharedModel
import WebClient
import UIKit

public enum ViaPlayResources {}

// MARK: - Sections

public extension ViaPlayResources {
    static func sections() -> SectionsResource {
        SectionsResource(path: "/ios-se")
    }

    struct SectionsResource {
        public let path: String

        public var get: GetRequest<Content> { .get(path) }
    }
}

// MARK: - Section for URL

public extension ViaPlayResources {
    static func section(for url: String) -> SectionResource {
        SectionResource(url: url)
    }

    struct SectionResource {
        public let url: String

        public init(url: String) {
            self.url = url.removeCurlyBracketsContent()
        }

        public var get: GetRequest<Section> { .get(url) }
    }
}

private extension String {
    func removeCurlyBracketsContent() -> String {
        let pattern = #"\{[\s\S]*\}"#
        let regex = try! NSRegularExpression(pattern: pattern)

        return regex.stringByReplacingMatches(
            in: self,
            withTemplate: #""#
        )
    }
}

private extension NSRegularExpression {
    func stringByReplacingMatches(
        in string: String,
        withTemplate template: String
    ) -> String {
        let range = NSRange.init(string.startIndex..<string.endIndex, in: string)
        return self.stringByReplacingMatches(
            in: string,
            options: [],
            range: range,
            withTemplate: template
        )
    }
}
