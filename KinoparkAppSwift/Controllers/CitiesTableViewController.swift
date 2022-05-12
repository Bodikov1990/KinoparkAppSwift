//
//  ViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 20.03.2022.
//

import UIKit

class CitiesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var cityList: [CityData] = []
    private let startingUrl = NetworkManager.shared.startingUrl
    
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "showCities")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        showCities()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
        showCities()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showCities", for: indexPath)
        
        if #available(iOS 14.0, *) {
            let city = cityList[indexPath.row]
            var content = cell.defaultContentConfiguration()
            content.text = city.name
            
            cell.contentConfiguration = content
            return cell
        } else {
            let city = cityList[indexPath.row]
            
            cell.textLabel?.text = city.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true) {
            print("diss")
        }
    }
    
    private func showCities() {
        NetworkManager.shared.fetchWithBearerToken(dataType: CityList.self, from: startingUrl, convertFromSnakeCase: true) { result in
            switch result {
            case .success(let cities):
                print("\(cities)")
                self.cityList = cities.data ?? []
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

