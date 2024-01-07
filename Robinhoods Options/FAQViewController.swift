//
//  FAQViewController.swift
//  Robinhoods Options
//
//  Created by Ravil on 07.12.2023.
//

import UIKit

class FAQViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController!
    var pageViewControllers: [UIViewController] = []
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Alias", "Quiz"])
        control.selectedSegmentIndex = 0
        
        let font = UIFont(name: "NotoSans-Medium", size: 16)
        control.setTitleTextAttributes([.font: font as Any, .foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([.font: font as Any, .foregroundColor: UIColor.black], for: .normal)
                
        if #available(iOS 13.0, *) {
            control.selectedSegmentTintColor = .black
        } else {
            control.tintColor = .black
        }
        control.layer.cornerRadius = 10
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColor.backgroundLightGray.uiColor
        
        view.addSubview(segmentedControl)
        setupSegmentedControlConstraints()
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        setupUI()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let titleLabel = UILabel()
        titleLabel.text = "How to play?"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "NotoSans-SemiBold", size: 16)
        navigationItem.titleView = titleLabel

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundImage = UIImage(named: "navbar")
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func setupSegmentedControlConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        if UIScreen.main.bounds.size.height >= 812 {
            NSLayoutConstraint.activate([
                segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            ])
        } else {
            NSLayoutConstraint.activate([
                segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            ])
        }
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        // Обработка изменения выбранного сегмента
        if let selectedViewController = pageViewControllers[safe: sender.selectedSegmentIndex] {
            pageViewController.setViewControllers([selectedViewController], direction: .forward, animated: false, completion: nil)
        }
    }
    
    // MARK: - UIPageViewControllerDelegate methods
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleViewController = pageViewController.viewControllers?.first, let index = pageViewControllers.firstIndex(of: visibleViewController) {
            // Синхронизация segmentedControl с текущей страницей
            segmentedControl.selectedSegmentIndex = index
        }
    }
    
    func setupUI() {
        // Создание UIPageViewController
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        // Создание контроллеров страниц
        let aliasVC = AliasListViewController()
        let quizVC = QuizListViewController()
        pageViewControllers = [aliasVC, quizVC]
        
        // Установка начального контроллера
        if let firstViewController = pageViewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        // Добавление UIPageViewController в иерархию представлений
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        // Настройка ограничений для UIPageViewController
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 24),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - UIPageViewControllerDataSource methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard pageViewControllers.count > previousIndex else {
            return nil
        }
        
        return pageViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard pageViewControllers.count != nextIndex else {
            return nil
        }
        
        guard pageViewControllers.count > nextIndex else {
            return nil
        }
        
        return pageViewControllers[nextIndex]
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
