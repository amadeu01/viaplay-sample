import Foundation

// MARK: - Content
public struct Content: Codable {
    public let type: String?
    public let pageType: String?
    public let title: String?
    public let contentDescription: String?
    public let links: Links?

    public init(
        type: String?,
        pageType: String?,
        title: String?,
        contentDescription: String?,
        links: Links?
    ) {
        self.type = type
        self.pageType = pageType
        self.title = title
        self.contentDescription = contentDescription
        self.links = links
    }

    enum CodingKeys: String, CodingKey {
        case type
        case pageType
        case title
        case contentDescription = "description"
        case links = "_links"
    }
}
