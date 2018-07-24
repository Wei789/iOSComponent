//
//  PageViewController.swift
//  TYSliderView
//
//  Created by Weichen Cheng_鄭惟臣 on 2018/7/13.
//  Copyright © 2018年 Weichen Cheng_鄭惟臣. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    let pageCount = 3
    var pageControl: UIPageControl!
    var vcs = [UIViewController]()
    var colors = [UIColor.red, UIColor.green, UIColor.blue]
    var pendingPage = 0
    var gameTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setViewControllers([vcs[pendingPage]], direction: .forward, animated: true, completion: nil)
        dataSource = self
        delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        pageControl.frame = CGRect(x: 0, y: self.view.frame.maxY - 80, width: self.view.frame.width, height: 50)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        gameTimer.invalidate()
    }
    
    private func setupUI() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = pageCount
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.addTarget(self, action: #selector(self.pageChanged), for: .valueChanged)
        self.view.addSubview(pageControl)
        
        for i in 0..<pageCount {
            let vc = storyboard?.instantiateViewController(withIdentifier: "vc") as! PageItemViewController
            vc.color = colors[i]
            vcs.append(vc)
        }
    }
    
    @objc func pageChanged(sender: UIPageControl) {
        let index = sender.currentPage
        setViewControllers([vcs[index]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func runTimedCode() {
        pendingPage = pendingPage + 1 >= pageCount ? 0 : pendingPage + 1
        pageControl.currentPage = pendingPage
        setViewControllers([vcs[pendingPage]], direction: .forward, animated: true, completion: nil)
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = vcs.index(of: viewController), index > 0 {
            return vcs[index - 1]
        } else {
            return vcs[pageCount - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = vcs.index(of: viewController), index < vcs.count - 1 {
            return vcs[index + 1]
        } else {
            return vcs[0]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingPage = vcs.index(of: pendingViewControllers.first!)!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else {
            return
        }
        
        pageControl.currentPage = pendingPage
    }
}
