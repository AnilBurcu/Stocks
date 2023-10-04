//
//  StockDetailsViewController.swift
//  Stocks
//
//  Created by Anıl Bürcü on 2.10.2023.
//

import UIKit

class StockDetailsViewController: UIViewController {

    
    //Symbol, Company name,Chart data
    
    //MARK: - Properties
    private let symbol: String
    private let companyName:String
    private let candleStickData: [CandleStick]
    
    
    // MARK: - Init
    init(
        symbol: String,
        companyName:String,
        candleStickData: [CandleStick]=[]
    ) {
        self.symbol = symbol
        self.companyName = companyName
        self.candleStickData = candleStickData
        super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
    }
    


}
