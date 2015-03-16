//
//  UIViewController+ARVBottomMenu.swift
//  ARVBottomMenuController
//
//  Created by Arvindh Sukumar on 07/03/15.
//  Copyright (c) 2015 Arvindh Sukumar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var arv_bottomMenuContainer: ARVBottomMenuViewController! {
        
        var controller = self.parentViewController
            
        while controller != nil {
            if controller is ARVBottomMenuViewController{
                return controller as ARVBottomMenuViewController
            }
            controller = controller!.parentViewController
        }
        
        return nil
    }
}