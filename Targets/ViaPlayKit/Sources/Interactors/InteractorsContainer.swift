import SharedModel
import ViaPlayAPI

extension DIContainer {
    public struct Interactors {
        public let loadRootPageInteractor: LoadRootPageInteractor
        public let getSectionInteractor: GetSectionInteractor

        public init(
            loadRootPageInteractor: @escaping LoadRootPageInteractor,
            getSectionInteractor: @escaping GetSectionInteractor
        ) {
            self.loadRootPageInteractor = loadRootPageInteractor
            self.getSectionInteractor = getSectionInteractor
        }
    }
}



