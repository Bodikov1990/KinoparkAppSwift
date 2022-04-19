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
    
    var delegate: MainViewControllerDelegate?
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieListTBVCell.self, forCellReuseIdentifier: MovieListTBVCell.identifier)
        return tableView
    }()
    
    let headerView = UIView()
    
    private var cinemasSortView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var cinemasSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("Kinopark 7 Aktobe", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.addTarget(self, action: #selector(sortCinemas), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "slider.horizontal.3"), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(sortCinemas), for: .touchUpInside)
        
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "movieItem")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var movies: [TestModel] = [
        TestModel(
            image: "600x900",
            name: "Миссия невыполнимых: Последствия",
            testModel2: [
                TestModel2(text: "Миссия невыполнимых: Последствия"),

            ]),
        TestModel(
            image: "600x900",
            name: "Миссия невыполнимых: Последствия",
            testModel2: [
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),

            ]),
        TestModel(
            image: "600x900",
            name: "Миссия невыполнимых: Последствия",
            testModel2: [
                TestModel2(text: "Миссия невыполнимых: Племя изгоев"),
                TestModel2(text: "Миссия невыполнимых: Племя изгоев"),
                TestModel2(text: "Миссия невыполнимых: Племя изгоев"),
            ]),
        TestModel(
            image: "600x900",
            name: "Миссия невыполнимых: Последствия",
            testModel2: [
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
            ]),
        TestModel(
            image: "600x900",
            name: "Миссия невыполнимых: Последствия",
            testModel2: [
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
            ]),
        TestModel(
            image: "600x900",
            name: "Миссия невыполнимых: Последствия",
            testModel2: [
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
            ]),
        TestModel(
            image: "600x900",
            name: "Миссия невыполнимых: Последствия",
            testModel2: [
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
            ]),
        TestModel(
            image: "600x900",
            name: "Миссия невыполнимых: Последствия",
            testModel2: [
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
            ]),
        TestModel(
            image: "600x900",
            name: "Миссия невыполнимых: Последствия",
            testModel2: [
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
                TestModel2(text: "Миссия невыполнимых: Последствия"),
            ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        setupNavBar()
        addLogoToNav()
        
        mainTableView.tableHeaderView = headerView
        view.addSubview(mainTableView)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.estimatedRowHeight = 200
        mainTableView.rowHeight = UITableView.automaticDimension
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTableView.frame = view.bounds
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 110)
        cinemasSortView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40)
        cinemasSortButton.frame = CGRect(x: 0, y: 0, width: cinemasSortView.frame.size.width / 2, height: cinemasSortView.frame.size.height)
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30)
        setConstraints()
    }
    
    
    @objc private func sortCinemas() {
        print("tap")
    }
}

// MARK: - Setup TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTBVCell.identifier, for: indexPath) as! MovieListTBVCell
        let movies = movies[indexPath.row]
        
        cell.configure(movies: movies)
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        cell.collectionView.reloadData()
        let tableContenSize = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
        
        cell.collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: tableContenSize).isActive = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("\(movies.indices[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Setup CollectionView
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieItem", for: indexPath)
        cell.contentView.backgroundColor = .red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60, height: 30)
    }
}

// MARK: - Setup Nav Controller and Contraints
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
    
    private func setConstraints() {
        headerView.addSubview(cinemasSortView)
        cinemasSortView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cinemasSortView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            cinemasSortView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 10),
            cinemasSortView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -10),
            cinemasSortView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        cinemasSortView.addSubview(cinemasSortButton)
        cinemasSortButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cinemasSortButton.leftAnchor.constraint(equalTo: cinemasSortView.leftAnchor, constant: 10),
            cinemasSortButton.centerYAnchor.constraint(equalTo: cinemasSortView.centerYAnchor)
        ])
        
        cinemasSortView.addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filterButton.rightAnchor.constraint(equalTo: cinemasSortView.rightAnchor, constant: -10),
            filterButton.centerYAnchor.constraint(equalTo: cinemasSortView.centerYAnchor)
        ])
        
        headerView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cinemasSortView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
    }
}
