

import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

private func parent2(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class HomeDependencycad225e9266b3c9a56ddProvider: HomeDependency {
    var homeViewModel: HomeViewModel {
        return rootComponent.homeViewModel
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->HomeComponent
private func factory7cf6ef49229ffaf97a15b3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return HomeDependencycad225e9266b3c9a56ddProvider(rootComponent: parent1(component) as! RootComponent)
}
private class SearchDependencya546fa091725a874661bProvider: SearchDependency {
    var searchViewModel: SearchViewModel {
        return rootComponent.searchViewModel
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->HomeComponent->SearchComponent
private func factoryffc6f7a94ad32d986012a9403e3301bb54f80df0(_ component: NeedleFoundation.Scope) -> AnyObject {
    return SearchDependencya546fa091725a874661bProvider(rootComponent: parent2(component) as! RootComponent)
}
private class DetailsDependencyba0153f2a5214384a8b6Provider: DetailsDependency {
    var animeRepository: AnimeRepository {
        return rootComponent.animeRepository
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->HomeComponent->DetailsComponent
private func factoryc3ef8f560d34c88a0609a9403e3301bb54f80df0(_ component: NeedleFoundation.Scope) -> AnyObject {
    return DetailsDependencyba0153f2a5214384a8b6Provider(rootComponent: parent2(component) as! RootComponent)
}

#else
extension RootComponent: Registration {
    public func registerItems() {

        localTable["homeViewModel-HomeViewModel"] = { [unowned self] in self.homeViewModel as Any }
        localTable["animeRepository-AnimeRepository"] = { [unowned self] in self.animeRepository as Any }
        localTable["searchViewModel-SearchViewModel"] = { [unowned self] in self.searchViewModel as Any }
    }
}
extension HomeComponent: Registration {
    public func registerItems() {
        keyPathToName[\HomeDependency.homeViewModel] = "homeViewModel-HomeViewModel"

    }
}
extension SearchComponent: Registration {
    public func registerItems() {
        keyPathToName[\SearchDependency.searchViewModel] = "searchViewModel-SearchViewModel"
    }
}
extension DetailsComponent: Registration {
    public func registerItems() {
        keyPathToName[\DetailsDependency.animeRepository] = "animeRepository-AnimeRepository"
    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->RootComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->RootComponent->HomeComponent", factory7cf6ef49229ffaf97a15b3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent->HomeComponent->SearchComponent", factoryffc6f7a94ad32d986012a9403e3301bb54f80df0)
    registerProviderFactory("^->RootComponent->HomeComponent->DetailsComponent", factoryc3ef8f560d34c88a0609a9403e3301bb54f80df0)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
