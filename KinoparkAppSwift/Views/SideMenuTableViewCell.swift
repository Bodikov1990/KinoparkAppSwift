//
//  SideMenuTableViewCell.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 12.05.2022.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    static let identifier = "SideMenuTableViewCell"
    
    private lazy var cellImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 130, height: 30))
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Системный", "Светлый", "Темный"])
        segmentedControl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if #available(iOS 13.0, *) {
            segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        } else {
            
        }
        segmentedControl.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(SideMenuTableViewCell.self, action: #selector(changeInterface), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubview(subviews: cellImageView, cellLabel, segmentedControl)
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func changeInterface() {
        print("changed")
    }
    
    func configure(option: String, image: String) {
        cellLabel.text = option
        cellImageView.image = configureImage(image: image)
    }
    
    private func configureSubview(subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
    
    private func configureImage(image: String) -> UIImage{
        let imageName: UIImage!
        if #available(iOS 13.0, *) {
            imageName = UIImage(systemName: image)
        } else {
            imageName = UIImage(named: image)
        }
        return imageName
    }
    
    private func setContraints() {
        
        NSLayoutConstraint.activate([
            cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
}
