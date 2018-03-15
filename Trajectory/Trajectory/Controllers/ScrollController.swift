//
//  ScrollController.swift
//  Trajectory
//
//  Created by student on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

// Tutorial used to create this class
// Had to update a large amount of the code base but it works well!

//https://spin.atomicobject.com/2015/12/23/swift-uipageviewcontroller-tutorial/

import UIKit

class ScrollController: UIPageViewController {
    //private(set) lazy var orderedViewControllers: [UIViewController] = [UIViewController]()
    internal(set) lazy var orderedViewControllers: [UIViewController] = [UIViewController]()

    var startIndex: Int = 0;
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.delegate = self
        self.dataSource = self
    }
    
    init(){
        super.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal)
        self.delegate = self
        self.dataSource = self
    }
    

    internal func addViewControllers(views: String..., startIndex: Int = 0){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        for view in views {
            orderedViewControllers.append(mainStoryboard.instantiateViewController(withIdentifier: "\(view)"))
        }
        self.startIndex = startIndex
    }
    
    /*private func newViewController(storyboardID: String) -> UIViewController {
        
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(storyboardID)")
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        let firstViewController = orderedViewControllers[startIndex]
        setViewControllers([firstViewController],
                            direction: .forward,
                            animated: true,
                            completion: nil)
        self.title = firstViewController.title
    }
    
    

    
   /* override func viewDidLayoutSubviews() {
        //corrects scrollview frame to allow for full-screen view controller pages
        for subView in self.view.subviews {
            if subView is UIScrollView {
                subView.frame = self.view.bounds
            }
        }
        super.viewDidLayoutSubviews()
    }*/

}

extension ScrollController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController)
            else {
                return 0
        }
        return firstViewControllerIndex
    }

}

extension ScrollController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.title = pendingViewControllers.first?.title
    }
}
