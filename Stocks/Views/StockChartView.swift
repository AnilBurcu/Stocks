//
//  StockChartView.swift
//  Stocks
//
//  Created by Anıl Bürcü on 4.10.2023.
//

import UIKit

class StockChartView: UIView {
    
    struct ViewModel {
        let data: [CandleStick]
        let showLegend: Bool
        let showAxis: Bool
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // Reset the chart view
    func reset(){
        
    }
    
    func configure(with viewModel:ViewModel){
        
    }

}
