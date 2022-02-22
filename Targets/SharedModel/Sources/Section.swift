import Foundation

// MARK: - Section
public struct Section: Codable {
    public let type: String?
    public let pageType: String?
    public let sectionId: String?
    public let title: String?
    public let sectionDescription: String?
    public let links: Links?

    enum CodingKeys: String, CodingKey {
        case type
        case pageType
        case sectionId
        case title
        case sectionDescription = "description"
        case links = "_links"
    }

    public init(
        type: String?,
        pageType: String?,
        sectionId: String?,
        title: String?,
        sectionDescription: String?,
        links: Links?
    ) {
        self.type = type
        self.pageType = pageType
        self.sectionId = sectionId
        self.title = title
        self.sectionDescription = sectionDescription
        self.links = links
    }
}
