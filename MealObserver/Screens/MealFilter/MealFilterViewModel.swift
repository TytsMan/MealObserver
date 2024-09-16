//
//  MealFilterViewModel.swift
//  MealObserver
//
//  Created by divan on 9/15/24.
//

import Foundation
import Combine
import Networking

extension MealFilterView {
    
    @Observable
    final class ViewModel {
        
        enum ListState {
            case `default`
            case loading
            case items([Meal])
            case error(message: String)
        }
        
        private var mealFilterService: MealFilterServiceProtocol
        private var searchTextInputSubject = PassthroughSubject<String?, Never>()
        private var cancellables = Set<AnyCancellable>()
        
        var listState: ListState = .default
        
        init(
            mealFilterService: MealFilterServiceProtocol = MealFilterServiceSuccessMock()
        ) {
            self.mealFilterService = mealFilterService
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
                listState = .default
                return
            }
            let result = await mealFilterService.filterMeals(query: searchText, filterType: .category)
            switch result {
            case .success(let responce):
                listState = .items(responce.meals)
            case .failure(let error):
                listState = .error(message: error.description)
            }
        }
    }
}
