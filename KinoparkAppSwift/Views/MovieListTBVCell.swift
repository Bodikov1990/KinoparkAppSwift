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
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let backgroundCell: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.8
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let movieButton = UIButton()
    private let movieNameLabel = UILabel()
    private let genreLabel = UILabel()
    private let pgLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        label.font = .systemFont(ofSize: 8)
        label.transform = CGAffineTransform(rotationAngle: -95)
        return label
    }()
    private let playLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 130, height: 30))
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    private let pgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 3
        view.transform = CGAffineTransform(rotationAngle: 95)
        return view
    }()
    private let durationLabel = UILabel()
    private lazy var playButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(sortCinemas), for: .touchUpInside)
        return button
    }()
    
    let playImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "play.circle.fill"))
        return image
    }()
    
    let descriptionTextView = UITextView()
    
    private var imageUrl: URL? {
        didSet {
            movieButton.imageView?.image = nil
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubview(subviews:
                            backgroundCell,
                         movieButton,
                         movieNameLabel,
                         genreLabel,
                         pgView,
                         durationLabel,
                         playButton,
                         descriptionTextView,
                         collectionView
        )
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
        pgView.addSubview(pgLabel)
        playButton.addSubview(playLabel)
        playButton.addSubview(playImage)
    }
    
    private func configureMovieButton(for image: String) {
        movieButton.setBackgroundImage(UIImage(named: image), for: .normal)
        movieButton.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.frame.width,
            height: contentView.frame.height)
        movieButton.layer.cornerRadius = 10
        movieButton.clipsToBounds = true
        movieButton.addTarget(
            self,
            action: #selector(sortCinemas),
            for: .touchUpInside)
    }
    
    @objc private func sortCinemas() {
        print("tap")
    }
    
    private func configureLabel(name: String) {
        movieNameLabel.text = name
        movieNameLabel.numberOfLines = 1
        movieNameLabel.font = .boldSystemFont(ofSize: 12)
        
        genreLabel.text = "Боевик • Фантастика"
        genreLabel.numberOfLines = 1
        genreLabel.textColor = .lightGray
        genreLabel.font = .systemFont(ofSize: 12)
        
        durationLabel.text = "Продолжительность: 100 минут"
        durationLabel.font = .systemFont(ofSize: 12)
        
        pgLabel.text = "16+"
        pgLabel.textColor = .black
        
        playLabel.text = "Смотреть трейлер"
        
        descriptionTextView.frame = CGRect(x: 0, y: 0, width: 300, height: 20)
        descriptionTextView.text = "wiqojfqinqi nfiwqfjqiwn fiqnw fiqn fiq nifINQI WFIQN FOInfnqw ifnqi finqiw fnqn ofiqn fwi nqEI WFWIEN GNGW"
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false
        descriptionTextView.isSelectable = true
        descriptionTextView.backgroundColor = .clear
    }
    
    private func configureCollectionView() {
        collectionView.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.frame.size.width,
            height: contentView.frame.size.height)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "seances")
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setConstraints() {
        
        backgroundCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        movieButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieButton.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            movieButton.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            movieButton.heightAnchor.constraint(equalToConstant: 130),
            movieButton.widthAnchor.constraint(equalTo: movieButton.heightAnchor, multiplier: 10/16)
        ])
        
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: movieButton.topAnchor),
            movieNameLabel.leadingAnchor.constraint(equalTo: movieButton.trailingAnchor, constant: 10),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 30),
            movieNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor)
        ])
        
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            genreLabel.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            genreLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        pgView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pgView.centerYAnchor.constraint(equalTo: genreLabel.centerYAnchor),
            pgView.leadingAnchor.constraint(equalTo: genreLabel.trailingAnchor, constant: 10),
            pgView.heightAnchor.constraint(equalToConstant: 15),
            pgView.widthAnchor.constraint(equalToConstant: 15),
            pgView.trailingAnchor.constraint(lessThanOrEqualTo: backgroundCell.trailingAnchor, constant: -20)
            
        ])
        
        pgLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pgLabel.centerYAnchor.constraint(equalTo: pgView.centerYAnchor),
            pgLabel.centerXAnchor.constraint(equalTo: pgView.centerXAnchor)
        ])
        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 18),
            durationLabel.leadingAnchor.constraint(equalTo: genreLabel.leadingAnchor),
            durationLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 10),
            playButton.leadingAnchor.constraint(equalTo: durationLabel.leadingAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 30),
            playButton.widthAnchor.constraint(equalToConstant: playLabel.frame.size.width)
        ])
        
        playLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playLabel.leadingAnchor.constraint(equalTo: playImage.trailingAnchor, constant: 5),
            playLabel.centerYAnchor.constraint(equalTo: playButton.centerYAnchor)
        ])
        
        playImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playImage.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            playImage.leadingAnchor.constraint(equalTo: playButton.leadingAnchor),
            playImage.heightAnchor.constraint(equalToConstant: 24),
            playImage.widthAnchor.constraint(equalTo: playImage.heightAnchor)
        ])
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: movieButton.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 30),
            collectionView.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -10)
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
