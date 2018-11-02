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

private var viewDidAppear_key: UInt8 = 0
private var viewDidAppearTimer_key: UInt8 = 0


private var NSLayoutAttributeWidthEmpty     : UInt8 = 0
private var NSLayoutAttributeHeightEmpty    : UInt8 = 0
private var NSLayoutAttributeWidthEmpty_key  = UnsafeMutableRawPointer(&NSLayoutAttributeWidthEmpty)
private var NSLayoutAttributeHeightEmpty_key = UnsafeMutableRawPointer(&NSLayoutAttributeHeightEmpty)

private var NSLayoutAttributeWidthIsGone    : UInt8 = 0
private var NSLayoutAttributeHeightIsGone   : UInt8 = 0
private var NSLayoutAttributeWidthGone      : UInt8 = 0
private var NSLayoutAttributeHeightGone     : UInt8 = 0
private var NSLayoutAttributeWidthIsGone_key  = UnsafeMutableRawPointer(&NSLayoutAttributeWidthIsGone)
private var NSLayoutAttributeHeightIsGone_key = UnsafeMutableRawPointer(&NSLayoutAttributeHeightIsGone)
private var NSLayoutAttributeWidthGone_key    = UnsafeMutableRawPointer(&NSLayoutAttributeWidthGone)
private var NSLayoutAttributeHeightGone_key   = UnsafeMutableRawPointer(&NSLayoutAttributeHeightGone)


private var NSLayoutAttributeTop        : UInt8 = 0
private var NSLayoutAttributeBottom     : UInt8 = 0
private var NSLayoutAttributeLeading    : UInt8 = 0
private var NSLayoutAttributeTrailing   : UInt8 = 0
private var NSLayoutAttributeWidth      : UInt8 = 0
private var NSLayoutAttributeHeight     : UInt8 = 0
private var NSLayoutAttributeCenterX    : UInt8 = 0
private var NSLayoutAttributeCenterY    : UInt8 = 0

private var NSLayoutAttributeTop_key      = UnsafeMutableRawPointer(&NSLayoutAttributeTop)
private var NSLayoutAttributeBottom_key   = UnsafeMutableRawPointer(&NSLayoutAttributeBottom)
private var NSLayoutAttributeLeading_key  = UnsafeMutableRawPointer(&NSLayoutAttributeLeading)
private var NSLayoutAttributeTrailing_key = UnsafeMutableRawPointer(&NSLayoutAttributeTrailing)
private var NSLayoutAttributeWidth_key    = UnsafeMutableRawPointer(&NSLayoutAttributeWidth)
private var NSLayoutAttributeHeight_key   = UnsafeMutableRawPointer(&NSLayoutAttributeHeight)
private var NSLayoutAttributeCenterX_key  = UnsafeMutableRawPointer(&NSLayoutAttributeCenterX)
private var NSLayoutAttributeCenterY_key  = UnsafeMutableRawPointer(&NSLayoutAttributeCenterY)

private var NSLayoutAttributeDefaultTop     : UInt8 = 0
private var NSLayoutAttributeDefaultBottom  : UInt8 = 0
private var NSLayoutAttributeDefaultLeading : UInt8 = 0
private var NSLayoutAttributeDefaultTrailing: UInt8 = 0
private var NSLayoutAttributeDefaultWidth   : UInt8 = 0
private var NSLayoutAttributeDefaultHeight  : UInt8 = 0
private var NSLayoutAttributeDefaultCenterX : UInt8 = 0
private var NSLayoutAttributeDefaultCenterY : UInt8 = 0

private var NSLayoutAttributeDefaultTop_key      = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultTop)
private var NSLayoutAttributeDefaultBottom_key   = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultBottom)
private var NSLayoutAttributeDefaultLeading_key  = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultLeading)
private var NSLayoutAttributeDefaultTrailing_key = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultTrailing)
private var NSLayoutAttributeDefaultWidth_key    = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultWidth)
private var NSLayoutAttributeDefaultHeight_key   = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultHeight)
private var NSLayoutAttributeDefaultCenterX_key  = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultCenterX)
private var NSLayoutAttributeDefaultCenterY_key  = UnsafeMutableRawPointer(&NSLayoutAttributeDefaultCenterY)

extension NSLayoutConstraint.Attribute {
    var string: String {
        switch self {
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
    
    var AssociatedObjectKey: UnsafeMutableRawPointer? {
        switch self {
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
    
    var defaultAssociatedObjectKey: UnsafeMutableRawPointer? {
        switch self {
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
        if let layoutAttributeDefaultKey = layoutAttribute.defaultAssociatedObjectKey {
            if let data = objc_getAssociatedObject(self, layoutAttributeDefaultKey) {
                return data as? CGFloat ?? 0
            }
        }
        
        fatalError("Error getDefaultConstraint")
        
    }
    
    public func setConstraint(_ layoutAttribute: NSLayoutAttribute, _ value: CGFloat) {
        self.getLayoutConstraint(layoutAttribute)?.constant = value
        setNeedsLayout()
    }
    
    public func getConstraint(_ layoutAttribute: NSLayoutConstraint.Attribute, toTaget: UIView) -> NSLayoutConstraint {
        let constraints = self.getContraints(self.getControllerView(), checkSub: true)
        var constraintsTemp = self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
        constraintsTemp = constraintsTemp.filter { (value) -> Bool in
            return value.firstItem === toTaget || value.secondItem === toTaget
        }
        assert(constraintsTemp.first != nil, "not find TagetView")
        return constraintsTemp.first!
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
        result.reserveCapacity(100)
        if checkSub {
            for subView in view.subviews {
                result = result.union(self.getContraints(subView, checkSub: checkSub))
            }
        }
        
        result = result.union(view.constraints)
        

        return result
    }
    
    

    @inline(__always) public func getAttributeConstrains(constraints: Set<NSLayoutConstraint>, layoutAttribute: NSLayoutConstraint.Attribute) -> Array<NSLayoutConstraint> {
        var constraintsTemp = Array<NSLayoutConstraint>()
        constraintsTemp.reserveCapacity(100)
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
                    if (constraint.firstItem === self && (constraint.secondItem === self.superview || constraint.secondItem is UILayoutGuide)) ||
                        (constraint.secondItem === self && (constraint.firstItem === self.superview || constraint.firstItem is UILayoutGuide)) {
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
                    if (constraint.firstItem === self && constraint.secondItem === self.superview ) ||
                        (constraint.secondItem === self && constraint.firstItem === self.superview ) {
                        constraintsTemp.append(constraint)
                    }
                    else {
                        if (constraint.firstItem === self && constraint.secondItem is UILayoutGuide) ||
                            (constraint.secondItem === self &&  constraint.firstItem is UILayoutGuide) {
                            constraintsTemp.append(constraint)
                        }
                        else if constraint.firstItem === self || constraint.secondItem === self {
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
                    if (constraint.firstItem === self && constraint.secondItem === self.superview ) ||
                        (constraint.secondItem === self && constraint.firstItem === self.superview ) {
                        constraintsTemp.append(constraint)
                    }
                    else  {
                        if (constraint.firstItem === self && constraint.secondItem is UILayoutGuide) ||
                            (constraint.secondItem === self &&  constraint.firstItem is UILayoutGuide) {
                            constraintsTemp.append(constraint)
                        }
                        else if constraint.firstItem === self || constraint.secondItem === self {
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
                    if (constraint.firstItem === self && constraint.secondItem === self.superview ) ||
                        (constraint.secondItem === self && constraint.firstItem === self.superview ) {
                        constraintsTemp.append(constraint)
                    }
                    else  {
                        if (constraint.firstItem === self && constraint.secondItem is UILayoutGuide) ||
                            (constraint.secondItem === self &&  constraint.firstItem is UILayoutGuide) {
                            constraintsTemp.append(constraint)
                        }
                        else if constraint.firstItem === self || constraint.secondItem === self {
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
                    if (constraint.firstItem === self && constraint.secondItem === self.superview ) ||
                        (constraint.secondItem === self && constraint.firstItem === self.superview ) {
                        constraintsTemp.append(constraint)
                    }
                    else {
                        if (constraint.firstItem === self && constraint.secondItem is UILayoutGuide) ||
                            (constraint.secondItem === self &&  constraint.firstItem is UILayoutGuide) {
                            constraintsTemp.append(constraint)
                        }
                        else if constraint.firstItem === self || constraint.secondItem === self {
                            constraintsTemp.append(constraint)
                        }
                    }
                }
                
                
                
            default :
                assertionFailure("not supput \(layoutAttribute)")
            }
        }
        

        return constraintsTemp
    }
    
    public func getLayoutAllConstraints(_ layoutAttribute: NSLayoutAttribute) -> [NSLayoutConstraint] {
        var constraintsTemp = Array<NSLayoutConstraint>()
        constraintsTemp.reserveCapacity(100)
        var constraints = Set<NSLayoutConstraint>()
        constraints.reserveCapacity(100)
        
        if let view = superview {
            constraints = self.getContraints(view)
            constraintsTemp += self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
        }
        
        if constraintsTemp.count == 0 {
            constraints = self.getContraints(self)
            constraintsTemp += self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
        }
        
        if constraintsTemp.count == 0 {
            constraints = self.getContraints(self.getControllerView(), checkSub: true)
            constraintsTemp += self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
        }
        
        return constraintsTemp
    }
    
    @discardableResult
    public func getLayoutConstraint(_ layoutAttribute: NSLayoutAttribute, errorCheck: Bool = true) -> NSLayoutConstraint? {
        let layoutAttributekey = layoutAttribute.AssociatedObjectKey
        if let layoutAttributekey = layoutAttributekey, let data = objc_getAssociatedObject(self, layoutAttributekey) {
            return data as? NSLayoutConstraint
        }
        
        let constraintsTemp = getLayoutAllConstraints(layoutAttribute)
        
        if constraintsTemp.count == 0 {
            if errorCheck {
                fatalError("\n\nAutoLayout Not Make layoutAttribute : \(layoutAttribute.string)) \nView: \(self)\n\n")
            }
            return nil
        }
        
        let constraintsSort: Array = constraintsTemp.sorted(by: { (obj1, obj2) -> Bool in
            return obj1.priority.rawValue > obj2.priority.rawValue
        })
        
        let result : NSLayoutConstraint? = constraintsSort.first
        if result != nil, let layoutAttributekey = layoutAttributekey  {
            objc_setAssociatedObject ( self, layoutAttributekey, result, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if let layoutAttributeDefaultKey = layoutAttribute.defaultAssociatedObjectKey {
                if objc_getAssociatedObject(self, layoutAttributeDefaultKey) == nil {
                    objc_setAssociatedObject ( self, layoutAttributeDefaultKey, result?.constant, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
        }
        
        return result!
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
                
                metrics["width\(idx)"] = (obj.frame.size.width)
                
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
                
                metrics["height\(idx)"] = (obj.frame.size.height)
                
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


