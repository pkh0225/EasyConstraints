//
//  UIViewExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//참고 https://github.com/goktugyil/EZSwiftExtensions

#if os(iOS) || os(tvOS)

import UIKit

public typealias VoidClosure = () -> Void

fileprivate var ViewNibs = [String : UIView]()
fileprivate var ViewNibSizes = [String : CGSize]()

public enum VIEW_ADD_TYPE  {
    case horizontal
    case vertical
}

private var viewDidDisappear_key: UInt8 = 0
private var viewDidDisappearTimer_key: UInt8 = 0

private var NSLayoutAttributeWidthEmpty : UInt8 = 0
private var NSLayoutAttributeWidthEmpty_key = UnsafeMutableRawPointer(&NSLayoutAttributeWidthEmpty)
private var NSLayoutAttributeHeightEmpty : UInt32 = 0
private var NSLayoutAttributeHeightEmpty_key = UnsafeMutableRawPointer(&NSLayoutAttributeHeightEmpty)

private var NSLayoutAttributeWidthIsGone : UInt8 = 0
private var NSLayoutAttributeWidthIsGone_key = UnsafeMutableRawPointer(&NSLayoutAttributeWidthIsGone)
private var NSLayoutAttributeHeightIsGone : UInt8 = 0
private var NSLayoutAttributeHeightIsGone_key = UnsafeMutableRawPointer(&NSLayoutAttributeHeightIsGone)
private var NSLayoutAttributeWidthGone : UInt8 = 0
private var NSLayoutAttributeWidthGone_key = UnsafeMutableRawPointer(&NSLayoutAttributeWidthGone)
private var NSLayoutAttributeHeightGone : UInt8 = 0
private var NSLayoutAttributeHeightGone_key = UnsafeMutableRawPointer(&NSLayoutAttributeHeightGone)


private var NSLayoutAttributeTop : UInt8 = 0
private var NSLayoutAttributeBottom  : UInt8 = 0
private var NSLayoutAttributeLeading : UInt8 = 0
private var NSLayoutAttributeTrailing : UInt8 = 0
private var NSLayoutAttributeWidth : UInt8 = 0
private var NSLayoutAttributeHeight : UInt8 = 0
private var NSLayoutAttributeCenterX : UInt8 = 0
private var NSLayoutAttributeCenterY : UInt8 = 0

private var NSLayoutAttributeTop_key = UnsafeMutableRawPointer(&NSLayoutAttributeTop)
private var NSLayoutAttributeBottom_key = UnsafeMutableRawPointer(&NSLayoutAttributeBottom)
private var NSLayoutAttributeLeading_key = UnsafeMutableRawPointer(&NSLayoutAttributeLeading)
private var NSLayoutAttributeTrailing_key = UnsafeMutableRawPointer(&NSLayoutAttributeTrailing)
private var NSLayoutAttributeWidth_key = UnsafeMutableRawPointer(&NSLayoutAttributeWidth)
private var NSLayoutAttributeHeight_key = UnsafeMutableRawPointer(&NSLayoutAttributeHeight)
private var NSLayoutAttributeCenterX_key = UnsafeMutableRawPointer(&NSLayoutAttributeCenterX)
private var NSLayoutAttributeCenterY_key = UnsafeMutableRawPointer(&NSLayoutAttributeCenterY)

private var NSLayoutAttributeDefaultTop : UInt8 = 0
private var NSLayoutAttributeDefaultBottom  : UInt8 = 0
private var NSLayoutAttributeDefaultLeading : UInt8 = 0
private var NSLayoutAttributeDefaultTrailing : UInt8 = 0
private var NSLayoutAttributeDefaultWidth : UInt8 = 0
private var NSLayoutAttributeDefaultHeight : UInt8 = 0
private var NSLayoutAttributeDefaultCenterX : UInt8 = 0
private var NSLayoutAttributeDefaultCenterY : UInt8 = 0

private var NSLayoutAttributeDefaultTop_key = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultTop)
private var NSLayoutAttributeDefaultBottom_key = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultBottom)
private var NSLayoutAttributeDefaultLeading_key = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultLeading)
private var NSLayoutAttributeDefaultTrailing_key = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultTrailing)
private var NSLayoutAttributeDefaultWidth_key = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultWidth)
private var NSLayoutAttributeDefaultHeight_key = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultHeight)
private var NSLayoutAttributeDefaultCenterX_key = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultCenterX)
private var NSLayoutAttributeDefaultCenterY_key = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultCenterY)


    
@inline(__always) private func getLayoutAttributeKey(_ layoutAttribute: NSLayoutAttribute) -> UnsafeMutableRawPointer? {
    switch layoutAttribute {
        case .top:
            return NSLayoutAttributeTop_key
        case .bottom:
            return NSLayoutAttributeBottom_key
        case .leading:
            return NSLayoutAttributeLeading_key
        case .trailing:
            return NSLayoutAttributeTrailing_key
        case .width:
            return NSLayoutAttributeWidth_key
        case .height:
            return NSLayoutAttributeHeight_key
        case .centerX:
            return NSLayoutAttributeCenterX_key
        case .centerY:
            return NSLayoutAttributeCenterY_key
        default:
            return nil
    }
}

@inline(__always) private func getDefaultLayoutAttributeKey(_ layoutAttribute: NSLayoutAttribute) -> UnsafeMutableRawPointer? {
    switch layoutAttribute {
    case .top:
        return NSLayoutAttributeDefaultTop_key
    case .bottom:
        return NSLayoutAttributeDefaultBottom_key
    case .leading:
        return NSLayoutAttributeDefaultLeading_key
    case .trailing:
        return NSLayoutAttributeDefaultTrailing_key
    case .width:
        return NSLayoutAttributeDefaultWidth_key
    case .height:
        return NSLayoutAttributeDefaultHeight_key
    case .centerX:
        return NSLayoutAttributeDefaultCenterX_key
    case .centerY:
        return NSLayoutAttributeDefaultCenterY_key
    default:
        return nil
    }
}
    
    
extension UIView {

    public var widthConstraint: CGFloat {
        get {
            return self.getConstraint(.width)
        }
        set {
            self.setConstraint(.width, newValue)
        }
    }
    
    public var heightConstraint: CGFloat {
        get {
            return self.getConstraint(.height)
        }
        set {
            self.setConstraint(.height, newValue)
        }
    }
    
    public var topConstraint: CGFloat {
        get {
            return self.getConstraint(.top)
        }
        set {
            let constraint = self.getLayoutConstraint(.top)
            if constraint?.secondItem === self {
                self.setConstraint(.top, newValue * -1)
            }
            else {
                self.setConstraint(.top, newValue)
            }
        }
    }
    
    public var leadingConstraint: CGFloat {
        get {
            return self.getConstraint(.leading)
        }
        set {
            let constraint = self.getLayoutConstraint(.leading)
            if constraint?.secondItem === self {
                self.setConstraint(.leading, newValue * -1)
            }
            else {
                self.setConstraint(.leading, newValue)
            }
        }
    }
    
    public var bottomConstraint: CGFloat {
        get {
            return self.getConstraint(.bottom)
        }
        set {
            let constraint = self.getLayoutConstraint(.bottom)
            if constraint?.firstItem === self {
                self.setConstraint(.bottom, newValue * -1)
            }
            else {
                self.setConstraint(.bottom, newValue)
            }
        }
    }
    
    public var trailingConstraint: CGFloat {
        get {
            return self.getConstraint(.trailing)
        }
        set {
            let constraint = self.getLayoutConstraint(.trailing)
            if constraint?.firstItem === self {
                self.setConstraint(.trailing, newValue * -1)
            }
            else {
                self.setConstraint(.trailing, newValue)
            }
        }
    }
    
    public var centerXConstraint: CGFloat {
        get {
            return self.getConstraint(.centerX)
        }
        set {
            let constraint = self.getLayoutConstraint(.centerX)
            if constraint?.secondItem === self {
                self.setConstraint(.centerX, newValue * -1)
            }
            else {
                self.setConstraint(.centerX, newValue)
            }
        }
    }
    
    public var centerYConstraint: CGFloat {
        get {
            return self.getConstraint(.centerY)
        }
        set {
            let constraint = self.getLayoutConstraint(.centerY)
            if constraint?.secondItem === self {
                self.setConstraint(.centerY, newValue * -1)
            }
            else {
                self.setConstraint(.centerY, newValue)
            }
        }
        
    }
    
    public var widthDefaultConstraint: CGFloat {
        get {
            return self.getDefaultConstraint(.width)
        }
    }
    
    public var heightDefaultConstraint: CGFloat {
        get {
            return self.getDefaultConstraint(.height)
        }
    }
    
    public var topDefaultConstraint: CGFloat {
        get {
            return self.getDefaultConstraint(.top)
        }
    }
    
    public var leadingDefaultConstraint: CGFloat {
        get {
            return self.getDefaultConstraint(.leading)
        }
    }
    
    public var bottomDefaultConstraint: CGFloat {
        get {
            return self.getDefaultConstraint(.bottom)
        }
    }
    
    public var trailingDefaultConstraint: CGFloat {
        get {
            return self.getDefaultConstraint(.trailing)
        }
    }
    
    public var centerXDefaultConstraint: CGFloat {
        get {
            return self.getDefaultConstraint(.centerX)
        }
    }
    
    public var centerYDefaultConstraint: CGFloat {
        get {
            return self.getDefaultConstraint(.centerY)
        }
    }
    
    public func getConstraint(_ layoutAttribute: NSLayoutAttribute) -> CGFloat {
        return self.getLayoutConstraint(layoutAttribute)?.constant ?? 0
    }
    
    public func getDefaultConstraint(_ layoutAttribute: NSLayoutAttribute) -> CGFloat {
        
        self.getLayoutConstraint(layoutAttribute)
        if let layoutAttributeDefaultKey = getDefaultLayoutAttributeKey(layoutAttribute) {
            if let data = objc_getAssociatedObject(self, layoutAttributeDefaultKey) {
                return data as? CGFloat ?? 0
            }
        }
        
        fatalError("Error getDefaultConstraint")
        
    }
    
    public func setConstraint(_ layoutAttribute: NSLayoutAttribute, _ value: CGFloat) {
        self.getLayoutConstraint(layoutAttribute)?.constant = value
    }
    
    public func getConstraint(_ layoutAttribute: NSLayoutAttribute, toTaget: UIView) -> NSLayoutConstraint? {
        let constraints = self.getLayoutAllConstraints(layoutAttribute)
        let result = constraints.filter { (value) -> Bool in
            return value.firstItem === toTaget || value.secondItem === toTaget
        }
        
        return result.first
    }
    
    
    func getControllerView() -> UIView {
        guard let superview = superview , superview.constraints.count > 0 else {
            return  self
        }
        return superview.getControllerView()
        
    }
    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    @inline(__always) public func getContraints(_ view: UIView, checkSub: Bool = false) -> Set<NSLayoutConstraint> {
        var result = Set<NSLayoutConstraint>()
        
        if checkSub {
            for subView in view.subviews {
                result = result.union(self.getContraints(subView))
            }
        }
        
        result = result.union(view.constraints)
        

        return result
    }
    
    

    @inline(__always) public func getAttributeConstrains(constraints: Set<NSLayoutConstraint>, layoutAttribute: NSLayoutAttribute, toTaget: UIView? = nil) -> Array<NSLayoutConstraint> {
        var toTagetView = toTaget
        if toTagetView == nil {
            toTagetView = self.superview
        }
        var constraintsTemp = Array<NSLayoutConstraint>()
        constraintsTemp.reserveCapacity(10)
        for constraint in constraints {

            
            switch layoutAttribute {
            case .width, .height:
                if  constraint.firstItem === self && constraint.firstAttribute == layoutAttribute && constraint.secondItem == nil {
                    if self is UIButton || self is UILabel || self is UIImageView {
                        if  type(of:constraint) === NSLayoutConstraint.self {
                            constraintsTemp.append(constraint)
                        }
                    }
                    else {
                        if self is UIButton || self is UILabel || self is UIImageView {
                            if type(of:constraint) === NSLayoutConstraint.self {
                                constraintsTemp.append(constraint)
                            }
                        }
                        else {
                            constraintsTemp.append(constraint)
                        }
                    }
                    
                    
                }
                else if  constraint.firstAttribute == layoutAttribute && constraint.secondAttribute == layoutAttribute {
                    if constraint.firstItem === self || constraint.secondItem === self {
                        constraintsTemp.append(constraint)
                    }
                }
            case .centerX, .centerY:
                if constraint.firstAttribute == layoutAttribute  && constraint.secondAttribute == layoutAttribute {
                    if (constraint.firstItem === self && (constraint.secondItem === toTagetView || constraint.secondItem is UILayoutGuide)) ||
                        (constraint.secondItem === self && (constraint.firstItem === toTagetView || constraint.firstItem is UILayoutGuide)) {
                        constraintsTemp.append(constraint)
                    }
                }
            case .top :
                if  constraint.firstItem === self && constraint.firstAttribute == .top  && constraint.secondAttribute == .bottom {
                    constraintsTemp.append(constraint)
                }
                else if  constraint.secondItem === self && constraint.secondAttribute == .top  && constraint.firstAttribute == .bottom {
                    constraintsTemp.append(constraint)
                }
                else if constraint.firstAttribute == .top  && constraint.secondAttribute == .top {
                    if (constraint.firstItem === self && constraint.secondItem === toTagetView ) ||
                        (constraint.secondItem === self && constraint.firstItem === toTagetView ) {
                        constraintsTemp.append(constraint)
                    }
                    else if toTaget == nil {
                        if (constraint.firstItem === self && constraint.secondItem is UILayoutGuide) ||
                            (constraint.secondItem === self &&  constraint.firstItem is UILayoutGuide) {
                            constraintsTemp.append(constraint)
                        }
                    }
                }
            case .bottom :
                if  constraint.firstItem === self && constraint.firstAttribute == .bottom  && constraint.secondAttribute == .top {
                    constraintsTemp.append(constraint)
                }
                else if  constraint.secondItem === self && constraint.secondAttribute == .bottom  && constraint.firstAttribute == .top {
                    constraintsTemp.append(constraint)
                }
                else if constraint.firstAttribute == .bottom  && constraint.secondAttribute == .bottom {
                    if (constraint.firstItem === self && constraint.secondItem === toTagetView ) ||
                        (constraint.secondItem === self && constraint.firstItem === toTagetView ) {
                        constraintsTemp.append(constraint)
                    }
                    else if toTaget == nil {
                        if (constraint.firstItem === self && constraint.secondItem is UILayoutGuide) ||
                            (constraint.secondItem === self &&  constraint.firstItem is UILayoutGuide) {
                            constraintsTemp.append(constraint)
                        }
                    }
                }
            case .leading :
                if  constraint.firstItem === self && constraint.firstAttribute == .leading  && constraint.secondAttribute == .trailing {
                    constraintsTemp.append(constraint)
                }
                else if  constraint.secondItem === self && constraint.secondAttribute == .leading  && constraint.firstAttribute == .trailing {
                    constraintsTemp.append(constraint)
                }
                else if constraint.firstAttribute == .leading  && constraint.secondAttribute == .leading {
                    if (constraint.firstItem === self && constraint.secondItem === toTagetView ) ||
                        (constraint.secondItem === self && constraint.firstItem === toTagetView ) {
                        constraintsTemp.append(constraint)
                    }
                    else if toTaget == nil {
                        if (constraint.firstItem === self && constraint.secondItem is UILayoutGuide) ||
                            (constraint.secondItem === self &&  constraint.firstItem is UILayoutGuide) {
                            constraintsTemp.append(constraint)
                        }
                    }
                }
            case .trailing :
                if  constraint.firstItem === self && constraint.firstAttribute == .trailing  && constraint.secondAttribute == .leading {
                    constraintsTemp.append(constraint)
                }
                else if  constraint.secondItem === self && constraint.secondAttribute == .trailing  && constraint.firstAttribute == .leading {
                    constraintsTemp.append(constraint)
                }
                else if constraint.firstAttribute == .trailing  && constraint.secondAttribute == .trailing {
                    if (constraint.firstItem === self && constraint.secondItem === toTagetView ) ||
                        (constraint.secondItem === self && constraint.firstItem === toTagetView ) {
                        constraintsTemp.append(constraint)
                    }
                    else if toTaget == nil {
                        if (constraint.firstItem === self && constraint.secondItem is UILayoutGuide) ||
                            (constraint.secondItem === self &&  constraint.firstItem is UILayoutGuide) {
                            constraintsTemp.append(constraint)
                        }
                    }
                }
                
                
                
            default :
                fatalError("not supput \(layoutAttribute)")
            }
        }
        

        return constraintsTemp
    }
    
    public func getLayoutAllConstraints(_ layoutAttribute: NSLayoutAttribute) -> [NSLayoutConstraint] {
        var constraintsTemp = Array<NSLayoutConstraint>()
        var constraints : Set<NSLayoutConstraint> = self.getContraints(self)
        constraintsTemp += self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
        
        if constraintsTemp.count == 0 {
            if let view = superview {
                constraints = self.getContraints(view)
                constraintsTemp += self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
            }
        }
        
        if constraintsTemp.count == 0 {
            constraints = self.getContraints(self.getControllerView(), checkSub: true)
            constraintsTemp += self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
        }
        
        return constraintsTemp
    }
    
    @discardableResult
    public func getLayoutConstraint(_ layoutAttribute: NSLayoutAttribute, errorCheck: Bool = true) -> NSLayoutConstraint? {
        let layoutAttributekey = getLayoutAttributeKey(layoutAttribute)
        if let layoutAttributekey = layoutAttributekey, let data = objc_getAssociatedObject(self, layoutAttributekey) {
            return data as? NSLayoutConstraint
        }
        
        let constraintsTemp = getLayoutAllConstraints(layoutAttribute)
        
        if constraintsTemp.count == 0 {
            if errorCheck {
                fatalError("\n\nAutoLayout Not Make layoutAttribute : \(layoutAttributeString(layoutAttribute)) \nView: \(self)\n\n")
            }
            return nil
        }
        
        let constraintsSort: Array = constraintsTemp.sorted(by: { (obj1, obj2) -> Bool in
            return obj1.priority.rawValue > obj1.priority.rawValue
        })
        
        let result : NSLayoutConstraint? = constraintsSort.first
        if result != nil, let layoutAttributekey = layoutAttributekey  {
            objc_setAssociatedObject ( self, layoutAttributekey, result, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if let layoutAttributeDefaultKey = getDefaultLayoutAttributeKey(layoutAttribute) {
                if objc_getAssociatedObject(self, layoutAttributeDefaultKey) == nil {
                    objc_setAssociatedObject ( self, layoutAttributeDefaultKey, result?.constant, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
        }
        
        return result!
    }
    
    public func layoutAttributeString(_ layoutAttribute: NSLayoutAttribute) -> String {
        switch layoutAttribute {
        case .left:
            return "left"
        case .right:
            return "right"
        case .top:
            return "top"
        case .bottom:
            return "bottom"
        case .leading:
            return "leading"
        case .trailing:
            return "trailing"
        case .width:
            return "width"
        case .height:
            return "height"
        case .centerX:
            return "centerX"
        case .centerY:
            return "centerY"
        case .lastBaseline:
            return "lastBaseline"
        case .firstBaseline:
            return "firstBaseline"
        case .leftMargin:
            return "leftMargin"
        case .rightMargin:
            return "rightMargin"
        case .topMargin:
            return "topMargin"
        case .bottomMargin:
            return "bottomMargin"
        case .leadingMargin:
            return "leadingMargin"
        case .trailingMargin:
            return "trailingMargin"
        case .centerXWithinMargins:
            return "centerXWithinMargins"
        case .centerYWithinMargins:
            return "centerYWithinMargins"
        case .notAnAttribute:
            return "notAnAttribute"
        }

    }
    
    public func copyView() -> AnyObject
    {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self))! as AnyObject
    }
    
    public func addSubViewAutoLayout(_ subview: UIView) {
        self.addSubViewAutoLayout(subview, edgeInsets: UIEdgeInsets.zero)
    }
    
    public func addSubViewAutoLayout(_ subview: UIView, edgeInsets: UIEdgeInsets) {
        self.addSubview(subview)
        self.setSubViewAutoLayout(subview, edgeInsets: edgeInsets)
    }
    
    public func addSubViewAutoLayout(insertView: UIView, subview: UIView, edgeInsets: UIEdgeInsets, isFront: Bool) {
        if (isFront) {
            self.insertSubview(insertView, belowSubview:subview);
        }
        else {
            self.insertSubview(insertView, aboveSubview:subview);
        }
        self.setSubViewAutoLayout(insertView, edgeInsets: edgeInsets)
    }
    
    public func setSubViewAutoLayout(_ subview: UIView, edgeInsets: UIEdgeInsets) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let views: Dictionary = ["subview": subview]
        let edgeInsetsDic: Dictionary = ["top" : (edgeInsets.top), "left" : (edgeInsets.left), "bottom" : (edgeInsets.bottom), "right" : (edgeInsets.right)]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|-(left)-[subview]-(right)-|",
                                                      options:NSLayoutFormatOptions(rawValue: 0),
                                                      metrics:edgeInsetsDic,
                                                      views:views))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|-(top)-[subview]-(bottom)-|",
                                                      options:NSLayoutFormatOptions(rawValue: 0),
                                                      metrics:edgeInsetsDic,
                                                      views:views))
    }
    
    public func addSubViewAutoLayout(subviews: Array<UIView>, addType: VIEW_ADD_TYPE, edgeInsets: UIEdgeInsets) {
        var constraints = String()
        var views = Dictionary<String,UIView>()
        var metrics: Dictionary = ["top" : (edgeInsets.top), "left" : (edgeInsets.left), "bottom" : (edgeInsets.bottom), "right" : (edgeInsets.right)];
        
        for (idx, obj) in subviews.enumerated() {
            obj.translatesAutoresizingMaskIntoConstraints = false;
            self.addSubview(obj)
            views["view\(idx)"] = obj
            
            
            if addType == .horizontal {
                self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|-(top)-[view\(idx)]-(bottom)-|",
                                                              options:NSLayoutFormatOptions(rawValue: 0),
                                                              metrics:["top" : (edgeInsets.top), "bottom" : (edgeInsets.bottom)],
                                                              views:views))
                
                metrics["width\(idx)"] = (obj.w)
                
                if subviews.count == 1 {
                    constraints += "H:|-(left)-[view\(idx)(width\(idx))]-(right)-|"
                    
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:constraints,
                                                                  options:NSLayoutFormatOptions(rawValue: 0),
                                                                  metrics:metrics,
                                                                  views:views))
                    
                }
                else {
                    if idx == 0 {
                        constraints += "H:|-(left)-[view\(idx)(width\(idx))]"
                    }
                    else if idx == subviews.count - 1 {
                        constraints += "[view\(idx)(width\(idx))]-(right)-|"
                    
                        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:constraints,
                                                                      options:NSLayoutFormatOptions(rawValue: 0),
                                                                      metrics:metrics,
                                                                      views:views))
                    }
                    else {
                        constraints += "[view\(idx)(width\(idx))]"
                    }
                }
                
                
            }
            else {
                self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|-(left)-[view\(idx)]-(right)-|",
                                                              options:NSLayoutFormatOptions(rawValue: 0),
                                                              metrics:["left" : (edgeInsets.left), "right" : (edgeInsets.right)],
                                                              views:views))
                
                metrics["height\(idx)"] = (obj.h)
                
                if subviews.count == 1 {
                    constraints += "V:|-(top)-[view\(idx)(height\(idx))]-(bottom)-|"
                    
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:constraints,
                                                                  options:NSLayoutFormatOptions(rawValue: 0),
                                                                  metrics:metrics,
                                                                  views:views))
                }
                else {
                    if idx == 0 {
                        constraints += "V:|-(top)-[view\(idx)(height\(idx))]"
                        
                    }
                    else if idx == subviews.count - 1 {
                        constraints += "[view\(idx)(height\(idx))]-(bottom)-|"
                        
                        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:constraints,
                                                                      options:NSLayoutFormatOptions(rawValue: 0),
                                                                      metrics:metrics,
                                                                      views:views))
                    }
                    else {
                        constraints += "[view\(idx)(height\(idx))]"
                    }
                }
                
            }

        }

    }
    
    public func removeSuperViewAllConstraints() {
        guard let superview: UIView = self.superview else { return}
        
        for c: NSLayoutConstraint in superview.constraints {
            if c.firstItem === self || c.secondItem === self {
                superview.removeConstraint(c)
            }
        }
    }
    
    public func removeAllConstraints() {
        self.removeSuperViewAllConstraints()
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    public var viewDidDisappear: VoidClosure? {
        get {
            return objc_getAssociatedObject(self, &viewDidDisappear_key) as? VoidClosure
        }
        set {
            objc_setAssociatedObject ( self, &viewDidDisappear_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            viewDidDisappearTimer?.invalidate()
            if newValue != nil {
                viewDidDisappearTimer = Timer.schedule(repeatInterval: 0.2) { [weak self] (timer) in
                    guard let `self` = self else { return }
                    let check = self.isVisible
                    if check == false {
                        self.viewDidDisappearTimer?.invalidate()
                        self.viewDidDisappearTimer = nil
                        self.viewDidDisappear?()
                    }
                }
                
            }
            else {
                viewDidDisappearTimer = nil
            }
        }
    }
    
    private var viewDidDisappearTimer: Timer? {
        get {
            return objc_getAssociatedObject(self, &viewDidDisappearTimer_key) as? Timer
        }
        set {
            objc_setAssociatedObject ( self, &viewDidDisappearTimer_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var isVisible: Bool {
        
        if self.window == nil {
            return false
        }
        
        var currentView: UIView = self
        while let superview = currentView.superview {
            
            if (superview.bounds).intersects(currentView.frame) == false {
                return false;
            }
            
            if currentView.isHidden {
                return false
            }
            
            currentView = superview
        }
        
        return true
    }
    
    public var isGone: Bool {
        get {
            return isGoneWidth || isGoneHeight
        }
        set {
            isHidden = newValue
            isGoneWidth = newValue
            isGoneHeight = newValue
        }
    }
    
    public var isGoneWidth: Bool {
        get {
            if let isGone = objc_getAssociatedObject(self, NSLayoutAttributeWidthIsGone_key) as? Bool {
                return isGone
            }
            return false
        }
        set {
            if newValue {
                isHidden = true
                goneWidth(space: true)
            }
            else {
                goneRelease(key: NSLayoutAttributeWidthGone_key)
            }
        }
    }
    
    public var isGoneHeight: Bool {
        get {
            if let isGone = objc_getAssociatedObject(self, NSLayoutAttributeHeightIsGone_key) as? Bool {
                return isGone
            }
            return false
        }
        set {
            if newValue {
                goneHeight(space: true)
            }
            else {
                goneRelease(key: NSLayoutAttributeHeightGone_key)
            }
        }
    }
    
    public func gone(space: Bool) {
        goneWidth(space: space)
        goneHeight(space: space)
    }
    
    public func goneRelease() {
        goneRelease(key: NSLayoutAttributeWidthGone_key)
        goneRelease(key: NSLayoutAttributeHeightGone_key)
    }
    
    public func goneHeight(space: Bool = true) {
        if let isGone = objc_getAssociatedObject(self, NSLayoutAttributeHeightIsGone_key) as? Bool, isGone == true {
            return
        }
        isHidden = true
        var dic = [NSLayoutConstraint:CGFloat]()
        if let constraint = self.getLayoutConstraint(.height, errorCheck: false) {
            dic.updateValue(constraint.constant, forKey: constraint)
            constraint.constant = 0
        }
        else {
            let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
            addConstraint(constraint)
            dic.updateValue(constraint.constant, forKey: constraint)
            objc_setAssociatedObject ( self, NSLayoutAttributeHeightEmpty_key, true, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        if space {
            if let constraint = self.getLayoutConstraint(.top, errorCheck: false) {
                dic.updateValue(constraint.constant, forKey: constraint)
                constraint.constant = 0
            }
            if let constraint = self.getLayoutConstraint(.bottom, errorCheck: false) {
                dic.updateValue(constraint.constant, forKey: constraint)
                constraint.constant = 0
            }
        }
        
        objc_setAssociatedObject ( self, NSLayoutAttributeHeightGone_key, dic, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject ( self, NSLayoutAttributeHeightIsGone_key, true, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public func goneWidth(space: Bool = true) {
        if let isGone = objc_getAssociatedObject(self, NSLayoutAttributeWidthIsGone_key) as? Bool, isGone == true {
            return
        }
        isHidden = true
        var dic = [NSLayoutConstraint:CGFloat]()
        if let constraint = self.getLayoutConstraint(.width, errorCheck: false) {
            dic.updateValue(constraint.constant, forKey: constraint)
            constraint.constant = 0
        }
        else {
            let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 0)
            addConstraint(constraint)
            dic.updateValue(constraint.constant, forKey: constraint)
            objc_setAssociatedObject ( self, NSLayoutAttributeWidthEmpty_key, true, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        if space {
            if let constraint = self.getLayoutConstraint(.leading, errorCheck: false) {
                dic.updateValue(constraint.constant, forKey: constraint)
                constraint.constant = 0
            }
            if let constraint = self.getLayoutConstraint(.trailing, errorCheck: false) {
                dic.updateValue(constraint.constant, forKey: constraint)
                constraint.constant = 0
            }
        }
        
        objc_setAssociatedObject ( self, NSLayoutAttributeWidthGone_key, dic, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject ( self, NSLayoutAttributeWidthIsGone_key, true, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    private func goneRelease(key: UnsafeMutableRawPointer) {
        isHidden = false
        if let dic = objc_getAssociatedObject(self, key) as? [NSLayoutConstraint:CGFloat] {
            for (constraint, value) in dic {
                if constraint.firstAttribute == .width {
                    if let empty = objc_getAssociatedObject(self, NSLayoutAttributeWidthEmpty_key) as? Bool , empty == true {
                        removeConstraint(constraint)
                        objc_setAssociatedObject ( self, NSLayoutAttributeWidthEmpty_key, false, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                    }
                }
                else if constraint.firstAttribute == .height {
                    if let empty = objc_getAssociatedObject(self, NSLayoutAttributeHeightEmpty_key) as? Bool , empty == true {
                        removeConstraint(constraint)
                        objc_setAssociatedObject ( self, NSLayoutAttributeHeightEmpty_key, false, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                    }
                }
                constraint.constant = value
            }
        }
        if key == NSLayoutAttributeWidthGone_key {
            objc_setAssociatedObject ( self, NSLayoutAttributeWidthIsGone_key, false, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        else if key == NSLayoutAttributeHeightGone_key {
            objc_setAssociatedObject ( self, NSLayoutAttributeHeightIsGone_key, false, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        
    }
}
    
// MARK: Custom UIView Initilizers
extension UIView {
    ///   convenience contructor to define a view based on width, height and base coordinates.
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }

    ///   puts padding around the view
    public convenience init(superView: UIView, padding: CGFloat) {
        self.init(frame: CGRect(x: superView.x + padding, y: superView.y + padding, width: superView.w - padding*2, height: superView.h - padding*2))
    }

    /// EZSwiftExtensions - Copies size of superview
    public convenience init(superView: UIView) {
        self.init(frame: CGRect(origin: CGPoint.zero, size: superView.size))
    }
}

// MARK: Frame Extensions
extension UIView {

    ///   add multiple subviews
    public func addSubviews(_ views: [UIView]) {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
    }

    //TODO: Add pics to readme
    ///   resizes this view so it fits the largest subview
    public func resizeToFitSubviews() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            let newWidth = aView.x + aView.w
            let newHeight = aView.y + aView.h
            width = max(width, newWidth)
            height = max(height, newHeight)
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }

    ///   resizes this view so it fits the largest subview
    public func resizeToFitSubviews(_ tagsToIgnore: [Int]) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            if !tagsToIgnore.contains(someView.tag) {
                let newWidth = aView.x + aView.w
                let newHeight = aView.y + aView.h
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }

    public var hidden: Bool {
        get {
            return isHidden
        }
        set {
            self.isHidden = newValue
        }
    }
    ///   resizes this view so as to fit its width.
    public func resizeToFitWidth() {
        let currentHeight = self.h
        self.sizeToFit()
        self.h = currentHeight
    }

    ///   resizes this view so as to fit its height.
    public func resizeToFitHeight() {
        let currentWidth = self.w
        self.sizeToFit()
        self.w = currentWidth
    }
    
    ///   resizes this view so as to fit its height.
    public func resizeToFitHeight(_ height: CGFloat) {
        var rt: CGRect = frame
        rt.size.height = height
        frame = rt
    }

    ///   getter and setter for the x coordinate of the frame's origin for the view.
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
        }
    }
    
    public var minX: CGFloat {
        get {
            return self.frame.minX
        }
    }
    
    public var midX: CGFloat {
        get {
            return self.frame.midX
        }
    }
    
    public var maxX: CGFloat {
        get {
            return self.frame.maxX
        }
        set {
            self.frame.origin.x = newValue - self.w
        }
    }
    ///   getter and setter for the y coordinate of the frame's origin for the view.
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
        }
    }
    
    public var minY: CGFloat {
        get {
            return self.frame.minY
        }
    }
    
    public var midY: CGFloat {
        get {
            return self.frame.midY
        }
    }
    
    public var maxY: CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            self.frame.origin.y = newValue - self.h
        }
    }

    ///   variable to get the width of the view.
    public var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }

    ///   variable to get the height of the view.
    public var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }

    public var width: CGFloat {
        get {
            return self.w
        }
        set {
            self.w = newValue
        }
    }
    
    public var height: CGFloat {
        get {
            return self.h
        }
        set {
            self.h = newValue
        }
    }
    
    ///   getter and setter for the x coordinate of leftmost edge of the view.
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }

    ///   getter and setter for the x coordinate of the rightmost edge of the view.
    public var right: CGFloat {
        get {
            return self.x + self.w
        } set(value) {
            self.x = value - self.w
        }
    }

    ///   getter and setter for the y coordinate for the topmost edge of the view.
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }

    ///   getter and setter for the y coordinate of the bottom most edge of the view.
    public var bottom: CGFloat {
        get {
            return self.y + self.h
        } set(value) {
            self.y = value - self.h
        }
    }

    ///   getter and setter the frame's origin point of the view.
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }

    ///   getter and setter for the X coordinate of the center of a view.
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }

    ///   getter and setter for the Y coordinate for the center of a view.
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }

    ///   getter and setter for frame size for the view.
    public var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }

    ///   getter for an leftwards offset position from the leftmost edge.
    public func leftOffset(_ offset: CGFloat) -> CGFloat {
        return self.left - offset
    }

    ///   getter for an rightwards offset position from the rightmost edge.
    public func rightOffset(_ offset: CGFloat) -> CGFloat {
        return self.right + offset
    }

    ///   aligns the view to the top by a given offset.
    public func topOffset(_ offset: CGFloat) -> CGFloat {
        return self.top - offset
    }

    ///   align the view to the bottom by a given offset.
    public func bottomOffset(_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }

    //TODO: Add to readme
    ///   align the view widthwise to the right by a given offset.
    public func alignRight(_ offset: CGFloat) -> CGFloat {
        return self.w - offset
    }

    /// EZSwiftExtensions
    public func reorderSubViews(_ reorder: Bool = false, tagsToIgnore: [Int] = []) -> CGFloat {
        var currentHeight: CGFloat = 0
        for someView in subviews {
            if !tagsToIgnore.contains(someView.tag) && !(someView ).isHidden {
                if reorder {
                    let aView = someView
                    aView.frame = CGRect(x: aView.frame.origin.x, y: currentHeight, width: aView.frame.width, height: aView.frame.height)
                }
                currentHeight += someView.frame.height
            }
        }
        return currentHeight
    }

    public func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    public func viewWithTagName(_ name: String) -> UIView? {
        var sv = self.superview
        while true {
            guard sv?.superview != nil else { break }
            sv = sv?.superview
        }
        if sv == nil {
            sv = self
        }
        let viewList = subViewList(sv!)
        return viewList.filter({ (view) -> Bool in
            return view.tag_name == name
        }).first
        
    }
    
    public func subViewList(_ view: UIView) -> [UIView] {
        var result = [UIView]()
        for sv in view.subviews {
            if sv.subviews.count > 0 {
                result += subViewList(sv)
            }
            result.append(sv)
        }
        
        return result
    }

    ///   Centers view in superview horizontally
    public func centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(String(describing: type(of: self.parentViewController))) doesn't have a superview")
            return
        }

        self.x = parentView.w/2 - self.w/2
    }

    ///   Centers view in superview vertically
    public func centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(String(describing: type(of: self.parentViewController))) doesn't have a superview")
            return
        }

        self.y = parentView.h/2 - self.h/2
    }

    ///   Centers view in superview horizontally & vertically
    public func centerInSuperView() {
        self.centerXInSuperView()
        self.centerYInSuperView()
    }

}

// MARK: Transform Extensions
extension UIView {
    /// EZSwiftExtensions
    public func setRotationX(_ x: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        self.layer.transform = transform
    }

    /// EZSwiftExtensions
    public func setRotationY(_ y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        self.layer.transform = transform
    }

    /// EZSwiftExtensions
    public func setRotationZ(_ z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }

    /// EZSwiftExtensions
    public func setRotation(x: CGFloat, y: CGFloat, z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }

    /// EZSwiftExtensions
    public func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
}

// MARK: Layer Extensions
extension UIView {
    
    @IBInspectable var tagName: String? {
        get {
            return self.tag_name
        }
        set {
            self.tag_name = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue;
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue;
            self.layer.masksToBounds = true
        }
    }
    /// EZSwiftExtensions
    public func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    //TODO: add this to readme
    /// EZSwiftExtensions
    public func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }

    /// EZSwiftExtensions
    public func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }

    /// EZSwiftExtensions
    public func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }

    //TODO: add to readme
    /// EZSwiftExtensions
    public func addBorderTopWithPadding(size: CGFloat, color: UIColor, padding: CGFloat) {
        addBorderUtility(x: padding, y: 0, width: frame.width - padding*2, height: size, color: color)
    }

    /// EZSwiftExtensions
    public func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }

    /// EZSwiftExtensions
    public func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }

    /// EZSwiftExtensions
    public func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }

    /// EZSwiftExtensions
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    //TODO: add this to readme
    /// EZSwiftExtensions
    public func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    //TODO: add this to readme
    /// EZSwiftExtensions
    public func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
}

private let UIViewAnimationDuration: TimeInterval = 1
private let UIViewAnimationSpringDamping: CGFloat = 0.5
private let UIViewAnimationSpringVelocity: CGFloat = 0.5

//TODO: add this to readme
// MARK: Animation Extensions
extension UIView {
    /// EZSwiftExtensions
    public func spring(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        spring(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }

    /// EZSwiftExtensions
    public func spring(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: UIViewAnimationDuration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: animations,
            completion: completion
        )
    }

    /// EZSwiftExtensions
    public func animate(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }

    /// EZSwiftExtensions
    public func animate(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        animate(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }

    /// EZSwiftExtensions
    public func pop() {
        setScale(x: 1.1, y: 1.1)
        spring(duration: 0.2, animations: { [weak self] () -> Void in
            guard let `self` = self else { return }
            self.setScale(x: 1, y: 1)
            })
    }

    /// EZSwiftExtensions
    public func popBig() {
        setScale(x: 1.25, y: 1.25)
        spring(duration: 0.2, animations: { [weak self] () -> Void in
            guard let `self` = self else { return }
            self.setScale(x: 1, y: 1)
            })
    }

}

//TODO: add this to readme
// MARK: Render Extensions
extension UIView {
    /// EZSwiftExtensions
    public func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

// MARK: Gesture Extensions
extension UIView {
    /// http://stackoverflow.com/questions/4660371/how-to-add-a-touch-event-to-a-uiview/32182866#32182866
    @discardableResult
    public func addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        
        return tap
    }

    @discardableResult
    public func addSwipeGesture(direction: UISwipeGestureRecognizerDirection, numberOfTouches: Int = 1, target: AnyObject, action: Selector) -> UISwipeGestureRecognizer {
        let swipe = UISwipeGestureRecognizer(target: target, action: action)
        swipe.direction = direction

        #if os(iOS)

        swipe.numberOfTouchesRequired = numberOfTouches

        #endif

        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
        
        return swipe
    }


    @discardableResult
    public func addPanGesture(target: AnyObject, action: Selector) -> UIPanGestureRecognizer {
        let pan = UIPanGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
        
        return pan
    }
    #if os(iOS)

    @discardableResult
    public func addPinchGesture(target: AnyObject, action: Selector) -> UIPinchGestureRecognizer {
        let pinch = UIPinchGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pinch)
        isUserInteractionEnabled = true
        
        return pinch
    }

    #endif

    @discardableResult
    public func addLongPressGesture(target: AnyObject, action: Selector) -> UILongPressGestureRecognizer {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
        
        return longPress
    }
}

//TODO: add to readme
extension UIView {
    /// EZSwiftExtensions [UIRectCorner.TopLeft, UIRectCorner.TopRight]
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    /// EZSwiftExtensions - Mask square/rectangle UIView with a circular/capsule cover, with a border of desired color and width around it
    public func roundView(withBorderColor color: UIColor? = nil, withBorderWidth width: CGFloat? = nil) {
        self.setCornerRadius(radius: min(self.frame.size.height, self.frame.size.width) / 2)
        self.layer.borderWidth = width ?? 0
        self.layer.borderColor = color?.cgColor ?? UIColor.clear.cgColor
    }
    
    /// EZSwiftExtensions - Remove all masking around UIView
    public func nakedView() {
        self.layer.mask = nil
        self.layer.borderWidth = 0
    }
}

extension UIView {
    ///  Shakes the view for as many number of times as given in the argument.
    public func shakeViewForTimes(_ times: Int) {
        let anim = CAKeyframeAnimation(keyPath: "transform")
        anim.values = [
            NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0 )),
            NSValue(caTransform3D: CATransform3DMakeTranslation( 5, 0, 0 ))
        ]
        anim.autoreverses = true
        anim.repeatCount = Float(times)
        anim.duration = 7/100

        self.layer.add(anim, forKey: nil)
    }
}

    
extension UIView {
    
    public func allButtonSelect(_ select: Bool) {
        for view: UIView in self.subviews {
            if let button = view as? UIButton {
                button.isSelected = select
            }
            else {
                view.allButtonSelect(select)
            }
        }
    }
    
    public func allButtonEnalbe(_ enable: Bool) {
        for view: UIView in self.subviews {
            if let button = view as? UIButton {
                button.isEnabled = enable
            }
            else {
                view.allButtonEnalbe(enable)
            }
        }
    }
    
    public func disableScrollsToTopPropertyOnAllSubviewsOf() {
        for view in self.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.scrollsToTop = false
            }
            else {
                view.disableScrollsToTopPropertyOnAllSubviewsOf()
            }
        }
    }
    
    public class func fromNib(cache: Bool = false) -> Self {
        return fromNib(cache: cache, as: self)
        
    }
    
    private class func fromNib<T>(cache: Bool = false, as type: T.Type) -> T {
        
        if let view = ViewNibs[self.className] {
            return view as! T
        }
        let view: UIView = Bundle.main.loadNibNamed(self.className, owner: nil, options: nil)!.first as! UIView
        return view as! T
    }
    
    public class func fromNibSize() -> CGSize {
        
        if let size = ViewNibSizes[self.className] {
            return size
        }
        else {
            let view: UIView = Bundle.main.loadNibNamed(self.className, owner: nil, options: nil)!.first as! UIView
            ViewNibSizes[self.className] = view.frame.size
            return view.frame.size
        }
    }
    
}
extension UIView {
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }else {
            return self.leftAnchor
        }
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }else {
            return self.rightAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
}

#endif

extension Timer {
    ///   Runs every x seconds, to cancel use: timer.invalidate()
    public class func schedule(repeatInterval: TimeInterval, _ handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = CFAbsoluteTimeGetCurrent() + repeatInterval
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, repeatInterval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
    ///   Run function after x seconds
    public class func schedule(delay: TimeInterval, _ handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
}

extension CGFloat {
    public func degreesToRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }
}


private var Object_class_Name_Key : UInt8 = 0
private var Object_iVar_Name_Key : UInt8 = 0
private var Object_iVar_Value_Key : UInt8 = 0


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
