//
//  DataFactory.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 26/03/2022.
//

import Foundation
import RxSwift
import SwiftCSV

enum ParsingResult {
    case jsonParsing(Codable)
    case cvsParsing([Codable])
}
protocol DataMapperProtocol {
    func mapData<T: Codable>(observable: Observable<Result<Data, Error>>, model: T.Type) -> Observable<Result<T, Error>>
}

class DataMapper: DataMapperProtocol {
    
    func mapData<T: Codable>(observable: Observable<Result<Data, Error>>, model: T.Type) -> Observable<Result<T, Error>> {
        
        return observable.map { (result: Result<Data, Error>) in
            let decoder = JSONDecoder()
            switch result {
            case .success(let data):
                if (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]) != nil {
                    do {
                        let model = try decoder.decode(model.self, from: data)
                        return .success(model)
                    } catch let error {
                        return .failure(error)
                    }
                } else {
                    let stringData = String(data: data, encoding: .utf8) ?? ""
                    do {
                        let csv: CSV = try CSV(string: stringData)
                        let data = try JSONEncoder().encode(csv.namedRows)
                        let decodedData = try decoder.decode(model.self, from: data)
                        return .success(decodedData)
                    } catch {
                        // Invalid row format
                        return .failure(error)
                    }
                }
                
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}



