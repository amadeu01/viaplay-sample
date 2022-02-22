import Foundation
import CoreData


extension LocalLinkSection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalLinkSection> {
        return NSFetchRequest<LocalLinkSection>(entityName: "LocalLinkSection")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?
}
