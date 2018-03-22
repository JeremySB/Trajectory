//
//  GoalsPageViewController.swift
//  Trajectory
//
//  Created by student on 1/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//



import UIKit
import Foundation

class GoalsPageViewController: ScrollController{
    /*required init?(coder: NSCoder){
        super.init(coder: coder)
    }
    override init(){
        super.init()
    }*/
    
    override func viewDidLoad() {
        addViewControllers(views: "History", "GoalsList", startIndex: 1)
        //var image = UIImage(named: "TrajectoryBackground")
        //self.view.backgroundColor = UIColor(patternImage: (UIImage(named: "TrajectoryBackground"))!)
            
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "TrajectoryBackground")
        self.view.insertSubview(backgroundImage, at: 0)
        super.viewDidLoad()
    }
    /*override init(){
        super.init()
        addViewControllers(views: "History", "GoalsList", startIndex: 1)
    }*/
    
}

/*UIPageViewController, UIPageViewControllerDataSource {
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(storyboardID: "GoalsList"),
                self.newViewController(storyboardID: "History")]
    }()
    
    private func newViewController(storyboardID: String) -> UIViewController {
        
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(storyboardID)")//ViewController")
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
}*/
