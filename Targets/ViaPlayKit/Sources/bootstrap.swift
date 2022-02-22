import Foundation
import WebClient
import ViaPlayAPI

public extension DIContainer {
    static func bootstrap() -> DIContainer {
        let api = APIClient.viaPlayProd()
        let persistence = PersistenceController.shared

        return .init(
            interactors: .init(
                loadRootPageInteractor: makeLoadRootPageInteractor(
                    withLocal: persistence,
                    api: api
                ),
                getSectionInteractor: makeGetSectionInteractor(
                    withLocal: persistence,
                    api: api
                )
            ),
            api: api,
            persistence: persistence
        )
    }
}
