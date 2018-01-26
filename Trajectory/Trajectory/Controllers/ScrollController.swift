//
//  ScrollController.swift
//  Trajectory
//
//  Created by student on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class ScrollController: UIPageViewController, UIPageViewControllerDataSource {
    private(set) lazy var orderedViewControllers: [UIViewController] //= [UIViewController]()
    = {
        return [self.newViewController(storyboardID: "GoalsList"),
                self.newViewController(storyboardID: "History")]
    }()
    required init?(coder: NSCoder){
        super.init(coder: coder)
    }
    
    init(viewID1: String, viewID2: String){
        super.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal)
        orderedViewControllers.append(newViewController(storyboardID: viewID1))
        orderedViewControllers.append(newViewController(storyboardID: viewID2))
    }
    
    private func newViewController(storyboardID: String) -> UIViewController {
        
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(storyboardID)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
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
        guard let firstViewController = viewControllers?.first, let
            firstViewControllerIndex = orderedViewControllers.index(of: firstViewController)
        else {
                return 0
        }
        
        return firstViewControllerIndex
    }

}
