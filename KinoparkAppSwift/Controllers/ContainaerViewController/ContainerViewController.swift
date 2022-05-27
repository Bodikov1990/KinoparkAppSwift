//
//  ContainerViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 26.03.2022.
//

import UIKit

class ContainerViewController: UIViewController, UINavigationControllerDelegate {

    
    enum MenuState {
        case closed
        case opened
    }
    
    var cityData: CitiesData!
    
    private var menuState: MenuState = .closed
    
    let mainViewController = MainViewController()
    let sideMenuViewController = SideMenuViewController()
    private let testViewController = TestViewController()

    private var visualEffectView = UIVisualEffectView()
    private let durationForAnimation = 0.5
    
    private lazy var mainVC = generateNavController(
        rootViewcontroller: mainViewController,
        title: "Главная",
        image: "list.and.film",
        navBarIsHidden: false)
    
    private lazy var moviesVC = generateNavController(
        rootViewcontroller: testViewController,
        title: "Фильмы",
        image: "film",
        navBarIsHidden: false)
    
    private lazy var sideMenuVC = UINavigationController(rootViewController: sideMenuViewController)
    
    private lazy var tabBarVC = setupTabBar(viewControllers: mainVC, moviesVC)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        mainViewController.delegate = self
        mainViewController.cityData = cityData
        
        sideMenuViewController.delegate = self
        sideMenuViewController.cityData = cityData

        addChildVCs()
        tapGesture()
        swipeGesture()
    }
    
    private func addChildVCs() {
        //        Menu
        sideMenuVC.view.frame = CGRect(x: tabBarVC.view.frame.width + 5, y: 0, width: sideMenuVC.view.frame.size.width - 50, height: self.view.frame.size.height)
        addChild(sideMenuVC)
        view.addSubview(sideMenuVC.view)
        sideMenuVC.didMove(toParent: self)
        
        //        TabBar
        addChild(tabBarVC)
        view.addSubview(tabBarVC.view)
        tabBarVC.didMove(toParent: self)
        view.bringSubviewToFront(sideMenuVC.view)
    }
    
    private func setupTabBar(viewControllers: UIViewController...) -> UITabBarController {
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = viewControllers
        tabBarVC.tabBar.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        return tabBarVC
    }
    
    private func generateNavController(rootViewcontroller: UIViewController,
                                       title: String,
                                       image: String,
                                       navBarIsHidden: Bool) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewcontroller)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(systemName: image)
        navigationVC.navigationBar.isHidden = navBarIsHidden
        return navigationVC
    }
}
//MARK: - Private functions for animation
extension ContainerViewController {
    
    private func animateView() {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: durationForAnimation, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.openStateAnimate()
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }

        case .opened:
            UIView.animate(withDuration: durationForAnimation, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.closeStateAnimate()
            } completion: { [weak self] done in
                if done {
                    self?.visualEffectView.removeFromSuperview()
                    self?.menuState = .closed
                }
            }
        }
    }
    
    private func openStateAnimate() {
        sideMenuVC.view.frame.origin.x = 55
        sideMenuVC.view.layer.cornerRadius = 20
        
        visualEffectView.frame = tabBarVC.view.frame
        visualEffectView.effect = UIBlurEffect(style: .systemChromeMaterial)
//        visualEffectView.effect = nil
        tabBarVC.view.addSubview(visualEffectView)
    }
    
    private func closeStateAnimate() {
        sideMenuVC.view.frame.origin.x = self.tabBarVC.view.frame.width
        sideMenuVC.view.layer.cornerRadius = 0
        visualEffectView.effect = nil
    }
    
    private func tapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapedGesture(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        visualEffectView.addGestureRecognizer(tapGestureRecognizer)
        visualEffectView.isUserInteractionEnabled = true
        
    }
    
    @objc private func tapedGesture(_ gesture: UITapGestureRecognizer) {
        animateView()
        sideMenuViewController.delegate?.getCities(cityData: sideMenuViewController.cityData)
    }
    
    private func swipeGesture() {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedGesture(_:)))
        swipeGestureRecognizer.direction = .right
        swipeGestureRecognizer.numberOfTouchesRequired = 1
        sideMenuVC.view.addGestureRecognizer(swipeGestureRecognizer)
        sideMenuVC.view.isUserInteractionEnabled = true
    }
    
    @objc private func swipedGesture(_ gesture: UISwipeGestureRecognizer) {
        animateView()
        sideMenuViewController.delegate?.getCities(cityData: sideMenuViewController.cityData)
    }
}

extension ContainerViewController: MainViewControllerDelegate {
    func didTapSideMenu() {
        animateView()
    }
}

extension ContainerViewController: SideMenuViewControllerDelegate {
    func closeButton() {
        animateView()
    }
    
    func getCities(cityData: CitiesData) {
        mainViewController.cityData = cityData
        mainViewController.fetchCinemas(cityData: cityData)
        self.cityData = cityData
    }
}

extension ContainerViewController: CitiesViewControllerDelegate {
    func getCity(cityData: CitiesData) {
        print(cityData)
    }
}
