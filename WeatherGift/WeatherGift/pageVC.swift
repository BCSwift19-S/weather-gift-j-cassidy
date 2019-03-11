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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        
        setViewControllers([createdetailVC(forPage: 0)], direction: .forward, animated: false, completion: nil)
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
}
