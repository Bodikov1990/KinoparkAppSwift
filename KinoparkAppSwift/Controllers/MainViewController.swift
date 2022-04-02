//
//  MainVC.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 22.03.2022.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func didTapSideMenu()
    
}

class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?
    
    
    private var movies = ["I go School", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5", "", "Morbius", "", "", "5"]
    
    var collectionView: UICollectionView!
    
    private var cinemasSortView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var cinemasSortButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 15, width: 150, height: 30)
        button.setTitle("Kinopark 7 Aktobe", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(sortCinemas), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        setCollectionView()
        setupNavBar()
        addLogoToNav()
        setConstraints()
    }
    
    @objc private func sortCinemas() {
        print("tap")
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .white
        }
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "movies")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func setConstraints() {
        cinemasSortView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cinemasSortView)

        NSLayoutConstraint.activate([
            cinemasSortView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cinemasSortView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            cinemasSortView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            cinemasSortView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cinemasSortView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        cinemasSortView.addSubview(cinemasSortButton)
        cinemasSortButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cinemasSortButton.centerXAnchor.constraint(equalTo: cinemasSortView.centerXAnchor),
            cinemasSortButton.centerYAnchor.constraint(equalTo: cinemasSortView.centerYAnchor)
        ])

    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movies", for: indexPath)
        
        cell.contentView.backgroundColor = .red
        cell.isHidden = false
        
//        if movies[indexPath.item] == "" {
//            cell.isHidden = true
//        }
        
        return cell
    }
}

// MARK: - Setup Navigation Bar
extension MainViewController {
    
    private func setupNavBar() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(named: "line.3.horizontal"),
                style: .plain,
                target: self,
                action: #selector(sideMenu)
            )
        
    }
    
    @objc private func sideMenu(){
        delegate?.didTapSideMenu()
    }
    
    private func addLogoToNav() {
        if let navController = navigationController {
            let imageLogo = UIImage(named: "kinopark")
            
            let widthNav = navController.navigationBar.frame.width
            let heightNav = navController.navigationBar.frame.height
            
            let widthForView = widthNav * 0.4
            
            let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: widthForView, height: heightNav))
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: widthForView, height: heightNav))
            imageView.image = imageLogo
            imageView.contentMode = .scaleAspectFit
            logoContainer.addSubview(imageView)
            
            navigationItem.titleView = logoContainer
            
        }
    }
}
