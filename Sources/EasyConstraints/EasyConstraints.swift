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
    private lazy var constraintInfo: ECConstraintInfo = { return ECConstraintInfo(easyConstraints: self) }()

    lazy var goneInfo: GoneInfo = { return GoneInfo() }()

    weak var view: UIView?

    required init(view: UIView) {
        self.view = view
    }

    public var left: CGFloat {
        get {
            return self.getLayoutConstraint(.left)?.constant ?? 0
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
            return self.getLayoutConstraint(.right)?.constant ?? 0
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
            return self.getLayoutConstraint(.leading)?.constant ?? 0
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
            return self.getLayoutConstraint(.trailing)?.constant ?? 0
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
            return self.getLayoutConstraint(.top)?.constant ?? 0
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
            return self.getLayoutConstraint(.bottom)?.constant ?? 0
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
        get { return self.getLayoutConstraint(.width)?.constant ?? 0 }
        set { self.setConstraint(.width, newValue) }
    }

    @discardableResult
    public func width(_ value: CGFloat) -> EasyConstraints {
        width = value
        return self
    }

    public var height: CGFloat {
        get { return self.getLayoutConstraint(.height)?.constant ?? 0 }
        set { self.setConstraint(.height, newValue) }
    }

    @discardableResult
    public func height(_ value: CGFloat) -> EasyConstraints {
        height = value
        return self
    }

    public var centerX: CGFloat {
        get {
            return self.getLayoutConstraint(.centerX)?.constant ?? 0
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
            return self.getLayoutConstraint(.centerY)?.constant ?? 0
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
        if let value: NSLayoutConstraint = constraintInfo.getConstraint(layoutAttribute) {
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
            constraintInfo.setConstraint(layoutAttribute, value: result)
            constraintInfo.setDefaultValue(layoutAttribute, value: result.constant)
        }

        return result
    }
}

// MARK: - Check
extension EasyConstraints {
    public var isLeft: Bool { constraintInfo.checkConstraints(.left) }
    public var isRight: Bool { constraintInfo.checkConstraints(.right) }
    public var isTop: Bool { constraintInfo.checkConstraints(.top) }
    public var isBottom: Bool { constraintInfo.checkConstraints(.bottom) }
    public var isLeading: Bool { constraintInfo.checkConstraints(.leading) }
    public var isTrailing: Bool { constraintInfo.checkConstraints(.trailing) }
    public var isWidth: Bool { constraintInfo.checkConstraints(.width) }
    public var isHeight: Bool { constraintInfo.checkConstraints(.height) }
    public var isCenterX: Bool { constraintInfo.checkConstraints(.centerX) }
    public var isCenterY: Bool { constraintInfo.checkConstraints(.centerY) }
}

// MARK: - Default
extension EasyConstraints {
    public var leftDefault: CGFloat { constraintInfo.getDefaultValue(.left) }
    public var rightDefault: CGFloat { constraintInfo.getDefaultValue(.right) }
    public var topDefault: CGFloat { constraintInfo.getDefaultValue(.top) }
    public var bottomDefault: CGFloat { constraintInfo.getDefaultValue(.bottom) }
    public var leadingDefault: CGFloat { constraintInfo.getDefaultValue(.leading) }
    public var trailingDefault: CGFloat { constraintInfo.getDefaultValue(.trailing) }
    public var widthDefault: CGFloat { constraintInfo.getDefaultValue(.width) }
    public var heightDefault: CGFloat { constraintInfo.getDefaultValue(.height) }
    public var centerXDefault: CGFloat { constraintInfo.getDefaultValue(.centerX) }
    public var centerYDefault: CGFloat { constraintInfo.getDefaultValue(.centerY) }

    public func resetValue(_ attributes: NSLayoutConstraint.Attribute...) {
        attributes.forEach { att in
            switch att {
            case .left: left = leftDefault
            case .right: right = rightDefault
            case .top: top = topDefault
            case .bottom: bottom = bottomDefault
            case .leading: leading = leadingDefault
            case .trailing: trailing = trailingDefault
            case .width: width = widthDefault
            case .height: height = heightDefault
            case .centerX: centerX = centerXDefault
            case .centerY: centerY = centerYDefault
            @unknown default:
                return
            }
        }
    }
}

private extension NSLayoutConstraint.Attribute {
    var string: String {
        switch self {
        case .left: return "left"
        case .right: return "right"
        case .top: return "top"
        case .bottom: return "bottom"
        case .leading: return "leading"
        case .trailing: return "trailing"
        case .width: return "width"
        case .height: return "height"
        case .centerX: return "centerX"
        case .centerY: return "centerY"
        @unknown default:
            return "unknown"
        }
    }
}

@MainActor
private class ECConstraintInfo {
    weak var easyConstraints: EasyConstraints?

    // check
    private var isLeftConstraint: Bool?
    private var isRightConstraint: Bool?
    private var isTopConstraint: Bool?
    private var isBottomConstraint: Bool?

    private var isLeadingConstraint: Bool?
    private var isTrailingConstraint: Bool?

    private var isWidthConstraint: Bool?
    private var isHeightConstraint: Bool?

    private var isCenterXConstraint: Bool?
    private var isCenterYConstraint: Bool?

    // constraint
    private var leftConstraint: NSLayoutConstraint?
    private var rightConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?

    private var leadingConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?

    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?

    private var centerXConstraint: NSLayoutConstraint?
    private var centerYConstraint: NSLayoutConstraint?

    // default
    private var leftDefault: CGFloat?
    private var rightDefault: CGFloat?
    private var topDefault: CGFloat?
    private var bottomDefault: CGFloat?

    private var leadingDefault: CGFloat?
    private var trailingDefault: CGFloat?

    private var widthDefault: CGFloat?
    private var heightDefault: CGFloat?

    private var centerXDefault: CGFloat?
    private var centerYDefault: CGFloat?

    init(easyConstraints: EasyConstraints) {
        self.easyConstraints = easyConstraints
    }

    func checkConstraints(_ attribute: NSLayoutConstraint.Attribute) -> Bool {
        switch attribute {
        case .left:
            if let value = isLeftConstraint {
                return value
            }
            else {
                if let _ = easyConstraints?.getLayoutConstraint(attribute, errorCheck: false) {
                    isLeftConstraint = true
                    return true
                }
                else {
                    isLeftConstraint = false
                    return false
                }
            }
        case .right:
            if let value = isRightConstraint {
                return value
            }
            else {
                if let _ = easyConstraints?.getLayoutConstraint(attribute, errorCheck: false) {
                    isRightConstraint = true
                    return true
                }
                else {
                    isRightConstraint = false
                    return false
                }
            }
        case .top:
            if let value = isTopConstraint {
                return value
            }
            else {
                if let _ = easyConstraints?.getLayoutConstraint(attribute, errorCheck: false) {
                    isTopConstraint = true
                    return true
                }
                else {
                    isTopConstraint = false
                    return false
                }
            }
        case .bottom:
            if let value = isBottomConstraint {
                return value
            }
            else {
                if let _ = easyConstraints?.getLayoutConstraint(attribute, errorCheck: false) {
                    isBottomConstraint = true
                    return true
                }
                else {
                    isBottomConstraint = false
                    return false
                }
            }
        case .leading:
            if let value = isLeadingConstraint {
                return value
            }
            else {
                if let _ = easyConstraints?.getLayoutConstraint(attribute, errorCheck: false) {
                    isLeadingConstraint = true
                    return true
                }
                else {
                    isLeadingConstraint = false
                    return false
                }
            }
        case .trailing:
            if let value = isTrailingConstraint {
                return value
            }
            else {
                if let _ = easyConstraints?.getLayoutConstraint(attribute, errorCheck: false) {
                    isTrailingConstraint = true
                    return true
                }
                else {
                    isTrailingConstraint = false
                    return false
                }
            }
        case .width:
            if let value = isWidthConstraint {
                return value
            }
            else {
                if let _ = easyConstraints?.getLayoutConstraint(attribute, errorCheck: false) {
                    isWidthConstraint = true
                    return true
                }
                else {
                    isWidthConstraint = false
                    return false
                }
            }
        case .height:
            if let value = isHeightConstraint {
                return value
            }
            else {
                if let _ = easyConstraints?.getLayoutConstraint(attribute, errorCheck: false) {
                    isHeightConstraint = true
                    return true
                }
                else {
                    isHeightConstraint = false
                    return false
                }
            }
        case .centerX:
            if let value = isCenterXConstraint {
                return value
            }
            else {
                if let _ = easyConstraints?.getLayoutConstraint(attribute, errorCheck: false) {
                    isCenterXConstraint = true
                    return true
                }
                else {
                    isCenterXConstraint = false
                    return false
                }
            }
        case .centerY:
            if let value = isCenterYConstraint {
                return value
            }
            else {
                if let _ = easyConstraints?.getLayoutConstraint(attribute, errorCheck: false) {
                    isCenterYConstraint = true
                    return true
                }
                else {
                    isCenterYConstraint = false
                    return false
                }
            }
        @unknown default:
            return false
        }
    }

    func getConstraint(_ attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        switch attribute {
        case .left: return leftConstraint
        case .right:return rightConstraint
        case .top: return topConstraint
        case .bottom: return bottomConstraint
        case .leading: return leadingConstraint
        case .trailing: return trailingConstraint
        case .width: return widthConstraint
        case .height: return heightConstraint
        case .centerX: return centerXConstraint
        case .centerY: return centerYConstraint
        @unknown default:
            return nil
        }
    }

    func setConstraint(_ attribute: NSLayoutConstraint.Attribute, value: NSLayoutConstraint) {
        switch attribute {
        case .left: leftConstraint = value
        case .right: rightConstraint = value
        case .top: topConstraint = value
        case .bottom: bottomConstraint = value
        case .leading: leadingConstraint = value
        case .trailing: trailingConstraint = value
        case .width: widthConstraint = value
        case .height: heightConstraint = value
        case .centerX: centerXConstraint = value
        case .centerY: centerYConstraint = value
        @unknown default:
            break
        }
    }

    private func getPrivateDefaultValue(_ attribute: NSLayoutConstraint.Attribute) -> CGFloat? {
        switch attribute {
        case .left: return leftDefault
        case .right: return rightDefault
        case .top: return topDefault
        case .bottom: return bottomDefault
        case .leading: return leadingDefault
        case .trailing: return trailingDefault
        case .width: return widthDefault
        case .height: return heightDefault
        case .centerX: return centerXDefault
        case .centerY: return centerYDefault
        @unknown default:
            return nil
        }
    }

    func setDefaultValue(_ attribute: NSLayoutConstraint.Attribute, value: CGFloat) {
        guard getPrivateDefaultValue(attribute) == nil else { return }
        switch attribute {
        case .left: leftDefault = value
        case .right: rightDefault = value
        case .top: topDefault = value
        case .bottom: bottomDefault = value
        case .leading: leadingDefault = value
        case .trailing: trailingDefault = value
        case .width: widthDefault = value
        case .height: heightDefault = value
        case .centerX: centerXDefault = value
        case .centerY: centerYDefault = value
        @unknown default:
            break
        }
    }

    func getDefaultValue(_ attribute: NSLayoutConstraint.Attribute) -> CGFloat {
        easyConstraints?.getLayoutConstraint(attribute)
        if let value = getPrivateDefaultValue(attribute) {
            return value
        }
        assertionFailure("Error getDefaultConstraint")
        return 0.0
    }
}
