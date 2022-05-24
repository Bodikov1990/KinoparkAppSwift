//
//  WeeklyCollectionViewCell.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 24.05.2022.
//

import UIKit

class WeeklyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeeklyCollectionViewCell"
    
    let backgroundCell: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        view.backgroundColor = .systemBackground
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowOpacity = 0.8
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 4
        view.layer.shadowRadius = 3
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(date: String) {
        dateLabel.text = date
        setConstraints()
    }
    
    private func setConstraints() {
        contentView.addSubview(backgroundCell)
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        backgroundCell.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: backgroundCell.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor)
        ])
    }
}
