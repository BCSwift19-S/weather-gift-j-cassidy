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
    var locationsArray = [WeatherLocation]()
    var pageControl: UIPageControl!
    var listButton: UIButton!
    var barButtonWidth: CGFloat = 44
    var barButtonHeight: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        var newLocation = WeatherLocation()
        newLocation.name = "Unknown Weather Location"
        locationsArray.append(newLocation)
        
        setViewControllers([createdetailVC(forPage: 0)], direction: .forward, animated: false, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configurePageControl()
        configureListButton()
    }
    //MARK:- UI Configuration Methods
    func configurePageControl() {
        let pageControlHeight: CGFloat = barButtonHeight
        let pageControlWidth: CGFloat = view.frame.width - (barButtonWidth * 2)
        
        let safeHeight = view.frame.height - view.safeAreaInsets.bottom
        
        pageControl = UIPageControl(frame: CGRect(x: (view.frame.width - pageControlWidth)/2, y: (safeHeight - pageControlHeight), width: pageControlWidth, height: pageControlHeight))
        
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.numberOfPages = locationsArray.count
        pageControl.currentPage = currentPage
        pageControl.addTarget(self, action: #selector(pageControlPressed), for: .touchUpInside)
        view.addSubview(pageControl)
    }
    
    func configureListButton() {
        let barButtonHeight = barButtonWidth
        let safeHeight = view.frame.height - view.safeAreaInsets.bottom
        listButton = UIButton(frame: CGRect(x: view.frame.width-barButtonWidth, y: safeHeight-barButtonHeight, width: barButtonWidth, height: barButtonHeight))
        listButton.setImage(UIImage(named: "listbutton"), for: .normal)
        listButton.setImage(UIImage(named: "listbutton-highlighted"), for: .highlighted)
        listButton.addTarget(self, action: #selector(segueToListVC), for: .touchUpInside)
        view.addSubview(listButton)
        
    }
    
    //Mark:- Segues
    @objc func segueToListVC() {
        performSegue(withIdentifier: "ToListVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToListVC" {
            let destination = segue.destination as! listVC
            destination.locationsArray = locationsArray
            destination.currentPage = currentPage
            
        }
    }
    
    @IBAction func unwindFromListVC(sender: UIStoryboardSegue) {
        pageControl.numberOfPages = locationsArray.count
        pageControl.currentPage = currentPage
        setViewControllers([createdetailVC(forPage: currentPage)], direction: .forward, animated: false, completion: nil)
    }
    
    //MARK:- Create view controller for UIPageViewController
    func createdetailVC(forPage page: Int) -> detailVC {
        currentPage = min(max(0, page), locationsArray.count-1)
        
        let detailVC = storyboard!.instantiateViewController(withIdentifier: "VC") as! detailVC
        detailVC.locationsArray = locationsArray
        detailVC.currentPage = currentPage
        return detailVC
        
    }
    
}


extension pageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? detailVC {
            if currentViewController.currentPage < locationsArray.count-1 {
                return createdetailVC(forPage: currentViewController.currentPage+1)
            }
            
        }
        return nil
        
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? detailVC {
            if currentViewController.currentPage > 0 {
                return createdetailVC(forPage: currentViewController.currentPage-1)
            }
        }
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?[0] as? detailVC {
            pageControl.currentPage = currentViewController.currentPage
        }
    }
    
    
    @objc func pageControlPressed() {
        if let currentViewController = self.viewControllers?[0] as? detailVC {
            currentPage = currentViewController.currentPage
            if pageControl.currentPage < currentPage {
                setViewControllers([createdetailVC(forPage: pageControl.currentPage)], direction: .reverse, animated: true, completion: nil)
            }else if pageControl.currentPage > currentPage {
                setViewControllers([createdetailVC(forPage: pageControl.currentPage)], direction: .forward, animated: true, completion: nil)
            }
            
        }
        
    }
    
    
}
