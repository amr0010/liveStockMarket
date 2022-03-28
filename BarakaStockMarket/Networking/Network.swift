//
//  Network.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 26/03/2022.
//

import Foundation
import RxSwift
import Alamofire

protocol NetworkProtocol {
    func get(url: String) -> Observable<Result<Data, Error>>
}

class Network: NetworkProtocol {
    func get(url: String) -> Observable<Result<Data, Error>> {
        let disposable = Disposables.create()
        
        return Observable<Result<Data, Error>>.create { observer in
            AF.request(url, method: .get).responseData { (result: AFDataResponse<Data>) in
                switch result.result {
                case .success(let data):
                    observer.onNext(.success(data))
                case .failure(let error):
                    observer.onNext(.failure(error))
                }
            }
            
            return disposable
        }
    }
    
    
}
