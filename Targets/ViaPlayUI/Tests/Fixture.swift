import Foundation
import SharedModel


public extension Content {
    static var mock: Content {
        .init(
            type: "page",
            pageType: "root",
            title: "Viaplay - Streama TV, Serier, Film och Sport online",
            contentDescription: "Hyr filmer på nätet och se live sport som fotboll och Premier League. Viaplay har alla TV serier och kanaler online.",
            links: .mock
        )
    }
}

public extension Section {
    static var mock: Section {
        .init(
            type: "page",
            pageType: "section",
            sectionId: "037b330-d411-11e2-8b8b-0800200c9a",
            title: "Film på nätet - Streama film online eller ladda ned",
            sectionDescription: "Viaplay erbjuder film på nätet för hela familjen. Streama filmer online i hög kvalitet eller ladda ned till tablet eller mobil!",
            links: .mock
        )
    }
}

extension Links {
    static var mock: Links {
        .init(sections: [
            .init(
                id: "1",
                title: "Title",
                href: "https://content.viaplay.se/ios-se{?dtg}"
            ),
            .init(
                id: "12",
                title: "Title 1",
                href: "https://content.viaplay.se/ios-se/editorial{?dtg}"
            ),
            .init(id: "14", title: "Title 2", href: ""),
            .init(id: "16", title: "Title 3", href: ""),
            .init(id: "19", title: "Title 412", href: "")
        ])
    }
}

extension Links.Section {
    static var mock: Self {
        .init(
            id: "RandomID",
            title: "Editorial",
            href: "https://content.viaplay.se/ios-se/editorial{?dtg}",
            type: "section",
            name: "Name",
            templated: false,
            active: false
        )
    }
}
