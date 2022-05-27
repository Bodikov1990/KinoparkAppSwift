//
//  MainTableViewCell.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 15.04.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    
    var testModel2 = ["wdwd", "efef", "efef"]
    var seanceData: [SeancesData] = []
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let backgroundCell: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        view.backgroundColor = .systemBackground
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 3)
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 3
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let movieNameLabel: UILabel = {
        let movieNameLabel = UILabel()
        movieNameLabel.numberOfLines = 1
        movieNameLabel.font = .boldSystemFont(ofSize: 12)
        return movieNameLabel
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let ageLimitation: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        label.font = .systemFont(ofSize: 8)
        label.textColor = .black
        label.transform = CGAffineTransform(rotationAngle: -95)
        return label
    }()
    
    private let playLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 130, height: 30))
        label.text = "Смотреть трейлер"
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
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(movieAction), for: .touchUpInside)
        return button
    }()
    
    private let playImage: UIImageView = {
        let imageName = "play.circle.fill"
        let image = UIImage(systemName: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }()
    
    private lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: contentView.frame.width,
            height: contentView.frame.height))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let descriptionTextView = UITextView()
    
    private var imageUrl: URL? {
        didSet {
            buttonImageView.image = nil
            updateImage()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubview(subviews:
                            backgroundCell,
                         buttonImageView,
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
        tapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(cityData: CitiesData, cinemaData: CinemasData, movie: MoviesData) {
        guard let url = movie.images.vertical else { return }
        imageUrl = URL(string: url)
        configureLabel(seance: movie)
        print(cityData.uuid ?? "", cinemaData.uuid, movie.movieUUID)
        
    }
    
    private func updateImage() {
        guard let imageUrl = imageUrl else { return }
        getImage(from: imageUrl) { result in
            switch result {
            case .success(let image):
                self.buttonImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(from url: URL, comletion: @escaping(Result<UIImage, Error>) -> Void) {
        // Get image from cache
        if let cachedImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            print("Image from cache: ", url.lastPathComponent)
            comletion(.success(cachedImage))
            return
        }
        // Download image from url
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                print("Image from network: ", url.lastPathComponent)
                comletion(.success(image))
            case .failure(let error):
                comletion(.failure(error))
            }
        }
    }
    
    func fetchSeance(city: String, cinema: String, movie: String) {
        let url = "https://afisha.api.kinopark.kz//api/seance?date_from=2022-05-28&sort=seance.start_time&city=\(city)&cinema=\(cinema)&movie=\(movie)"
        print(url)
        NetworkManager.shared.fetchWithBearerToken(dataType: SeancesModel.self, from: url, convertFromSnakeCase: false) { result in
            switch result {
            case .success(let movie):
                print(movie.data.count)
//                self.seanceData = movie.data
                self.seanceData = [
                SeancesData(
                    cityUUID: "",
                    cinemaUUID: "",
                    hallUUID: "",
                    movieUUID: "",
                    seanceUUID: "",
                    basePrice: 1,
                    startDate: "",
                    startTime: "",
                    endTime: "",
                    duration: 1,
                    sortOrder: 1,
                    discounts: [Discount(uuid: "", name: "", code: "", sortOrder: 1, isActive: true, isShow: true, value: 1, type: "")],
                    format: [""],
                    language: "",
                    isActive: true,
                    cityName: "",
                    cinemaName: "",
                    hallName: "",
                    hallFormat: [""],
                    hallMenu: HallMenu(ancestorUUID: ""),
                    movieName: "",
                    movieFormat: [""]),
                SeancesData(
                    cityUUID: "",
                    cinemaUUID: "",
                    hallUUID: "",
                    movieUUID: "",
                    seanceUUID: "",
                    basePrice: 1,
                    startDate: "",
                    startTime: "",
                    endTime: "",
                    duration: 1,
                    sortOrder: 1,
                    discounts: [Discount(uuid: "", name: "", code: "", sortOrder: 1, isActive: true, isShow: true, value: 1, type: "")],
                    format: [""],
                    language: "",
                    isActive: true,
                    cityName: "",
                    cinemaName: "",
                    hallName: "",
                    hallFormat: [""],
                    hallMenu: HallMenu(ancestorUUID: ""),
                    movieName: "",
                    movieFormat: [""])
                ]
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func tapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapedGesture(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        buttonImageView.addGestureRecognizer(tapGestureRecognizer)
        buttonImageView.isUserInteractionEnabled = true
    }
    
    @objc private func tapedGesture(_ gesture: UITapGestureRecognizer) {
        print("TAPPED")
    }
    
    @objc private func movieAction() {
        print("tap")
    }
    
    private func configureLabel(seance: MoviesData) {
        movieNameLabel.text = seance.movieName ?? "Name"

        genreLabel.text = seance.genre.joined(separator: ", ")
        durationLabel.text = "Продолжительность: \(seance.duration ?? 0) минут"
        
        if seance.ageLimitationText == "" {
            pgView.isHidden = true
        }
        ageLimitation.text = seance.ageLimitationText ?? "0"
        
        if seance.trailerLink == "" {
            playButton.isHidden = true
        }
        
        descriptionTextView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: 20)
        descriptionTextView.text = seance.description
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
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension MainTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        seanceData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seances", for: indexPath)
        let seance = seanceData[indexPath.item]
        print(seance.movieName ?? "")
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 8
        cell.contentView.backgroundColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.size.width / 6) - 4 , height: 30)
    }
    
}

extension MainTableViewCell {
    private func configureSubview(subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
        pgView.addSubview(ageLimitation)
        playButton.addSubview(playLabel)
        playButton.addSubview(playImage)
    }
    
    private func setConstraints() {
        
        backgroundCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        buttonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonImageView.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            buttonImageView.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            buttonImageView.heightAnchor.constraint(equalToConstant: 130),
            buttonImageView.widthAnchor.constraint(equalTo: buttonImageView.heightAnchor, multiplier: 10/16)
        ])
        
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: buttonImageView.topAnchor),
            movieNameLabel.leadingAnchor.constraint(equalTo: buttonImageView.trailingAnchor, constant: 10),
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
        
        ageLimitation.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ageLimitation.centerYAnchor.constraint(equalTo: pgView.centerYAnchor),
            ageLimitation.centerXAnchor.constraint(equalTo: pgView.centerXAnchor)
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
            descriptionTextView.topAnchor.constraint(equalTo: buttonImageView.bottomAnchor, constant: 10),
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
