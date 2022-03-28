//
//  FeedsViewModel.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 26/03/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol FeedViewModelProtocol {
    // Input
    var viewDidLoad: PublishRelay<Void>
    { get }
    //output
    var sectionsSubject: PublishSubject<[HomeFeedSection]>
    { get }
}

class FeedsViewModel: BaseViewModel, FeedViewModelProtocol {
    //MARK: - Injection
    let repo = Injection.container.resolve(RemoteRepository.self)!
    
    //MARK: - Input
    let viewDidLoad
        = PublishRelay<Void>()
    
    //MARK: - Output
    let sectionsSubject: PublishSubject<[HomeFeedSection]> = PublishSubject<[HomeFeedSection]>()
    
    private var rawSectionItems = [StockTicker]()
    let stockTickerSubject: BehaviorRelay<[SectionItem]> = BehaviorRelay<[SectionItem]>(value: [])
    private var mainArticleSubject: BehaviorRelay<[SectionItem]> = BehaviorRelay<[SectionItem]>(value: [])
    private var articleSubject: BehaviorRelay<[SectionItem]> = BehaviorRelay<[SectionItem]>(value: [])
    
    var sections: [HomeFeedSection] = []
    private var timer = Timer()
    
    override init() {
        super.init()
        bindOnViewDidLoad()
        addObservables()
    }
    
    private func bindOnViewDidLoad() {
        viewDidLoad
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] _ in
                self?.getData()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
    }
    
    private func addObservables() {
        Observable.combineLatest(
            stockTickerSubject
            , mainArticleSubject
            , articleSubject).subscribe { [weak self] _, _, _ in
                self?.syncNewData()
            }.disposed(by: disposeBag)
    }
    
    private func getData() {
        getStockTickers(url: Endpoints.stockTickers.rawValue)
        getArticles(url: Endpoints.newsFeed.rawValue)
    }
    
    private func syncNewData() {
        let data: [HomeFeedSection] = [
            .stockTicker(title: "StockTicker", items: stockTickerSubject.value),
            .mainFeed(title: "Main Articles",
                      items: mainArticleSubject.value),
            .feed(title: "Articles",
                  items: articleSubject.value)
        ]
        self.sectionsSubject.onNext(data)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changePrices), userInfo: nil, repeats: true)
    }
    
    func getStockTickers(url: String) {
        repo.get(url: url, model: [StockTicker].self).subscribe(onNext: { [weak self] (result: Result<[StockTicker], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                print(data)
                self.rawSectionItems = data
                let sectionItems = data.map {
                    SectionItem.StockTickerItem(model: $0)
                }
                self.stockTickerSubject.accept(sectionItems)
                self.startTimer()
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }).disposed(by: disposeBag)
    }
    
    func getArticles(url: String) {
        repo.get(url: url, model: FeedsModel.self).subscribe(onNext: { [weak self] (result: Result<FeedsModel, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if let articles = data.articles, articles.count > 6 {
                    let arraySlice = Array(articles[0...5])
                    let mainArticlesSectionItems = arraySlice.map {
                        SectionItem.MainFeedItem(model: $0)
                    }
                    self.mainArticleSubject.accept(mainArticlesSectionItems)
                    let restOfArticles = Array(articles[6...(articles.count - 1)])
                    let articlesSectionItems = restOfArticles.map {
                        SectionItem.FeedItem(model: $0)
                    }
                    self.articleSubject.accept(articlesSectionItems)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func changePrices() {
        let items = rawSectionItems.map{ item -> StockTicker in
            var item = item
            let newPrice = Double.random(in: -10.00...10.0)
            item.price = newPrice
            
            return item
        }
        
        let sectionItems = items.map {
            SectionItem.StockTickerItem(model: $0)
        }
        self.stockTickerSubject.accept(sectionItems)
        
    }
}
