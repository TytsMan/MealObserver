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
                    Task { [weak self] in
                        await self?.fetchItems(with: searchInput)
                    }
                }
                .store(in: &cancellables)
        }
        
        func searchTextDidChanged(searchText: String) {
            state.searchText = searchText
            if searchText.isEmpty {
                Task {
                    await fetchItems(with: nil)
                }
            } else {
                searchTextInputSubject.send(searchText)
            }
        }
        
        private func fetchItems(with searchText: String?) async {
            guard let searchText, !searchText.isEmpty else {
                state.listState = .default
                return
            }
            let result = await mealFilterService.filterMeals(query: searchText, filterType: .category)
            switch result {
            case .success(let responce):
                guard let meals = responce.meals else {
                    state.listState = .empty
                    return
                }
                state.listState = .items(meals)
            case .failure(let error):
                state.listState = .error(message: error.description)
            }
        }
    }
}
