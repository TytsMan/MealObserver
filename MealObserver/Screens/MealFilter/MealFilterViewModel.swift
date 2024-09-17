//
//  MealFilterViewModel.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Combine
import Foundation
import Networking

extension MealFilterView {
    @Observable
    final class ViewModel {
        struct State: Hashable {
            enum ListState: Hashable {
                case `default`
                case loading
                case items([Meal])
                case empty
                case error(message: String)
            }
            
            static let `default`: Self = .init(searchText: "", listState: .default)
            
            var searchText: String
            var listState: ListState
        }
        
        private var mealFilterService: MealFilterServiceProtocol
        private var searchTextInputSubject = PassthroughSubject<String?, Never>()
        private var cancellables = Set<AnyCancellable>()
        
        var state: State
        
        init(
            mealFilterService: MealFilterServiceProtocol = MealFilterServiceSuccessMock(),
            state: State = .default
        ) {
            self.mealFilterService = mealFilterService
            self.state = state
            self.searchTextInputSubject
                .debounce(for: 0.3, scheduler: RunLoop.main)
                .sink { [weak self] searchInput in
                    self?.fetchItems(with: searchInput)
                }
                .store(in: &cancellables)
        }
        
        func searchTextDidChanged(searchText: String) {
            state.searchText = searchText
            if searchText.isEmpty {
                fetchItems(with: nil)
            } else {
                searchTextInputSubject.send(searchText)
            }
        }
        
        private func fetchItems(with searchText: String?) {
            guard let searchText, !searchText.isEmpty else {
                state.listState = .default
                return
            }
            Task(priority: .userInitiated) {
                let result = await mealFilterService.filterMeals(query: searchText, filterType: .category)
                Task { @MainActor in
                    switch result {
                    case .success(let responce):
                        guard let meals = responce.meals?.compactMap({ $0 }) else {
                            state.listState = .empty
                            return
                        }
                        let sortedMeals = meals
                            .sorted(by: \.name)
                        state.listState = .items(sortedMeals)
                    case .failure(let error):
                        state.listState = .error(message: error.description)
                    }
                }
            }
        }
    }
}
