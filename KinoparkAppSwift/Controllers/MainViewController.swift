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
    
    
    private var movies = ["I go School", "Kino", "Morbius"]
    
    private var cinemasSortView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var cinemasSortButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 150, y: 150, width: 150, height: 30)
        button.setTitle("Looong Test Button", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(sortCinemas), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBlue
        } else {
            view.backgroundColor = .white
        }
        setupNavBar()
        addLogoToNav()
        setConstraints()
    }
    
    @objc private func sortCinemas() {
        print("tap")
    }
    private func setConstraints() {


        view.addSubview(cinemasSortView)
        cinemasSortView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cinemasSortView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cinemasSortView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cinemasSortView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cinemasSortView.heightAnchor.constraint(equalToConstant: 40)
        ])


        view.addSubview(cinemasSortButton)
        cinemasSortButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cinemasSortButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cinemasSortButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
            navigationItem.leftBarButtonItem = UIBarButtonItem(
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
