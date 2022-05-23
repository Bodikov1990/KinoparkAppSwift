//
//  ViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 20.03.2022.
//

import UIKit

protocol CitiesViewControllerDelegate: AnyObject {
    func getCity(cityData: CitiesData)
}

class CitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: CitiesViewControllerDelegate?
   
    var cityData: [CitiesData] = []
    private let startingUrl = NetworkManager.shared.startingUrl
    private let identifier = "showCities"
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        showCities()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let city = cityData[indexPath.row]
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = city.name
            cell.contentConfiguration = content
            return cell
        } else {
            cell.textLabel?.text = city.name
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let city = cityData[indexPath.row]
        
        delegate?.getCity(cityData: city)
        dismiss(animated: true)
    }
    
    
    private func showCities() {
        NetworkManager.shared.fetchWithBearerToken(dataType: CityList.self, from: startingUrl) { result in
            switch result {
            case .success(let cities):
                self.cityData = cities.data
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
