import Foundation
import ViaPlayAPI
import SharedModel
import CoreData

public typealias LoadRootPageInteractor = () async throws -> [Links.Section]

func makeLoadRootPageInteractor(
    withLocal localPersistence: PersistenceController,
    api: ViaPlayAPIClient
) -> LoadRootPageInteractor {
    return {
        let localSections = (try? localPersistence.container.viewContext.fetch(LocalLinkSection.fetchRequest())) ?? []
        if localSections.isEmpty {
            return try await fetch(from: api, andUpdateAt: localPersistence)
        } else {
            Task(priority: .background) {
                try? await fetch(from: api, andUpdateAt: localPersistence)
            }
        }

        return localSections.map {
            Links.Section(
                id: $0.id ?? "",
                title: $0.title,
                href: $0.url,
                type: $0.type,
                name: $0.name
            )
        }
    }
}

private func fetch(
    from api: ViaPlayAPIClient,
    andUpdateAt localPersistence: PersistenceController
) async throws -> [Links.Section] {
    let remoteSections = try await api.loadRootPage()

    if let deleteRequest = try? NSBatchDeleteRequest(fetchRequest: LocalLinkSection.fetchRequest()) {
        let result = try? localPersistence.container.viewContext.execute(deleteRequest)
    }

    remoteSections.forEach {
        let _ = LocalLinkSection.create(
            with: localPersistence.container.viewContext,
            fromRemote: $0
        )
    }

    return remoteSections
}
