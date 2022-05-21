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
    
    weak var delegate: MainViewControllerDelegate?
    
    let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "movieItem")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    var movies: [TestModel] = [
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
    var seances: [SeancesData] = []
    var cityData: CitiesData!
    
    private let cinemasVC = CinemasTableViewController()
    private var cinamasName: String!
    

    
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
    
    lazy var cinemasButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        button.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSubview(subviews: cinemasView, filterView, collectionView)
        setupNavBar()
        addLogoToNav()
        setupTableView()
        setupCinemaFilterButton()
        collectionView.dataSource = self
        collectionView.delegate = self
        cinemasVC.delegate = self

        print(cityData.uuid ?? "")
        
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
    
    //MARK: - Private funcs
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
            view.backgroundColor = .systemBackground
            view.layer.shadowColor = UIColor.lightGray.cgColor
            view.layer.shadowOpacity = 0.8
            view.layer.shadowOffset = CGSize(width: 1, height: 3)
            view.layer.shadowRadius = 5
        }
    }
    
    private func setupCinemaFilterButton() {
        cinemasButton.setTitle(cinamasName ?? "Загрузка...", for: .normal)
        cinemasButton.setTitleColor(
            UIColor(named: "textColor"),
            for: .normal)
        cinemasButton.addTarget(
            self,
            action: #selector(filterAction),
            for: .touchUpInside)
    }
    
    @objc private func filterAction() {
        
        cinemasVC.modalPresentationStyle = .popover
        
        let popOverCitiesVC = cinemasVC.popoverPresentationController
        popOverCitiesVC?.delegate = self
        popOverCitiesVC?.sourceView = self.cinemasView
        popOverCitiesVC?.sourceRect = CGRect(x: self.cinemasView.bounds.maxY, y: self.cinemasView.bounds.midY, width: 0, height: 0)
        cinemasVC.preferredContentSize = CGSize(width: self.view.frame.size.width - 50, height: self.view.frame.size.height - 50)
        
        self.present(cinemasVC, animated: true)
    }
}

// MARK: - Setup TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        seances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        let movies = seances[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(movie: movies)
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        cell.collectionView.reloadData()
        let tableContenSize = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
        cell.collectionView.heightAnchor.constraint(equalToConstant: tableContenSize).isActive = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        cell.contentView.backgroundColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        
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
            image: UIImage(systemName: "line.3.horizontal"),
            style: .plain,
            target: self,
            action: #selector(sideMenu)
        )
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
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
            cinemasButton.leftAnchor.constraint(equalTo: cinemasView.leftAnchor, constant: 16),
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
    
    func fetchCinemas(cityData: CitiesData) {
        guard let cityUUID = cityData.uuid else { return }
        let url = "http://afisha.api.kinopark.kz/api/cinema?city=\(cityUUID)"
        
        NetworkManager.shared.fetchWithBearerToken(dataType: CinemasModel.self, from: url, convertFromSnakeCase: false) { result in
            switch result {
            case .success(let cinemas):
//                print(cinemas)
                let cinemas = cinemas.data
                self.cinemasVC.cinemas = cinemas
                
                let indexPath = IndexPath(row: 0, section: 0)
                let selectedCinema = cinemas[indexPath.row]
                self.cinemasVC.delegate?.getCinema(cinemasData: selectedCinema)
                self.fetchSeance(cityUUID: cityUUID, cinemaUUID: selectedCinema.uuid)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchSeance(cityUUID: String, cinemaUUID: String) {
        
        let url = "https://afisha.api.kinopark.kz//api/seance?date_from=2022-05-22&sort=seance.start_time&city=\(cityUUID)&cinema=\(cinemaUUID)"
        print("URL SEANCE \(url)")
        NetworkManager.shared.fetchWithBearerToken(dataType: SeancesModel.self, from: url, convertFromSnakeCase: false) { result in
            switch result {
                
            case .success(let seances):
                print(seances)
                self.seances = seances.data
                self.mainTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

extension MainViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

extension MainViewController: CinemasTableViewControllerDelegate {
    func getCinema(cinemasData: CinemasData) {
        cinemasButton.setTitle(cinemasData.name, for: .normal)
        guard let cityUUID = cityData.uuid else { return }
        fetchSeance(cityUUID: cityUUID, cinemaUUID: cinemasData.uuid)
    }
}
