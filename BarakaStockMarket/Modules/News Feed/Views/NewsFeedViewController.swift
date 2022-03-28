//
//  NewsFeedViewController.swift
//  BarakaStockMarket
//
//  Created by Amr Magdy on 26/03/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Differentiator

class NewsFeedViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let viewModel = Injection.container.resolve(FeedsViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addListeners()
        viewModel.viewDidLoad.accept(())
    }
    
    private func setupUI() {
        configureCollectionView()
    }
   
    private func configureCollectionView() {
        registerCells()
        configureLayout()
    }
    
    private func registerCells() {
        collectionView.register(StockTickerCell.nib, forCellWithReuseIdentifier: StockTickerCell.identifier)
        collectionView.register(NewsFeedCell.nib, forCellWithReuseIdentifier: NewsFeedCell.identifier)
        collectionView.register(MainArticleCell.nib, forCellWithReuseIdentifier: MainArticleCell.identifier)
    }
    
    private func addListeners() {
        let dataSource = dataSource()
        
        viewModel.sectionsSubject
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: viewModel.disposeBag)
    }
    
    
    

    
    
    
    
   
}


