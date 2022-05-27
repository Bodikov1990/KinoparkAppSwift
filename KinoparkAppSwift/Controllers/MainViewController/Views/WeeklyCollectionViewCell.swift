//
//  WeeklyCollectionViewCell.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 24.05.2022.
//

import UIKit

class WeeklyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeeklyCollectionViewCell"
    
    let systemView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        view.backgroundColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
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
        systemView.backgroundColor = .systemBackground
        setConstraints()
    }
    
    func didSelect() {
        systemView.backgroundColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        dateLabel.textColor = .white
    }
    
    func deSeslect() {
        systemView.backgroundColor = .systemBackground
        dateLabel.textColor = UIColor(named: "textColor")
    }
    
    private func setConstraints() {
        contentView.addSubview(systemView)
        
        NSLayoutConstraint.activate([
            systemView.topAnchor.constraint(equalTo: contentView.topAnchor),
            systemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            systemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            systemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        systemView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: systemView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: systemView.centerYAnchor)
        ])
    }
}
