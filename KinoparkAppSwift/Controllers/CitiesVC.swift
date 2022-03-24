//
//  ViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 20.03.2022.
//

import UIKit

class CitiesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let currentUrl = "http://test.afisha.api.kinopark.kz/api/city?page=1&per_page=15&sort=sort_order:asc&dial_timeout=5s&request_timeout=5s&retries=0"
    
    private var cityList: [Datum] = []
    
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "showCities")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addLogoToNav()
        showCities()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
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
            // Fallback on earlier versions
            let city = cityList[indexPath.row]
            
            cell.textLabel?.text = city.name
            cell.detailTextLabel?.text = city.code
        }
        
        return cell
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
    
    private func showCities() {
        NetworkManager.shared.fetch(dataType: CityList.self, from: currentUrl, convertFromSnakeCase: true) { result in
            switch result {
            case .success(let cities):
                print(cities)
                self.cityList = cities.data ?? []
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

