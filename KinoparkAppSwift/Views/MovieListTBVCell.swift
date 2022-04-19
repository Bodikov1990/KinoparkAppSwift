//
//  MovieListTBVCell.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 15.04.2022.
//

import UIKit

class MovieListTBVCell: UITableViewCell {
    
    static let identifier = "MovieListTBVCell"
    
    var collectionViewHeight: CGFloat?
    
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "seances")
        collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    var testModel2: [TestModel2] = []
    
    private let movieNameLabel = UILabel()
    private lazy var movieButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(sortCinemas), for: .touchUpInside)
        
        return button
    }()
    
    private var imageUrl: URL? {
        didSet {
            movieButton.imageView?.image = nil
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieButton)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(collectionView)
        
        configureCollectionView()
        configureImageView()
        configureLabel()
        setConstraints() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func sortCinemas() {
        print("tap")
    }
    
    func configure(movies: TestModel) {
        movieNameLabel.text = movies.name
        movieButton.setBackgroundImage(UIImage(named: movies.image), for: .normal)
        testModel2 = movies.testModel2
    }
    
    private func configureCollectionView() {
        collectionView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureImageView() {
        movieButton.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        movieButton.layer.cornerRadius = 10
        movieButton.clipsToBounds = true
    }
    
    private func configureLabel() {
        movieNameLabel.numberOfLines = 0
        movieNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setConstraints() {
        
        movieButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            movieButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieButton.heightAnchor.constraint(equalToConstant: 130),
            movieButton.widthAnchor.constraint(equalTo: movieButton.heightAnchor, multiplier: 10/16)
        ])
        
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: movieButton.topAnchor),
            movieNameLabel.leadingAnchor.constraint(equalTo: movieButton.trailingAnchor, constant: 12),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 30),
            movieNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: movieButton.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

extension MovieListTBVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        testModel2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seances", for: indexPath)
        
        
        cell.layer.cornerRadius = 8
        cell.contentView.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width / 6 , height: 20)
    }
    
}