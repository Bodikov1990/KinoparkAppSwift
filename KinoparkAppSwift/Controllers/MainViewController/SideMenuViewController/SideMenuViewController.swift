//
//  SideMenuViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 26.03.2022.
//

import UIKit

protocol SideMenuViewControllerDelegate: AnyObject {
    
    func getCities(cityData: CitiesData)
}

class SideMenuViewController: UIViewController {
    
    var delegate: SideMenuViewControllerDelegate?
    
    var secondLabel: String?
    var cityData: CitiesData!
    
    private let headerView = UIView()
    private let footerView = UIView()
    private let personImageView: UIImageView = {
        let imageName = "person.crop.circle"
        let image = UIImage(systemName: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: 30))
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: SideMenuTableViewCell.identifier)
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        tableView.tableHeaderView = headerView
        configureSubview(subviews: tableView)
        setConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        nameLabel.text = "Kuat Bodikov"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 70)
    }
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SideMenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier, for: indexPath) as! SideMenuTableViewCell
        let menuOptions = SideMenuOptions.allCases[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        
        switch menuOptions {
        case .city:
            cell.configure(option: menuOptions.rawValue, image: menuOptions.imageName)
            cell.secondLabel.isHidden = false
            cell.secondLabel.text = cityData.name
        case .language:
            cell.configure(option: menuOptions.rawValue, image: menuOptions.imageName)
            cell.secondLabel.text = "Язык"
            cell.secondLabel.isHidden = false
        case .faq, .rules, .confidence, .contacts:
            cell.secondLabel.isHidden = true
            cell.configure(option: menuOptions.rawValue, image: menuOptions.imageName)
        case .darkMode:
            cell.accessoryType = .none
            cell.segmentedControl.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let options = SideMenuOptions.allCases[indexPath.row]
        switch options {
        case .city:
            let option = CitiesViewController()
            option.delegate = self
            option.modalPresentationStyle = .overCurrentContext
            present(option, animated: true)
        case .language:
            let option = TestViewController()
            show(option, sender: nil)
        case .faq:
            let option = CitiesViewController()
            show(option, sender: nil)
        case .rules:
            let option = CitiesViewController()
            show(option, sender: nil)
        case .confidence:
            let option = CitiesViewController()
            show(option, sender: nil)
        case .contacts:
            let option = CitiesViewController()
            show(option, sender: nil)
        case .darkMode:
            break
        }
    }
}

extension SideMenuViewController {
    private func setupNavBar() {
        title = "Мой Kinopark"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(sideMenu)
        )
        navigationController?.navigationBar.tintColor = UIColor(named: "textColor")
    }
    
    @objc private func sideMenu(){
        delegate?.getCities(cityData: cityData)
    }
    
    private func configureSubview(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        headerView.addSubview(personImageView)
        
        NSLayoutConstraint.activate([
            personImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            personImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            personImageView.heightAnchor.constraint(equalToConstant: personImageView.frame.size.height),
            personImageView.widthAnchor.constraint(equalToConstant: personImageView.frame.size.width)
        ])
        
        headerView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: personImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 12),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabel.frame.size.height),
        ])
    }
}

extension SideMenuViewController: CitiesViewControllerDelegate {
    func getCity(cityData: CitiesData) {
        self.cityData = cityData
        tableView.reloadData()
    }
}
