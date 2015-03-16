//
//  ARVBottomMenuViewController.swift
//  ARVBottomMenuController
//
//  Created by Arvindh Sukumar on 06/03/15.
//  Copyright (c) 2015 Arvindh Sukumar. All rights reserved.
//

import UIKit

enum ARVBottomMenuState {
    case Opened
    case Closed
}

@objc protocol ARVBottomMenuViewDelegate {
    
    optional func heightForBottomController()->CGFloat
}

class ARVBottomMenuViewController: UIViewController {

    let defaultMenuHeight: CGFloat = 300
    var bottomMenuHeight: CGFloat = 200
    var mainController: UIViewController! {
        didSet {
            
            
            if oldValue != nil{
                self.removeController(oldValue)
            }
            
            self.setupMainController()
        }
    }

    var bottomControllers:[UIViewController] = []
    var bottomController: UIViewController! {
        didSet {
            
            
            if oldValue != nil{
                self.removeController(oldValue)
            }
            
            self.setupBottomController()
            
        }
    }
    var delegate: ARVBottomMenuViewDelegate?
    var parallaxOffset: CGFloat = 140
    var menuState: ARVBottomMenuState = ARVBottomMenuState.Closed
    
    convenience init(mainController:UIViewController){
        self.init(mainController:mainController, bottomControllers:[])

    }
    
    convenience init(mainController:UIViewController, bottomController:UIViewController?) {
        var bottomControllers:[UIViewController] = []
        if let bc = bottomController {
            bottomControllers.append(bc)
        }
        self.init(mainController:mainController, bottomControllers:bottomControllers)
        
        
    }
    
    init(mainController:UIViewController, bottomControllers:[UIViewController]) {
        super.init()
        self.mainController = mainController
        self.bottomControllers = bottomControllers
        if self.bottomControllers.count > 0{
            self.bottomController = self.bottomControllers[0]
        }
       
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.setupMainController()
        self.setupBottomController()
        // Do any additional setup after loading the view.
    }
    
    func removeController(controller:UIViewController){
        controller.view.removeFromSuperview()
        controller.willMoveToParentViewController(nil)
        controller.beginAppearanceTransition(false, animated: false)
        controller.removeFromParentViewController()
        controller.endAppearanceTransition()
    }
    
    func setupMainController(){
        var frame = self.view.bounds
        mainController.view.frame = frame
        self.addChildViewController(mainController)
        mainController.didMoveToParentViewController(self)
        self.view.insertSubview(mainController.view, atIndex: 0)
    }
    
    func setupBottomController(){
        var frame = self.bottomController.view.frame
        self.bottomMenuHeight = self.bottomController.view.frame.size.height
        
        frame.origin.y = self.view.bounds.size.height - frame.size.height + self.parallaxOffset
        bottomController.view.frame = frame
        self.addChildViewController(bottomController)
        bottomController.didMoveToParentViewController(self)
        self.view.insertSubview(bottomController.view, belowSubview: self.mainController.view)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mainController.beginAppearanceTransition(true , animated: animated)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.mainController.endAppearanceTransition()

       
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            
            
            
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.mainController.beginAppearanceTransition(false , animated: animated)

    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.mainController.endAppearanceTransition()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleBottomMenu(shouldOpen:Bool) {
        
        self.view.userInteractionEnabled = false
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            var frame = self.view.bounds
            var originAdjustment: CGFloat = shouldOpen ? self.bottomMenuHeight - 20 : 0
            frame.origin.y = 0 - originAdjustment
            self.mainController.view.frame = frame
            
            var frame2 = self.bottomController.view.frame
            var bottomOriginAdjustment: CGFloat = shouldOpen ? 0 : self.parallaxOffset

            frame2.origin.y =  frame.size.height - self.bottomMenuHeight + bottomOriginAdjustment
            self.bottomController.view.frame = frame2


            }) { (finished:Bool) -> Void in
        
                if finished {
                    self.menuState = shouldOpen ? .Opened : .Closed

                    self.view.userInteractionEnabled = true
                }
        }
        
        
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
