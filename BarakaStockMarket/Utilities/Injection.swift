//
//  Injection.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 26/03/2022.
//

import Foundation
import Swinject

class Injection {
    private static let baseContainer = Container()
    
    static let container = baseContainer.synchronize()
    
    private init() {}
    
    
    private static func registerSharedComponents() {
        baseContainer.register(Network.self) { _ in
            return Network()
        }
        baseContainer.register(RemoteRepository.self) { _ in
            return RemoteRepository()
        }
        baseContainer.register(DataMapper.self) { _ in
            return DataMapper()
        }
    }
    
    private static func registerNewsFeedComponent() {
        baseContainer.register(FeedsViewModel.self) { _ in
            return FeedsViewModel()
        }
    }
    
    
    //MARK:- Register Dependencies
    public static func register() {
        registerSharedComponents()
        registerNewsFeedComponent()
    }
}
