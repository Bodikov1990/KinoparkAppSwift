//
//  SideMenuViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 26.03.2022.
//

import UIKit

protocol SideMenuViewControllerDelegate: AnyObject {
    func closeButton()
}

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum MenuOptions: String, CaseIterable {
        case city = "Город"
        case language = "Язык"
        case FAQ = "Часто задаваемые вопросы"
        case rules = "Пользовательское соглашение"
        case confidence = "Политика конфиденциальности"
        case contacts = "Связаться с нами"
        
        var imageName: String {
            switch self {
            case .city:
                return "mappin.and.ellipse"
            case .language:
                return "questionmark.circle"
            case .FAQ:
                return "questionmark.circle"
            case .rules:
                return "hand.raised.slash"
            case .confidence:
                return "list.dash.header.rectangle"
            case .contacts:
                return "envelope"
            }
        }
    }
    
    var delegate: SideMenuViewControllerDelegate?
    
    private let headerView = UIView()
    private let personImageView: UIImageView = {
        let imageName = "person.crop.circle"
        let image: UIImage!
        if #available(iOS 13.0, *) {
            image = UIImage(systemName: imageName)
        } else {
            image = UIImage(named: imageName)
        }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 130, height: 30))
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var segmentModeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menu")
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private lazy var modeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Системный", "Светлый", "Темный"])
        segmentedControl.frame = CGRect(x: 0, y: 0, width: view.frame.size.width - 24, height: 24)
        segmentedControl.backgroundColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        segmentedControl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(sideMenu), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
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
        segmentModeLabel.text = "Выберите режим экрана"
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 70)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath)
        
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        if #available(iOS 13.0, *) {
            cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
            cell.imageView?.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        } else {
            cell.imageView?.image = UIImage(named: MenuOptions.allCases[indexPath.row].imageName)
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let options = MenuOptions.allCases[indexPath.row]
        switch options {
        case .city:
            let option = CitiesTableViewController()
            show(option, sender: nil)
        case .language:
            let option = MainViewController()
            show(option, sender: nil)
        case .FAQ:
            let option = CitiesTableViewController()
            show(option, sender: nil)
        case .rules:
            let option = CitiesTableViewController()
            show(option, sender: nil)
        case .confidence:
            let option = CitiesTableViewController()
            show(option, sender: nil)
        case .contacts:
            let option = CitiesTableViewController()
            show(option, sender: nil)
        }
    }
}

extension SideMenuViewController {
    private func setupNavBar() {
        title = "Мой Kinopark"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "xmark"),
            style: .plain,
            target: self,
            action: #selector(sideMenu)
        )
        navigationController?.navigationBar.tintColor = UIColor(named: "textColor")
    }
    
    @objc private func sideMenu(){
        delegate?.closeButton()
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
            nameLabel.widthAnchor.constraint(equalToConstant: nameLabel.frame.size.width)
        ])
        
        tableView.addSubview(segmentModeLabel)
        
        NSLayoutConstraint.activate([
            segmentModeLabel.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 100),
            segmentModeLabel.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 16),
            segmentModeLabel.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -16)
        ])
    }
}

