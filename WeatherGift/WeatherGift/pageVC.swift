//
//  pageVC.swift
//  WeatherGift
//
//  Created by James Cassidy on 3/11/19.
//  Copyright © 2019 James Cassidy. All rights reserved.
//

import UIKit

class pageVC: UIPageViewController {
    
    var currentPage = 0
    var locationsArray = ["Boston", "Philadelphia", "NYC", "LA", "SF"]
    var pageControl: UIPageControl!
    let barButtonWidth: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        
        setViewControllers([createdetailVC(forPage: 0)], direction: .forward, animated: false, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureAboutButton()
        configureListButton()
        configurePageControl()
    }
    
    func configurePageControl() {
        let largestWidth = max(barButtonWidth, aboutButton.frame.width)
        let pageControlHeight: CGFloat = barButtonWidth
        let pageControlWidth: CGFloat = view.frame.width - (largestWidth * 2)
        let safeHeight = view.frame.height -
            view.safeAreaInsets.bottom
        pageControl = UIPageControl(frame: CGRect(x: (view.frame.width - pageControlWidth)/2, y: safeHeight - pageControlHeight, width: pageControlWidth, height: pageControlHeight))
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.white
        pageControl.numberOfPages = locationsArray.count
        pageControl.currentPage = currentPage
        pageControl.addTarget(self, action: #selector(pageControlPressed), for: .touchUpInside)
        view.addSubview(pageControl)
    }
    
    func createdetailVC(forPage page: Int) -> detailVC {
        currentPage = min(max(0, page), locationsArray.count - 1)
        
        let detailVC = storyboard!.instantiateViewController(withIdentifier: "detailVC") as! detailVC
        
        detailVC.locationsArray = locationsArray
        detailVC.currentPage = currentPage
        
        return detailVC
    }
    
}

extension pageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let currentViewController = viewController as? detailVC {
            if currentViewController.currentPage < locationsArray.count - 1 {
                return createdetailVC(forPage: currentViewController.currentPage + 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let currentViewController = viewController as? detailVC {
            if currentViewController.currentPage > 0 {
                return createdetailVC(forPage: currentViewController.currentPage - 1)
            }
        }
        return nil
}
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?[0] as? DetailVC {
            pageControl.currentPage = currentViewController.currentPage
        }
    }
}
