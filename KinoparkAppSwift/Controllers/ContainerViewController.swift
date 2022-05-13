//
//  ContainerViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 26.03.2022.
//

import UIKit


class ContainerViewController: UIViewController, UINavigationControllerDelegate {
    
    enum MenuState {
        case expanded
        case collapsed
    }
    
    private let mainViewController = MainViewController()
    private let citiesTableViewController = CitiesTableViewController()
    private let sideMenuViewController = SideMenuViewController()
    private lazy var sideMenuWithNavVC = UINavigationController(rootViewController: sideMenuViewController)
    private var visualEffectView: UIVisualEffectView!
    
    private let sideMenuWidth: CGFloat = 350
    private let sideMenuHandleAreaWidth: CGFloat = 0
    private let duratioForAnimation = 0.5
    
    private var menuVisible = false
    private var nextState: MenuState {
        return menuVisible ? .collapsed : .expanded
    }
    
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterupted: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewController.delegate = self
        
        setupTabBar()
        setupMenu()
        sideMenuViewController.delegate = self
        
    }
    
    private func setupTabBar() {
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [
            generateNavController(
                rootViewcontroller: mainViewController,
                title: "Главная",
                image: "list.and.film",
                navBarIsHidden: false),
            generateNavController(
                rootViewcontroller: citiesTableViewController,
                title: "Фильмы",
                image: "film",
                navBarIsHidden: false)
        ]
        tabBarVC.tabBar.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        addChild(tabBarVC)
        view.addSubview(tabBarVC.view)
        tabBarVC.didMove(toParent: self)
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
    
    private func setupMenu() {
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.isHidden = true
        
        
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        addChild(sideMenuWithNavVC)
        view.addSubview(sideMenuWithNavVC.view)
        sideMenuWithNavVC.didMove(toParent: self)
        
        sideMenuWithNavVC.view.frame = CGRect(x: self.view.frame.width - sideMenuHandleAreaWidth, y: 0, width: sideMenuWidth, height: self.view.bounds.height)
        
        sideMenuWithNavVC.view.clipsToBounds = true
        
        let panGestureRecognizier = UIPanGestureRecognizer(
            target: self,
            action: #selector(ContainerViewController.handleSideMenuPanGesture(recognizier:)
                             )
        )
        sideMenuWithNavVC.view.addGestureRecognizer(panGestureRecognizier)
        
    }
    
    @objc private func handleSideMenuPanGesture(recognizier: UIPanGestureRecognizer) {
        switch recognizier.state {
            
        case .began:
            startInteractiveTransition(state: nextState, duration: duratioForAnimation)
        case .changed:
            let translation = recognizier.translation(in: self.sideMenuWithNavVC.view)
            var fractionComplete = translation.x / sideMenuWidth
            fractionComplete = menuVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTtransition()
        case .possible:
            break
        case .cancelled:
            break
        case .failed:
            break
        @unknown default:
            break
        }
    }
    
    private func animateTransitionIfNeed(state: MenuState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.8) {
                switch state {
                case .expanded:
                    self.sideMenuWithNavVC.view.frame.origin.x = self.view.frame.width - self.sideMenuWidth
                case .collapsed:
                    self.sideMenuWithNavVC.view.frame.origin.x = self.view.frame.width - self.sideMenuHandleAreaWidth
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.menuVisible = !self.menuVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRaduisAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.sideMenuWithNavVC.view.layer.cornerRadius = 10
                case .collapsed:
                    self.sideMenuWithNavVC.view.layer.cornerRadius = 0
                }
            }
            
            cornerRaduisAnimator.startAnimation()
            runningAnimations.append(cornerRaduisAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .systemChromeMaterial)
                    self.visualEffectView.isHidden.toggle()
                case .collapsed:
                    self.visualEffectView.effect = nil
                    DispatchQueue.main.asyncAfter(deadline: .now()+duration) {
                        self.visualEffectView.isHidden.toggle()
                    }
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }
    
    
    private func startInteractiveTransition(state: MenuState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeed(state: state, duration: duration)
        }
        
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterupted = animator.fractionComplete
        }
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterupted
        }
    }
    
    private func continueInteractiveTtransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}

extension ContainerViewController: MainViewControllerDelegate {
    func ta() {
        print("ta")
    }
    
    func didTapSideMenu() {
        animateTransitionIfNeed(state: nextState, duration: duratioForAnimation)
    }
}

extension ContainerViewController: SideMenuViewControllerDelegate {
    func closeButton() {
        animateTransitionIfNeed(state: nextState, duration: duratioForAnimation)
    }
}
