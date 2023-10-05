//
//  MetricCollectionViewCell.swift
//  Stocks
//
//  Created by Anıl Bürcü on 5.10.2023.
//

import UIKit

class MetricCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MetricCollectionViewCell"
    
    struct ViewModel {
        let name: String
        let value: String
        
    }
    
    let nameLbel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        addSubViews(nameLbel,valueLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        valueLabel.sizeToFit()
        nameLbel.sizeToFit()
        
        nameLbel.frame = CGRect(x: 3, y: 0, width: nameLbel.width, height: contentView.height)
        valueLabel.frame = CGRect(x: nameLbel.right + 3, y: 0, width: valueLabel.width, height: contentView.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLbel.text = nil
        valueLabel.text = nil
    }
    func configure(with viewModel: ViewModel) {
        nameLbel.text = viewModel.name+":"
        valueLabel.text = viewModel.value
    }
}
