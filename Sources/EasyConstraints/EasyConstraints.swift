//
//  UIViewExtensions.swift
//
//  Created by pkh on 2018. 8. 14..
//  Copyright © 2018년 pkh. All rights reserved.

import UIKit

///## 🎊 No more @IBOutlets
///🕵🏻‍♂️ With this extension, now you don't have to @IBOulet from your storyboard to get constraints.
///
///### Get & Set Constraints - as you wish
///
///> widthConstraint, heightConstraint, topConstraint, leadingConstraint, bottomConstraint,  trailingConstraint, centerXConstraint, centerYConstraint
///
///### Get Default Constraints - constraints that you first set in SB
///
///> widthDefaultConstraint, heightDefaultConstraint, topDefaultConstraint, leadingDefaultConstraint, bottomDefaultConstraint, trailingDefaultConstraint, centerXDefaultConstraint, centerYDefaultConstraint
///
///## USE like this
///
///```swift
///view.ea.leading = value // set AutoLayout Constraint value
///view.ea.leading(10).top(10).trailing(10).bottom(10) // set AutoLayout Constraint value
///
///let value = view.ec.leading // get AutoLayout Constraint value
///
///let defaultValue = view.ec.widthDefault // first set AutoLayout Constraint value
///
///view.ec.gone = true // Android view gone function
///
///view.ec.reset(.top, .trailing, .width, .height) // set Default Constraint Value
///
/// make test
///let v = UIView()
///v.translatesAutoresizingMaskIntoConstraints = false
///v.backgroundColor = .red
///v.addSuperView(self.view)
///    .ec.make()
///    .top(view4.topAnchor, 10)
///    .leading(view4.leftAnchor, 10)
///    .width(50)
///    .height(50)
///
///
///```
@MainActor
public class EasyConstraints {
    private lazy var constraintInfo: ECConstraintInfo = { return ECConstraintInfo() }()

    lazy var goneInfo: GoneInfo = { return GoneInfo() }()

    weak var view: UIView?

    required init(view: UIView) {
        self.view = view
    }

    public var left: CGFloat {
        get {
            return self.getConstraint(.left)
        }
        set {
            let constraint = self.getLayoutConstraint(.left)
            if constraint?.secondItem === self.view {
                self.setConstraint(.left, newValue * -1)
            }
            else {
                self.setConstraint(.left, newValue)
            }
        }
    }

    @discardableResult
    public func left(_ value: CGFloat) -> EasyConstraints {
        left = value
        return self
    }

    public var right: CGFloat {
        get {
            return self.getConstraint(.right)
        }
        set {
            let constraint = self.getLayoutConstraint(.right)
            if constraint?.firstItem === self.view {
                self.setConstraint(.right, newValue * -1)
            }
            else {
                self.setConstraint(.right, newValue)
            }
        }
    }

    @discardableResult
    public func right(_ value: CGFloat) -> EasyConstraints {
        right = value
        return self
    }

    public var leading: CGFloat {
        get {
            return self.getConstraint(.leading)
        }
        set {
            let constraint = self.getLayoutConstraint(.leading)
            if constraint?.secondItem === self.view {
                self.setConstraint(.leading, newValue * -1)
            }
            else {
                self.setConstraint(.leading, newValue)
            }
        }
    }

    @discardableResult
    public func leading(_ value: CGFloat) -> EasyConstraints {
        leading = value
        return self
    }

    public var trailing: CGFloat {
        get {
            return self.getConstraint(.trailing)
        }
        set {
            let constraint = self.getLayoutConstraint(.trailing)
            if constraint?.firstItem === self.view {
                self.setConstraint(.trailing, newValue * -1)
            }
            else {
                self.setConstraint(.trailing, newValue)
            }
        }
    }

    @discardableResult
    public func trailing(_ value: CGFloat) -> EasyConstraints {
        trailing = value
        return self
    }

    public var top: CGFloat {
        get {
            return self.getConstraint(.top)
        }
        set {
            let constraint = self.getLayoutConstraint(.top)
            if constraint?.secondItem === self.view {
                self.setConstraint(.top, newValue * -1)
            }
            else {
                self.setConstraint(.top, newValue)
            }
        }
    }

    @discardableResult
    public func top(_ value: CGFloat) -> EasyConstraints {
        top = value
        return self
    }

    public var bottom: CGFloat {
        get {
            return self.getConstraint(.bottom)
        }
        set {
            let constraint = self.getLayoutConstraint(.bottom)
            if constraint?.firstItem === self.view {
                self.setConstraint(.bottom, newValue * -1)
            }
            else {
                self.setConstraint(.bottom, newValue)
            }
        }
    }

    @discardableResult
    public func bottom(_ value: CGFloat) -> EasyConstraints {
        bottom = value
        return self
    }

    public var width: CGFloat {
        get { return self.getConstraint(.width) }
        set { self.setConstraint(.width, newValue) }
    }

    @discardableResult
    public func width(_ value: CGFloat) -> EasyConstraints {
        width = value
        return self
    }

    public var height: CGFloat {
        get { return self.getConstraint(.height) }
        set { self.setConstraint(.height, newValue) }
    }

    @discardableResult
    public func height(_ value: CGFloat) -> EasyConstraints {
        height = value
        return self
    }

    public var centerX: CGFloat {
        get {
            return self.getConstraint(.centerX)
        }
        set {
            let constraint = self.getLayoutConstraint(.centerX)
            if constraint?.secondItem === self.view {
                self.setConstraint(.centerX, newValue * -1)
            }
            else {
                self.setConstraint(.centerX, newValue)
            }
        }
    }

    @discardableResult
    public func centerX(_ value: CGFloat) -> EasyConstraints {
        centerX = value
        return self
    }

    public var centerY: CGFloat {
        get {
            return self.getConstraint(.centerY)
        }
        set {
            let constraint = self.getLayoutConstraint(.centerY)
            if constraint?.secondItem === self.view {
                self.setConstraint(.centerY, newValue * -1)
            }
            else {
                self.setConstraint(.centerY, newValue)
            }
        }
    }

    @discardableResult
    public func centerY(_ value: CGFloat) -> EasyConstraints {
        centerY = value
        return self
    }

    //MARK: - main function
    private func getConstraint(_ layoutAttribute: NSLayoutConstraint.Attribute) -> CGFloat {
        return self.getLayoutConstraint(layoutAttribute)?.constant ?? 0
    }

    private func getDefaultConstraint(_ layoutAttribute: NSLayoutConstraint.Attribute) -> CGFloat {
        self.getLayoutConstraint(layoutAttribute)
        if let value = constraintInfo.getConstraintDefaultValue(attribute: layoutAttribute) {
            return value
        }

        assertionFailure("Error getDefaultConstraint")
        return 0.0
    }

    private func setConstraint(_ layoutAttribute: NSLayoutConstraint.Attribute, _ value: CGFloat) {
        guard let view = self.view else { return }
        guard self.getLayoutConstraint(layoutAttribute)?.constant != value else { return }
        self.getLayoutConstraint(layoutAttribute)?.constant = value
        view.setNeedsLayout()
    }

    /// 특정뷰의 layoutAttribute를 가져오기 (전뷰를 검사하기 때문에 느림. 셀에서는 쓰지 말것)
    /// - Parameter layoutAttribute: layoutAttribute
    /// - Parameter toTaget: 특정뷰
    public func getConstraint(_ layoutAttribute: NSLayoutConstraint.Attribute, toTaget: UIView) -> NSLayoutConstraint? {
        guard let view = self.view else { return nil }
        let constraints: [NSLayoutConstraint] = self.getContraints(view.topParentViewView, checkSub: true)
        var constraintsTemp: [NSLayoutConstraint] = self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
        constraintsTemp = constraintsTemp.filter { value -> Bool in
            return value.firstItem === toTaget || value.secondItem === toTaget
        }
//        assert(constraintsTemp.first != nil, "not find TagetView")
        return constraintsTemp.first
    }

    @inline(__always)
    private func getContraints(_ view: UIView, checkSub: Bool = false) -> [NSLayoutConstraint] {
        var result: [NSLayoutConstraint] = [NSLayoutConstraint]()
        result.reserveCapacity(100)
        if checkSub {
            for subView: UIView in view.subviews {
                result += self.getContraints(subView, checkSub: checkSub)
            }
        }

        result += view.constraints

        return result
    }

    @inline(__always)
    private func getAttributeConstrains(constraints: [NSLayoutConstraint], layoutAttribute: NSLayoutConstraint.Attribute) -> [NSLayoutConstraint] {
        var constraintsTemp: [NSLayoutConstraint] = [NSLayoutConstraint]()
        constraintsTemp.reserveCapacity(100)

        @inline(__always)
        func subFuc(constraint: NSLayoutConstraint, f: NSLayoutConstraint.Attribute, s: NSLayoutConstraint.Attribute) {
            if  constraint.firstItem === self.view && constraint.firstAttribute == f && constraint.secondAttribute == s {
                constraintsTemp.append(constraint)
            }
            else if  constraint.secondItem === self.view && constraint.secondAttribute == f && constraint.firstAttribute == s {
                constraintsTemp.append(constraint)
            }
            else if constraint.firstAttribute == f && constraint.secondAttribute == f {
                if (constraint.firstItem === self.view && constraint.secondItem === self.view?.superview ) ||
                    (constraint.secondItem === self.view && constraint.firstItem === self.view?.superview ) {
                    constraintsTemp.append(constraint)
                }
                else {
                    if (constraint.firstItem === self.view && constraint.secondItem is UILayoutGuide) ||
                        (constraint.secondItem === self.view && constraint.firstItem is UILayoutGuide) {
                        constraintsTemp.append(constraint)
                    }
                    else if constraint.firstItem === self.view || constraint.secondItem === self.view {
                        constraintsTemp.append(constraint)
                    }
                }
            }
        }

        for constraint: NSLayoutConstraint in constraints {
            switch layoutAttribute {
            case .width, .height:
                if type(of: constraint) === NSLayoutConstraint.self {
                    if  constraint.firstItem === self.view && constraint.firstAttribute == layoutAttribute && constraint.secondItem == nil {
                        if self.view is UIButton || self.view is UILabel || self.view is UIImageView {
                            constraintsTemp.append(constraint)
                        }
                        else {
                            if self.view is UIButton || self.view is UILabel || self.view is UIImageView {
                                constraintsTemp.append(constraint)
                            }
                            else {
                                constraintsTemp.append(constraint)
                            }
                        }
                    }
                    else if  constraint.firstAttribute == layoutAttribute && constraint.secondAttribute == layoutAttribute {
                        if constraint.firstItem === self.view || constraint.secondItem === self.view {
                            constraintsTemp.append(constraint)
                        }
                    }
                }
            case .centerX, .centerY:
                if constraint.firstAttribute == layoutAttribute && constraint.secondAttribute == layoutAttribute {
                    if (constraint.firstItem === self.view && (constraint.secondItem === self.view?.superview || constraint.secondItem is UILayoutGuide)) ||
                        (constraint.secondItem === self.view && (constraint.firstItem === self.view?.superview || constraint.firstItem is UILayoutGuide)) {
                        constraintsTemp.append(constraint)
                    }
                    else if constraint.firstItem === self.view || constraint.secondItem === self.view {
                        constraintsTemp.append(constraint)
                    }
                }
            case .top :
                subFuc(constraint: constraint, f: .top, s: .bottom)
            case .bottom :
                subFuc(constraint: constraint, f: .bottom, s: .top)
            case .leading, .left :
                if layoutAttribute == .leading {
                    subFuc(constraint: constraint, f: .leading, s: .trailing)
                }
                else {
                    subFuc(constraint: constraint, f: .left, s: .right)
                }

            case .trailing, .right :
                if layoutAttribute == .trailing {
                    subFuc(constraint: constraint, f: .trailing, s: .leading)
                }
                else {
                    subFuc(constraint: constraint, f: .right, s: .left)
                }
            default :
                assertionFailure("not supput \(layoutAttribute)")
            }
        }

        return constraintsTemp
    }

    @inline(__always)
    private func getLayoutAllConstraints(_ layoutAttribute: NSLayoutConstraint.Attribute) -> [NSLayoutConstraint] {
        guard let view = self.view else { return [] }
        var resultConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
        resultConstraints.reserveCapacity(100)
        var constraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
        constraints.reserveCapacity(100)

        if layoutAttribute == .width || layoutAttribute == .height {
            constraints = self.getContraints(view)
            resultConstraints += self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)

            if resultConstraints.count == 0 {
                if let view = view.superview {
                    constraints = self.getContraints(view)
                    resultConstraints += self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
                }
            }

            if resultConstraints.count == 0 {
                constraints = self.getContraints(view.topParentViewView, checkSub: true)
                resultConstraints += self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
            }
        }
        else {
            if let view = view.superview {
                constraints = self.getContraints(view)
                resultConstraints += self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
            }

            if resultConstraints.count == 0 {
                constraints = self.getContraints(view)
                resultConstraints += self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
            }

            if resultConstraints.count == 0 {
                constraints = self.getContraints(view.topParentViewView, checkSub: true)
                resultConstraints += self.getAttributeConstrains(constraints: constraints, layoutAttribute: layoutAttribute)
            }
        }

        return resultConstraints
    }

    @discardableResult
    public func getLayoutConstraint(_ layoutAttribute: NSLayoutConstraint.Attribute, errorCheck: Bool = true) -> NSLayoutConstraint? {
        guard let view = self.view else { return nil }
        if let value: NSLayoutConstraint = constraintInfo.getLayoutConstraint(attribute: layoutAttribute) {
            return value
        }

        let constraintsTemp: [NSLayoutConstraint] = getLayoutAllConstraints(layoutAttribute)

        if constraintsTemp.count == 0 {
            if errorCheck {
                assertionFailure("""

                                    🔗 ------------------------------------------------ 
                                    \(view.constraints)
                                    AutoLayout Not Make layoutAttribute : \(layoutAttribute.string) \nView: \(self)
                                    🔗 ------------------------------------------------
                                    
                                 """)
            }
            return nil
        }

        let constraintsSort: Array = constraintsTemp.sorted(by: { obj1, obj2 -> Bool in
            return obj1.priority.rawValue > obj2.priority.rawValue
        })

        let result: NSLayoutConstraint? = constraintsSort.first
        if let result = result {
            constraintInfo.setLayoutConstraint(attribute: layoutAttribute, value: result)

            if constraintInfo.getConstraintDefaultValue(attribute: layoutAttribute) == nil {
               constraintInfo.setConstraintDefaultValue(attribute: layoutAttribute, value: result.constant)
            }
        }

        return result
    }
}

// MARK: - Check
extension EasyConstraints {
    public var isLeft: Bool {
        get {
            if let value = constraintInfo.isLeftConstraint {
                return value
            }
            else {
                if let _ = self.getLayoutConstraint(.left, errorCheck: false) {
                    constraintInfo.isLeftConstraint = true
                    return true
                }
                constraintInfo.isLeftConstraint = false
                return false

            }
        }
    }

    public var isRight: Bool {
        get {
            if let value = constraintInfo.isRightConstraint {
                return value
            }
            else {
                if let _ = self.getLayoutConstraint(.right, errorCheck: false) {
                    constraintInfo.isRightConstraint = true
                    return true
                }
                constraintInfo.isRightConstraint = false
                return false
            }
        }
    }

    public var isTop: Bool {
        get {
            if let value = constraintInfo.isTopConstraint {
                return value
            }
            else {
                if let _ = self.getLayoutConstraint(.top, errorCheck: false) {
                    constraintInfo.isTopConstraint = true
                    return true
                }
                constraintInfo.isTopConstraint = false
                return false

            }
        }
    }

    public var isBottom: Bool {
        get {
            if let value = constraintInfo.isBottomConstraint {
                return value
            }
            else {
                if let _ = self.getLayoutConstraint(.bottom, errorCheck: false) {
                    constraintInfo.isBottomConstraint = true
                    return true
                }
                constraintInfo.isBottomConstraint = false
                return false
            }
        }
    }

    public var isLeading: Bool {
        get {
            if let value = constraintInfo.isLeadingConstraint {
                return value
            }
            else {
                if let _ = self.getLayoutConstraint(.leading, errorCheck: false) {
                    constraintInfo.isLeadingConstraint = true
                    return true
                }
                constraintInfo.isLeadingConstraint = false
                return false
            }
        }
    }

    public var isTrailing: Bool {
        get {
            if let value = constraintInfo.isTrailingConstraint {
                return value
            }
            else {
                if let _ = self.getLayoutConstraint(.trailing, errorCheck: false) {
                    constraintInfo.isTrailingConstraint = true
                    return true
                }
                constraintInfo.isTrailingConstraint = false
                return false
            }
        }
    }

    public var isWidth: Bool {
        get {
            if let value = constraintInfo.isWidthConstraint {
                return value
            }
            else {
                guard let view = self.view else { return false }
                let value = self.getAttributeConstrains(constraints: view.constraints, layoutAttribute: .width).count > 0
                constraintInfo.isWidthConstraint = value
                return value
            }
        }
    }

    public var isHeight: Bool {
        get {
            if let value = constraintInfo.isHeightConstraint {
                return value
            }
            else {
                guard let view = self.view else { return false }
                let value = self.getAttributeConstrains(constraints: view.constraints, layoutAttribute: .height).count > 0
                constraintInfo.isHeightConstraint = value
                return value
            }
        }
    }

    public var isCenterX: Bool {
        get {
            if let value = constraintInfo.isCenterXConstraint {
                return value
            }
            else {
                if let _ = self.getLayoutConstraint(.centerX, errorCheck: false) {
                    constraintInfo.isCenterXConstraint = true
                    return true
                }
                constraintInfo.isCenterXConstraint = false
                return false
            }
        }
    }

    public var isCenterY: Bool {
        get {
            if let value = constraintInfo.isCenterYConstraint {
                return value
            }
            else {
                if let _ = self.getLayoutConstraint(.centerY, errorCheck: false) {
                    constraintInfo.isCenterYConstraint = true
                    return true
                }
                constraintInfo.isCenterYConstraint = false
                return false
            }
        }
    }
}

// MARK: - Default
extension EasyConstraints {
    public var leftDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.left)
        }
    }

    public var rightDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.right)
        }
    }

    public var topDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.top)
        }
    }

    public var bottomDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.bottom)
        }
    }

    public var leadingDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.leading)
        }
    }

    public var trailingDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.trailing)
        }
    }

    public var widthDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.width)
        }
    }

    public var heightDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.height)
        }
    }

    public var centerXDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.centerX)
        }
    }

    public var centerYDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.centerY)
        }
    }

    public func reset(_ attribute: NSLayoutConstraint.Attribute...) {
        attribute.forEach { att in
            switch att {
            case .left:
                left = leftDefault
            case .right:
                right = rightDefault
            case .top:
                top = topDefault
            case .bottom:
                bottom = bottomDefault
            case .leading:
                leading = leadingDefault
            case .trailing:
                trailing = trailingDefault
            case .width:
                width = widthDefault
            case .height:
                height = heightDefault
            case .centerX:
                centerX = centerXDefault
            case .centerY:
                centerY = centerYDefault
            default:
                return
            }
        }
    }
}

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
        @unknown default:
            return ""
        }
    }
}

private class ECConstraintInfo {
    // check
    var isLeftConstraint: Bool?
    var isRightConstraint: Bool?
    var isTopConstraint: Bool?
    var isBottomConstraint: Bool?

    var isLeadingConstraint: Bool?
    var isTrailingConstraint: Bool?

    var isWidthConstraint: Bool?
    var isHeightConstraint: Bool?

    var isCenterXConstraint: Bool?
    var isCenterYConstraint: Bool?

    // constraint
    var leftConstraint: NSLayoutConstraint?
    var rightConstraint: NSLayoutConstraint?
    var topConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?

    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?

    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?

    var centerXConstraint: NSLayoutConstraint?
    var centerYConstraint: NSLayoutConstraint?

    // default
    var leftDefaultConstraint: CGFloat?
    var rightDefaultConstraint: CGFloat?
    var topDefaultConstraint: CGFloat?
    var bottomDefaultConstraint: CGFloat?

    var leadingDefaultConstraint: CGFloat?
    var trailingDefaultConstraint: CGFloat?

    var widthDefaultConstraint: CGFloat?
    var heightDefaultConstraint: CGFloat?

    var centerXDefaultConstraint: CGFloat?
    var centerYDefaultConstraint: CGFloat?

    func getLayoutConstraint(attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        var result: NSLayoutConstraint?
        switch attribute {
        case .left:
            result = leftConstraint
        case .right:
            result = rightConstraint
        case .top:
            result = topConstraint
        case .bottom:
            result = bottomConstraint
        case .leading:
            result = leadingConstraint
        case .trailing:
            result = trailingConstraint
        case .width:
            result = widthConstraint
        case .height:
            result = heightConstraint
        case .centerX:
            result = centerXConstraint
        case .centerY:
            result = centerYConstraint
        default:
            break
        }

        return result
    }

    func setLayoutConstraint(attribute: NSLayoutConstraint.Attribute, value: NSLayoutConstraint) {
        switch attribute {
        case .left:
            leftConstraint = value
        case .right:
            rightConstraint = value
        case .top:
            topConstraint = value
        case .bottom:
            bottomConstraint = value
        case .leading:
            leadingConstraint = value
        case .trailing:
            trailingConstraint = value
        case .width:
            widthConstraint = value
        case .height:
            heightConstraint = value
        case .centerX:
            centerXConstraint = value
        case .centerY:
            centerYConstraint = value
        default:
            break
        }
    }

    func getConstraintDefaultValue(attribute: NSLayoutConstraint.Attribute) -> CGFloat? {
        var result: CGFloat?
        switch attribute {
        case .left:
            result = leftDefaultConstraint
        case .right:
            result = rightDefaultConstraint
        case .top:
            result = topDefaultConstraint
        case .bottom:
            result = bottomDefaultConstraint
        case .leading:
            result = leadingDefaultConstraint
        case .trailing:
            result = trailingDefaultConstraint
        case .width:
            result = widthDefaultConstraint
        case .height:
            result = heightDefaultConstraint
        case .centerX:
            result = centerXDefaultConstraint
        case .centerY:
            result = centerYDefaultConstraint
        default:
            break
        }

        return result
    }

    func setConstraintDefaultValue(attribute: NSLayoutConstraint.Attribute, value: CGFloat) {
        switch attribute {
        case .left:
            leftDefaultConstraint = value
        case .right:
            rightDefaultConstraint = value
        case .top:
            topDefaultConstraint = value
        case .bottom:
            bottomDefaultConstraint = value
        case .leading:
            leadingDefaultConstraint = value
        case .trailing:
            trailingDefaultConstraint = value
        case .width:
            widthDefaultConstraint = value
        case .height:
            heightDefaultConstraint = value
        case .centerX:
            centerXDefaultConstraint = value
        case .centerY:
            centerYDefaultConstraint = value
        default:
            break
        }
    }
}
