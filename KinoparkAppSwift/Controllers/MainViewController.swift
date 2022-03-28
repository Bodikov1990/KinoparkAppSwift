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
    
    private let collectionVC: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "movies")
        
        
        return collectionView
    }()
    
    private var movies = ["I go School", "Kino", "Morbius"]
    
    private var cinemasSortView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var cinemasSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("Kinopark 7 Aktobe", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionVC.delegate = self
        collectionVC.dataSource = self
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        setupNavBar()
        addLogoToNav()
        setConstraints()
    }
    
    private func setConstraints() {
        
        view.addSubview(collectionVC)
        
        collectionVC.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionVC.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionVC.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionVC.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionVC.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionVC.addSubview(cinemasSortView)
        
        cinemasSortView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cinemasSortView.topAnchor.constraint(equalTo: collectionVC.topAnchor, constant: 16),
            cinemasSortView.leadingAnchor.constraint(equalTo: collectionVC.leadingAnchor, constant: 16),
            cinemasSortView.trailingAnchor.constraint(equalTo: collectionVC.trailingAnchor, constant: -16),
            cinemasSortView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        cinemasSortView.addSubview(cinemasSortButton)
        cinemasSortButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cinemasSortButton.leadingAnchor.constraint(equalTo: cinemasSortView.leadingAnchor, constant: 10),
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
        
        
        
        
        return cell
    }
    
    
}

// MARK: - Setup Navigation Bar
extension MainViewController {
    
    private func setupNavBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearence = UINavigationBarAppearance()
            navBarAppearence.configureWithOpaqueBackground()
            navBarAppearence.backgroundColor = .green
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "line.3.horizontal"),
                style: .plain,
                target: self,
                action: #selector(sideMenu)
            )
            navigationController?.navigationBar.standardAppearance = navBarAppearence
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(named: "line.3.horizontal"),
                style: .plain,
                target: self,
                action: #selector(sideMenu)
            )
        }
        
        navigationController?.navigationBar.tintColor = .black
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
