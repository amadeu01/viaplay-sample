import Foundation
import CoreData
import SharedModel

@objc(LocalLinkSection)
public class LocalLinkSection: NSManagedObject {

}

public extension LocalLinkSection {

    static func create(
        with context: NSManagedObjectContext,
        fromRemote section: Links.Section
    ) -> LocalLinkSection {
        let localSection = LocalLinkSection(context: context)
        localSection.id = section.id
        localSection.title = section.title
        localSection.url = section.href
        localSection.type = section.type
        localSection.name = section.name
        try? context.save()

        return localSection
    }
}
