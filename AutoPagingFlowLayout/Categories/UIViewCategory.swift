//
//  ViewCategory.swift
//  CategorySwift
//
//  Created by chunxi on 16/3/23.
//  Copyright © 2016年 chunxi. All rights reserved.
//

import UIKit

public extension UIView {
 
    var wk_Width: CGFloat {
        set {
            var frame: CGRect = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
             return self.frame.size.width
        }
    }
    
    
    var wk_Height: CGFloat {
        set {
            var frame: CGRect = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    
    var wk_Size: CGSize {
        set {
            var frame: CGRect = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return self.frame.size
        }
    }
    
    var wk_Origin: CGPoint {
        set {
          var frame: CGRect = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {
          return self.frame.origin
        }
    }
    
    
    var top: CGFloat {
        set {
            var frame: CGRect = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        
        get {
            return self.frame.origin.y
        }
    }
    
    
    var left: CGFloat {
        set {
            var frame: CGRect = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        
        get {
            return self.frame.origin.x
        }
    }
    
    
    var bottom: CGFloat {
        set {
            var frame: CGRect = self.frame
            frame.origin.y  = newValue - frame.size.height
            self.frame = frame
        }
        get {
            return self.top + self.wk_Height
        }
    }
    
    
    var right: CGFloat {
        set{
            var frame: CGRect = self.frame
            frame.origin.x  = newValue - frame.size.width
            self.frame = frame
        }
        
        get{
            return self.left + self.wk_Width
        }
    }
    
}

