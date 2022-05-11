//
//  MainViewController.swift
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
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieListTBVCell.self, forCellReuseIdentifier: MovieListTBVCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "movieItem")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let headerView = UIView()
    private let cinemasView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let filterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var cinemasButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "slider.horizontal.3"), for: .normal)
        button.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        configureSubview(subviews: cinemasView, filterView, collectionView)
        setupNavBar()
        addLogoToNav()
        setupTableView()
        setupCinemaFilterButton()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
//MARK: - ViewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTableView.frame = view.bounds
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 110)
        cinemasButton.frame = CGRect(x: 0, y: 0, width: cinemasView.frame.size.width, height: cinemasView.frame.size.height)
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30)
        setupViews(views: cinemasView, filterView)
        setConstraints()
    }
    
    private func setupTableView() {
        mainTableView.tableHeaderView = headerView
        view.addSubview(mainTableView)
        mainTableView.estimatedRowHeight = 200
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.layer.cornerRadius = 10
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    private func setupViews(views: UIView...) {
        views.forEach { view in
            view.frame = CGRect(x: 0, y: 0, width: headerView.frame.width, height: 36)

            if #available(iOS 13.0, *) {
                view.backgroundColor = .systemBackground
            } else {
                view.backgroundColor = .white
            }
            
            view.layer.shadowColor = UIColor.lightGray.cgColor
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = CGSize(width: 1, height: 1)
            view.layer.shadowRadius = 5
        }
    }
    
    private func setupCinemaFilterButton() {
        cinemasButton.setTitle("Kinopark 7 Keruencity", for: .normal)
        cinemasButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        cinemasButton.setTitleColor(UIColor.systemYellow, for: .normal)
    }
    
    @objc private func filterAction() {
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
        
        
        cell.configure(movie: movies)
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        cell.collectionView.reloadData()
        let tableContenSize = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
        cell.collectionView.heightAnchor.constraint(equalToConstant: tableContenSize).isActive = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("\(movies.indices[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        CGSize(width: (view.frame.size.width / 4) - 2, height: 30)
    }
}

// MARK: - Setup Nav Controller
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

    
// MARK: - Contraints
    private func configureSubview(subviews: UIView...) {
        subviews.forEach { subview in
            headerView.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            cinemasView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            cinemasView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            cinemasView.trailingAnchor.constraint(equalTo: filterView.leadingAnchor, constant: -12),
            cinemasView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: cinemasView.topAnchor),
            filterView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            filterView.widthAnchor.constraint(equalTo: cinemasView.heightAnchor),
            filterView.bottomAnchor.constraint(equalTo: cinemasView.bottomAnchor)
        ])
        
        cinemasView.addSubview(cinemasButton)

        NSLayoutConstraint.activate([
            cinemasButton.leftAnchor.constraint(equalTo: cinemasView.leftAnchor, constant: 10),
            cinemasButton.centerYAnchor.constraint(equalTo: cinemasView.centerYAnchor)
        ])

        filterView.addSubview(filterButton)

        NSLayoutConstraint.activate([
            filterButton.centerXAnchor.constraint(equalTo: filterView.centerXAnchor),
            filterButton.centerYAnchor.constraint(equalTo: filterView.centerYAnchor)
        ])
  
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: cinemasView.bottomAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
    }
}
