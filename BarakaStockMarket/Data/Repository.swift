//
//  Repository.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 26/03/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol RepositoryProcotol {
    func get<T: Codable>(url: String, model: T.Type) -> Observable<Result<T, Error>>
    
}


class RemoteRepository: RepositoryProcotol {
    private let network = Injection.container.resolve(Network.self)!
    private let mapper = Injection.container.resolve(DataMapper.self)!
    private let disposeData = DisposeBag()
    
    func get<T: Codable>(url: String, model: T.Type) -> Observable<Result<T, Error>> {
        let observer = network.get(url: url)
        return mapper.mapData(observable: observer, model: model)
    }
    
}
