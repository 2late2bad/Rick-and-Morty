//
//  LastPageValidationUseCase.swift
//  Rick&Morty
//
//  Created by Alexander V. on 08.11.2023.
//

protocol LastPageValidationUseCase {
    var lastpage: Bool { get }
    mutating func updateLastPage(itemsCount: Int)
    func checkAndLoadMoreItems(row: Int, actualItems: Int, action: () -> Void)
}

struct LastPageValidationUseCaseImp: LastPageValidationUseCase {
    
    /// Лимит ячейки с конца для старта загрузки новой страницы
    private var threshold = 5
    
    var lastpage: Bool = false
    
    mutating func updateLastPage(itemsCount: Int) {
        if itemsCount == Int.zero {
            lastpage = true
        }
    }
    
    func checkAndLoadMoreItems(row: Int, actualItems: Int, action: () -> Void) {
        guard !lastpage else { return }
        let limit = actualItems - threshold
        if limit == row {
            action()
        }
    }
}
