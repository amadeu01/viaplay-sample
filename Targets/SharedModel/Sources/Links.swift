import Foundation

public struct Links: Codable {
    public let sections: [Section]?

    public init(
        sections: [Links.Section]?
    ) {
        self.sections = sections
    }

    enum CodingKeys: String, CodingKey {
        case sections = "viaplay:sections"
    }

    public struct Section: Identifiable, Hashable, Codable {
        public let id: String
        public let title: String?
        public let href: String?
        public let type: String?
        public let name: String?
        public let templated, active: Bool?

        public init(
            id: String,
            title: String?,
            href: String?,
            type: String? = "",
            name: String? = "",
            templated: Bool? = false,
            active: Bool? = false
        ) {
            self.id = id
            self.title = title
            self.href = href
            self.type = type
            self.name = name
            self.templated = templated
            self.active = active
        }
    }
}
