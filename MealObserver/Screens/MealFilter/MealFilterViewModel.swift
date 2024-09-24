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
        
        private var mealRepository: MealFilterRepository
        private var searchTextInputSubject = PassthroughSubject<String?, Never>()
        private var cancellables = Set<AnyCancellable>()
        
        var state: State
        
        init(
            mealRepository: MealFilterRepository = RemoteMealRepository.mock,
            state: State = .default
        ) {
            self.mealRepository = mealRepository
            self.state = state
            self.searchTextInputSubject
                .debounce(for: 0.5, scheduler: RunLoop.main)
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
            state.listState = .loading
            Task(priority: .background) { [weak self] in
                guard let self else { return }
                let result = await mealRepository.filterMeals(query: searchText)
                Task { @MainActor [weak self] in
                    guard let self else { return }
                    switch result {
                    case .success(let meals):
                        let meals = meals.compactMap({ $0 })
                        guard !meals.isEmpty else {
                            state.listState = .empty
                            return
                        }
                        let sortedMeals = meals
                            .sorted(by: \.name)
                        state.listState = .items(sortedMeals)
                    case .failure(let error):
                        state.listState = .error(message: error.localizedDescription)
                    }
                }
            }
        }
    }
}
