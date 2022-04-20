//
//  MovieListTBVCell.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 15.04.2022.
//

import UIKit

class MovieListTBVCell: UITableViewCell {
    
    static let identifier = "MovieListTBVCell"
    var testModel2: [TestModel2] = []
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let movieButton = UIButton()
    private let movieNameLabel = UILabel()
    private let genreLable = UILabel()
    private let pgView: UIView = {
       let view = UIView()
        view.transform = CGAffineTransform(rotationAngle: 45)
        view.backgroundColor = .systemYellow

        return view
    }()
    private let durationLabel = UILabel()
    
    private var imageUrl: URL? {
        didSet {
            movieButton.imageView?.image = nil
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubview(subviews: movieButton, movieNameLabel, genreLable, pgView, durationLabel, collectionView)
        configureCollectionView()
        setConstraints() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(movie: TestModel) {
        configureMovieButton(for: movie.image)
        configureLabel(name: movie.name)
        testModel2 = movie.testModel2
    }
    
    private func configureSubview(subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
    
    private func configureMovieButton(for image: String) {
        movieButton.setBackgroundImage(UIImage(named: image), for: .normal)
        movieButton.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        movieButton.layer.cornerRadius = 10
        movieButton.clipsToBounds = true
        movieButton.addTarget(self, action: #selector(sortCinemas), for: .touchUpInside)
    }
    
    @objc private func sortCinemas() {
        print("tap")
    }
    
    private func configureLabel(name: String) {
        movieNameLabel.text = name
        movieNameLabel.numberOfLines = 0
        movieNameLabel.adjustsFontSizeToFitWidth = true
        
        genreLable.text = name
        genreLable.textColor = .lightGray
        genreLable.font = .systemFont(ofSize: 12)
        
        durationLabel.text = "Продолжительность: 100 минут"
        durationLabel.font = .systemFont(ofSize: 12)
        
        pgView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
    }
    
    private func configureCollectionView() {
        collectionView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "seances")
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
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
        
        genreLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            genreLable.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            genreLable.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            genreLable.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        pgView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pgView.centerYAnchor.constraint(equalTo: genreLable.centerYAnchor),
            pgView.leadingAnchor.constraint(equalTo: genreLable.trailingAnchor, constant: 5),
            pgView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(equalTo: genreLable.bottomAnchor, constant: 10),
            durationLabel.leadingAnchor.constraint(equalTo: genreLable.leadingAnchor),
            durationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: movieButton.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 30),
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
        
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 8
        cell.contentView.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.size.width / 6) - 4 , height: 30)
    }
    
}
