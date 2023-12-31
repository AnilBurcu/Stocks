//
//  StockDetailHeaderView.swift
//  Stocks
//
//  Created by Anıl Bürcü on 5.10.2023.
//

import UIKit

class StockDetailHeaderView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    private var metricViewModels: [MetricCollectionViewCell.ViewModel] = []
   
    // Chart view
    
    private let chartView = StockChartView()
    
    // Collection view

    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .secondarySystemBackground
        
        
        // Register cells
        collectionView.register(MetricCollectionViewCell.self, forCellWithReuseIdentifier: MetricCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView

    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubViews(chartView,collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartView.frame = CGRect(x: 0, y: 0, width: width, height: height-100)
        collectionView.frame = CGRect(x: 0, y: height-100, width: width, height: 100)
    }
    
    func configure(chartViewMode: StockChartView.ViewModel,
                   metricViewModels: [MetricCollectionViewCell.ViewModel]) {
        
        //Update chart
        
        chartView.configure(with: chartViewMode)
        self.metricViewModels = metricViewModels
        collectionView.reloadData()
    }
    // MARK: - Colletion View
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return metricViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let viewModel = metricViewModels[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MetricCollectionViewCell.identifier, for: indexPath) as? MetricCollectionViewCell else {fatalError()}
        
        cell.configure(with: viewModel)
        
        return cell
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: width/2, height: 100/3)
    }
    
    
    
    
   
}
