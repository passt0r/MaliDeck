//
//  StatCardViewController.swift
//  MaliDeck
//
//  Created by Dmytro Pasinchuk on 07.02.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit

class StatCardViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    /*@IBAction func backToMainScreen(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: {print("Return to main screen")})
    } */
    
    @IBOutlet weak var backToMainButton: UIBarButtonItem!
    //TODO: Check why working with index will make fails pages
    var index = 0 { didSet {
        print("New index set value \(index)")
        }
    }//index for stat card views(0 for firstPage, 1 for secondPage)
    
    var availableHits = 0 {
        didSet {
            print("Available hits = \(availableHits)")
        }
    }
    
    var currentFront = UIImage()
    var currentBack = UIImage()
    var currentMember: Stats?
    var hitsLeft = 0
    
    
    
    lazy var statCartViewControllers: [UIViewController] = {
        
        return [ self.createStatCardViewController(withName: "FirstCardViewController"),
                 self.createStatCardViewController(withName: "SecondCardViewController")]
    }() //an array of stat card view controllers
    
   private func createStatCardViewController(withName name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    } //func to represent a stat card view controllers, using for array of UIViewControllers
    
    
    private func takeStatCardViewController(withIndex currentIndex: Int) -> UIViewController? { //func that operate with all view controllers for this pageViewControllew, take index of current ViewController and return ViewController with such index
        
        
        if currentIndex < 0 || currentIndex >= statCartViewControllers.count {
            return nil
        }
        self.index = currentIndex
        
       // return presentControllers[index] why it is not working correctly?
       /* if let takenViewController = storyboard?.instantiateViewController(withIdentifier: pagesNames[index]) {
            return takenViewController
        }*/
        
        return statCartViewControllers[currentIndex]
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let firstPage = takeStatCardViewController(withIndex: 0) { //implement first viewController
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
            print("Page number \(index))")
        }
        // Do any additional setup after loading the view.
        
        guard let member = currentMember else { fatalError("Unexpected member was found, can't read any data") }
        
    }
    
    override func viewDidLayoutSubviews() { //set backround image for navigation dots at screen bottom
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            /*if view is UIScrollView {
                view.frame = UIScreen.main.bounds
             } else*/
            if view is UIPageControl {
                let imageView = UIImageView(image: UIImage(named: "paper"))
                imageView.frame = UIScreen.main.bounds
                view.backgroundColor = UIColor.clear
                view.insertSubview(imageView, at: 0)
            }
        }
    }
    
    // In terms of navigation direction. For example, for 'UIPageViewControllerNavigationOrientationHorizontal', view controllers coming 'before' would be to the left of the argument view controller, those coming 'after' would be to the right.
    // Return 'nil' to indicate that no more progress can be made in the given direction.
    // For gesture-initiated transitions, the page view controller obtains view controllers via these methods, so use of setViewControllers:direction:animated:completion: is not required.
   
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        //let currentIndex = (pageViewController as! StatCardViewController).index //dont work correctly
        guard let currentIndex = statCartViewControllers.index(of: viewController) else {
        
            return nil
        }
         let newIndex = currentIndex - 1
        return takeStatCardViewController(withIndex: newIndex)
 
        /*
        guard let newIndex = statCartViewControllers.index(of: viewController) else {
            return nil
        }
        if newIndex - 1 < 0 {
            return nil
        }
        self.index = newIndex
        return statCartViewControllers[newIndex - 1]
        */
        
        
    }
    
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        guard let currentIndex = statCartViewControllers.index(of: viewController) else {
            return nil
        }
        let newIndex = currentIndex + 1
        
        return takeStatCardViewController(withIndex: newIndex)
        

        
        /*guard let newIndex = statCartViewControllers.index(of: viewController) else {
            return nil
        }
        
        if  newIndex + 1 >= self.statCartViewControllers.count{
            return nil
        }
        self.index = newIndex
        return  statCartViewControllers[newIndex + 1]
        */
 
    }
    
    
    // A page indicator will be visible if both methods are implemented, transition style is 'UIPageViewControllerTransitionStyleScroll', and navigation orientation is 'UIPageViewControllerNavigationOrientationHorizontal'.
    // Both methods are called in response to a 'setViewControllers:...' call, but the presentation index is updated automatically in the case of gesture-driven navigation.
    
     public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return statCartViewControllers.count
        
    }// The number of items reflected in the page indicator.
    
    
     public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return index
        
    }// The selected item reflected in the page indicator.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === backToMainButton else {
            print("Unexpected error, sender was invalid")
            return
        }
        guard let firstCard = statCartViewControllers[0] as? FirstPageStatsViewController else { fatalError("Unexpected read data from first card view controller") }
        let hitsLefted = firstCard.woundsBar.hitsLeft
        hitsLeft = hitsLefted
        
    }
    
    

}
