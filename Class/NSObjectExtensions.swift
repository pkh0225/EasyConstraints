//
//  NSObjectExtensions.swift
//  ssg
//
//  Created by pkh on 2018. 1. 26..
//  Copyright © 2018년 emart. All rights reserved.
//

import Foundation

private var Object_class_Name_Key : UInt8 = 0
private var Object_iVar_Name_Key : UInt8 = 0
private var Object_iVar_Value_Key : UInt8 = 0


@inline(__always) public func swiftClassFromString(_ className: String, bundleName: String = "WiggleSDK") -> AnyClass? {
    
    // get the project name
    if  let appName = Bundle.main.object(forInfoDictionaryKey:"CFBundleName") as? String {
        // generate the full name of your class (take a look into your "YourProject-swift.h" file)
        let classStringName = "\(appName).\(className)"
        guard let aClass = NSClassFromString(classStringName) else {
            let classStringName = "\(bundleName).\(className)"
            guard let aClass = NSClassFromString(classStringName) else {
//                print(">>>>>>>>>>>>> [ \(className) ] : swiftClassFromString Create Fail <<<<<<<<<<<<<<")
                return nil
                
            }
            return aClass
        }
        return aClass
    }
//    print(">>>>>>>>>>>>> [ \(className) ] : swiftClassFromString Create Fail <<<<<<<<<<<<<<")
    return nil
}


extension NSObject {
    
    public var tag_name: String? {
        get {
            return objc_getAssociatedObject(self, &Object_iVar_Name_Key) as? String
        }
        set {
            objc_setAssociatedObject(self, &Object_iVar_Name_Key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public var tag_value: Any? {
        get {
            return objc_getAssociatedObject(self, &Object_iVar_Value_Key)
        }
        set {
            objc_setAssociatedObject(self, &Object_iVar_Value_Key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var className: String {
        if let name = objc_getAssociatedObject(self, &Object_class_Name_Key) as? String {
            return name
        }
        else {
            let name = String(describing: type(of:self))
            objc_setAssociatedObject(self, &Object_class_Name_Key, name, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return name
        }
        
        
    }
    
    public class var className: String {
        if let name = objc_getAssociatedObject(self, &Object_class_Name_Key) as? String {
            return name
        }
        else {
            let name = NSStringFromClass(self).components(separatedBy: ".").last ?? ""
            objc_setAssociatedObject(self, &Object_class_Name_Key, name, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return name
        }
    }
}

