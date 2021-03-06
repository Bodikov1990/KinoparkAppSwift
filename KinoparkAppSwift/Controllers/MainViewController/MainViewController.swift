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
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeeklyCollectionViewCell.self, forCellWithReuseIdentifier: WeeklyCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.insetsLayoutMarginsFromSafeArea = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var cityData: CitiesData!
    var cinemaData: CinemasData!
    
    private var movies: [MoviesData] = []
    
    private let cinemasVC = CinemasTableViewController()
    
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
        fetchCinemas(cityData: cityData)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
    }
    
    //    MARK: Fetch City and Cinemas
    func fetchCinemas(cityData: CitiesData) {
        let cityUUID = cityData.uuid
        let url = "http://afisha.api.kinopark.kz/api/cinema?city=\(cityUUID)"
        NetworkManager.shared.fetchWithBearerToken(dataType: CinemasModel.self, from: url) { result in
            switch result {
            case .success(let cinemas):
                let cinemas = cinemas.data
                self.cinemasVC.cinemas = cinemas
                self.cinemasVC.tableView.reloadData()
                
                let indexPath = IndexPath(row: 0, section: 0)
                let selectedCinema = cinemas[indexPath.row]
                self.cinemaData = selectedCinema
                self.fetchMovie(cityUUID: cityUUID, cinemaUUID: selectedCinema.uuid)
                self.getCinema(cityData: cityData, cinemasData: selectedCinema)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchMovie(cityUUID: String = "", cinemaUUID: String = "", date: Date = Date()) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dates = formatter.string(from: date as Date)
        let url = "https://afisha.api.kinopark.kz/api/movie/today?date_from=\(dates)&sort=seance.start_time&city=\(cityUUID)&cinema=\(cinemaUUID)"
        
        NetworkManager.shared.fetchWithBearerToken(dataType: MoviesModel.self, from: url) { result in
            switch result {
            case .success(let movies):
                self.movies = movies.data
                self.mainTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func getCinema(cityData: CitiesData, cinemasData: CinemasData) {
        cinemasButton.setTitle(cinemasData.name, for: .normal)
        let cityUUID = cityData.uuid
        fetchMovie(cityUUID: cityUUID, cinemaUUID: cinemasData.uuid)
    }
}

// MARK: - Setup TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        
        let movies = movies[indexPath.row]
        cell.cityData = cityData
        cell.cinameData = cinemaData
        cell.configure(movie: movies)
        
        cell.frame = tableView.bounds
        cell.layoutIfNeeded()
        cell.collectionView.reloadData()
        
        let tableContenSize = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
        print("CGFloat", tableContenSize)
        
        //        cell.contentView.heightAnchor.constraint(equalToConstant: cell.contentView.frame.height).isActive = true
        cell.collectionView.heightAnchor.constraint(equalToConstant: tableContenSize).isActive = true
        return cell
    }
}

// MARK: - Setup CollectionView
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Weekly.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyCollectionViewCell.identifier, for: indexPath) as! WeeklyCollectionViewCell
        let dates = Weekly.allCases[indexPath.item]
        let dateFormat = "E. d:MMM"
        switch dates {
        case .today:
            cell.configure(date: dates.rawValue)
            cell.didSelect()
        case .tomorrow:
            cell.configure(date: dates.rawValue)
        case .day3:
            cell.configure(date: dates.dates(day: 2, dateFormat: dateFormat))
        case .day4:
            cell.configure(date: dates.dates(day: 3, dateFormat: dateFormat))
        case .day5:
            cell.configure(date: dates.dates(day: 4, dateFormat: dateFormat))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dates = Weekly.allCases[indexPath.item]
        let dateFormat = "yyyy-MM-dd"
        switch dates {
        case .today:
            print(dates.getDates(day: 0, dateFormat: dateFormat))
        case .tomorrow:
            print(dates.getDates(day: 1, dateFormat: dateFormat))
        case .day3:
            print(dates.dates(day: 2, dateFormat: dateFormat))
        case .day4:
            print(dates.dates(day: 3, dateFormat: dateFormat))
        case .day5:
            print(dates.dates(day: 4, dateFormat: dateFormat))
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? WeeklyCollectionViewCell {
            cell.didSelect()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? WeeklyCollectionViewCell {
            cell.deSeslect()
        }
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
    
}

extension MainViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

extension MainViewController: CinemasTableViewControllerDelegate {
    func getCinema(cinemasData: CinemasData) {
        getCinema(cityData: cityData, cinemasData: cinemasData)
    }
}

//MARK: - Private funcs and Contraints
extension MainViewController {
    
    private func setupTableView() {
        mainTableView.tableHeaderView = headerView
        view.addSubview(mainTableView)
        mainTableView.estimatedRowHeight = 500
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
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize(width: 1, height: 3)
            view.layer.shadowRadius = 3
        }
    }
    
    private func configureSubview(subviews: UIView...) {
        subviews.forEach { subview in
            headerView.addSubview(subview)
        }
    }
    
    private func setupCinemaFilterButton() {
        cinemasButton.setTitle("????????????????...", for: .normal)
        cinemasButton.setTitleColor(
            UIColor(named: "textColor"),
            for: .normal)
        cinemasButton.addTarget(
            self,
            action: #selector(showCinemas),
            for: .touchUpInside)
    }
    
    @objc private func showCinemas() {
        cinemasVC.modalPresentationStyle = .popover
        
        let popOverCitiesVC = cinemasVC.popoverPresentationController
        popOverCitiesVC?.delegate = self
        popOverCitiesVC?.sourceView = cinemasView
        popOverCitiesVC?.sourceRect = CGRect(x: cinemasView.bounds.maxY, y: cinemasView.bounds.midY, width: 0, height: 0)
        cinemasVC.preferredContentSize = CGSize(width: self.view.frame.size.width - 50, height: self.view.frame.size.height - 50)
        
        self.present(cinemasVC, animated: true)
    }
    
    @objc private func filterAction() {
        print("FilterButton")
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
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
    }
}
