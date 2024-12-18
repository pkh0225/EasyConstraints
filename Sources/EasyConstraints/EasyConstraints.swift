//
//  UIViewExtensions.swift
//
//  Created by pkh on 2018. 8. 14..
//  Copyright © 2018년 pkh. All rights reserved.

#if os(iOS)

import UIKit

public enum VIEW_ADD_TYPE  {
    case horizontal
    case vertical
}

public struct GoneType: OptionSet, @unchecked Sendable {
    public let rawValue: Int

    nonisolated public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let leading = GoneType(rawValue: 1 << 0)
    public static let trailing = GoneType(rawValue: 1 << 1)
    public static let top = GoneType(rawValue: 1 << 2)
    public static let bottom = GoneType(rawValue: 1 << 3)
    public static let width = GoneType(rawValue: 1 << 4)
    public static let height = GoneType(rawValue: 1 << 5)

    public static let size: GoneType = [.width, .height]

    public static let widthLeading: GoneType = [.width, .leading]
    public static let widthTrailing: GoneType = [.width, .trailing]
    public static let widthPadding: GoneType = [.width, .leading, .trailing]

    public static let heightTop: GoneType = [.height, .top]
    public static let heightBottom: GoneType = [.height, .bottom]
    public static let heightPadding: GoneType = [.height, .top, .bottom]

    public static let padding: GoneType = [.leading, .trailing, .top, .bottom]
    public static let all: GoneType = [.leading, .trailing, .top, .bottom, .width, .height]
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

// MARK: - EasyConstraints Get
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
///view.viewDidDisappear = {
///    print("viewDidDisappear ")
///}
///
///```
@MainActor
public class EasyConstraints {
    private lazy var constraintInfo: ConstraintInfo = { return ConstraintInfo() }()
    private class ConstraintInfo {
        var isWidthConstraint: Bool?
        var isHeightConstraint: Bool?
        var isTopConstraint: Bool?
        var isLeadingConstraint: Bool?
        var isBottomConstraint: Bool?
        var isTrailingConstraint: Bool?
        var isCenterXConstraint: Bool?
        var isCenterYConstraint: Bool?

        var widthConstraint: NSLayoutConstraint?
        var heightConstraint: NSLayoutConstraint?
        var topConstraint: NSLayoutConstraint?
        var leadingConstraint: NSLayoutConstraint?
        var bottomConstraint: NSLayoutConstraint?
        var trailingConstraint: NSLayoutConstraint?
        var centerXConstraint: NSLayoutConstraint?
        var centerYConstraint: NSLayoutConstraint?

        var widthDefaultConstraint: CGFloat?
        var heightDefaultConstraint: CGFloat?
        var topDefaultConstraint: CGFloat?
        var leadingDefaultConstraint: CGFloat?
        var bottomDefaultConstraint: CGFloat?
        var trailingDefaultConstraint: CGFloat?
        var centerXDefaultConstraint: CGFloat?
        var centerYDefaultConstraint: CGFloat?

        func getLayoutConstraint(attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
            var result: NSLayoutConstraint?
            switch attribute {
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

    private lazy var goneInfo: GoneInfo = { return GoneInfo() }()
    private class GoneInfo {
        var widthEmptyConstraint: NSLayoutConstraint?
        var heightEmptyConstraint: NSLayoutConstraint?
        var widthGoneValue: CGFloat?
        var heightGoneValue: CGFloat?
        var topGoneValue: CGFloat?
        var leadingGoneValue: CGFloat?
        var bottomGoneValue: CGFloat?
        var trailingGoneValue: CGFloat?
    }

    weak var view: UIView?

    required init(view: UIView) {
        self.view = view
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

    public var topDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.top)
        }
    }

    public var leadingDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.leading)
        }
    }

    public var bottomDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.bottom)
        }
    }

    public var trailingDefault: CGFloat {
        get {
            return self.getDefaultConstraint(.trailing)
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
                leading = leadingDefault
            case .right:
                trailing = trailingDefault
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
                if  constraint.firstItem === self.view && constraint.firstAttribute == .top && constraint.secondAttribute == .bottom {
                    constraintsTemp.append(constraint)
                }
                else if  constraint.secondItem === self.view && constraint.secondAttribute == .top && constraint.firstAttribute == .bottom {
                    constraintsTemp.append(constraint)
                }
                else if constraint.firstAttribute == .top && constraint.secondAttribute == .top {
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
            case .bottom :
                if  constraint.firstItem === self.view && constraint.firstAttribute == .bottom && constraint.secondAttribute == .top {
                    constraintsTemp.append(constraint)
                }
                else if  constraint.secondItem === self.view && constraint.secondAttribute == .bottom && constraint.firstAttribute == .top {
                    constraintsTemp.append(constraint)
                }
                else if constraint.firstAttribute == .bottom && constraint.secondAttribute == .bottom {
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
            case .leading :
                if  constraint.firstItem === self.view && constraint.firstAttribute == .leading && constraint.secondAttribute == .trailing {
                    constraintsTemp.append(constraint)
                }
                else if  constraint.secondItem === self.view && constraint.secondAttribute == .leading && constraint.firstAttribute == .trailing {
                    constraintsTemp.append(constraint)
                }
                else if constraint.firstAttribute == .leading && constraint.secondAttribute == .leading {
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
            case .trailing :
                if  constraint.firstItem === self.view && constraint.firstAttribute == .trailing && constraint.secondAttribute == .leading {
                    constraintsTemp.append(constraint)
                }
                else if  constraint.secondItem === self.view && constraint.secondAttribute == .trailing && constraint.firstAttribute == .leading {
                    constraintsTemp.append(constraint)
                }
                else if constraint.firstAttribute == .trailing && constraint.secondAttribute == .trailing {
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

    // MARK: - GONE
    public var gone: Bool {
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            if newValue {
               gone()
            }
            else {
                goneRemove()
            }
        }
    }

    /// only widht gone
    public var goneWidth: Bool {
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            if newValue {
                gone(.width)
            }
            else {
                goneRemove(.width)
            }
        }
    }

    /// only height gone
    public var goneHeight: Bool {
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            if newValue {
                gone(.height)
            }
            else {
                goneRemove(.height)
            }
        }
    }

    /// 문자열을 파싱하는 함수
    /// - Note: 이 함수는 **String**을 **Int**로 변환하며, 변환에 실패하면 `nil`을 반환합니다.
    /// - Example:
    /// ```swift
    /// let value = parseToInt("123") // 123
    /// let invalidValue = parseToInt("abc") // nil
    /// ```
    func parseToInt(_ string: String) -> Int? {
        return Int(string)
    }


    /// gone
    ///
    ///  - leading = GoneType(rawValue: 1 << 0)
    ///  - trailing = GoneType(rawValue: 1 << 1)
    ///  - top = GoneType(rawValue: 1 << 2)
    ///  - bottom = GoneType(rawValue: 1 << 3)
    ///  - width = GoneType(rawValue: 1 << 4)
    ///  - height = GoneType(rawValue: 1 << 5)
    ///
    ///  - Note:  안드로이드 gone과 유사
    ///
    /// - Example:
    /// ```swift
    ///  size: GoneType = [.width, .height]
    ///
    ///  widthLeading: GoneType = [.width, .leading]
    ///  widthTrailing: GoneType = [.width, .trailing]
    ///  widthPadding: GoneType = [.width, .leading, .trailing]
    ///
    ///  heightTop: GoneType = [.height, .top]
    ///  heightBottom: GoneType = [.height, .bottom]
    ///  heightPadding: GoneType = [.height, .top, .bottom]
    ///
    ///  padding: GoneType = [.leading, .trailing, .top, .bottom]
    ///  all: GoneType = [.leading, .trailing, .top, .bottom, .width, .height]
    ///```
    ///
    /// - Parameter type: GoneType
    public func gone(_ type: GoneType = .all) {
        guard let view = self.view else { return }
        guard type.isEmpty == false else { return }
        view.isHidden = true

        if type.contains(.width) {
            if isWidth {
                if width != 0 {
                    self.goneInfo.widthGoneValue = width
                }
                width = 0
            }
            else {
                if let c = self.goneInfo.widthEmptyConstraint {
                    if  c.constant != 0 {
                        self.goneInfo.widthGoneValue = c.constant
                    }
                    else if view.frame.size.width != 0 {
                        self.goneInfo.widthGoneValue = view.frame.size.width
                    }
                    c.constant = 0
                }
                else {
                    let constraint: NSLayoutConstraint = NSLayoutConstraint(
                        item: view,
                        attribute: .width,
                        relatedBy: .equal,
                        toItem: nil,
                        attribute: .width,
                        multiplier: 1,
                        constant: 0
                    )
                    view.addConstraint(constraint)
                    self.goneInfo.widthEmptyConstraint = constraint
                    if view.frame.size.width != 0 {
                        self.goneInfo.widthGoneValue = view.frame.size.width
                    }
                }
            }
        }
        if type.contains(.height) {
            if isHeight {
                if height != 0 {
                    self.goneInfo.heightGoneValue = height
                }
                height = 0
            }
            else {
                if let c = self.goneInfo.heightEmptyConstraint {
                    if c.constant != 0 {
                        self.goneInfo.heightGoneValue = c.constant
                    }
                    else if view.frame.size.height != 0 {
                        self.goneInfo.heightGoneValue = view.frame.size.height
                    }
                    c.constant = 0
                }
                else {
                    let constraint: NSLayoutConstraint = NSLayoutConstraint(
                        item: view,
                        attribute: .height,
                        relatedBy: .equal,
                        toItem: nil,
                        attribute: .height,
                        multiplier: 1,
                        constant: 0
                    )
                    view.addConstraint(constraint)
                    self.goneInfo.heightEmptyConstraint = constraint
                    if view.frame.size.height != 0 {
                        self.goneInfo.heightGoneValue = view.frame.size.height
                    }
                }
            }
        }
        if type.contains(.leading) {
            if isLeading, leading != 0 {
                self.goneInfo.leadingGoneValue = leading
                leading = 0
            }
        }
        if type.contains(.trailing) {
            if isTrailing, trailing != 0 {
                self.goneInfo.trailingGoneValue = trailing
                trailing = 0
            }
        }
        if type.contains(.top) {
            if isTop, top != 0 {
                self.goneInfo.topGoneValue = top
                top = 0
            }
        }
        if type.contains(.bottom) {
            if isBottom, bottom != 0 {
                self.goneInfo.bottomGoneValue = bottom
                bottom = 0
            }
        }

        view.setNeedsLayout()
    }

    public func goneRemove(_ type: GoneType = .all) {
        guard let view = self.view else { return }
        view.isHidden = false

        if type.contains(.width) {
            if let c: NSLayoutConstraint = self.goneInfo.widthEmptyConstraint {
                view.removeConstraint(c)
                self.goneInfo.widthEmptyConstraint = nil
                if let value = self.goneInfo.widthGoneValue {
                    view.frame.size.width = value
                }
            }
            else if isWidth {
                if let value = self.goneInfo.widthGoneValue {
                    width = value
                }
                else {
                    width = widthDefault
                }

            }
        }
        if type.contains(.height) {
            if let c: NSLayoutConstraint = self.goneInfo.heightEmptyConstraint {
                view.removeConstraint(c)
                self.goneInfo.heightEmptyConstraint = nil
                if let value = self.goneInfo.heightGoneValue {
                    view.frame.size.height = value
                }
            }
            else if isHeight {
                if let value = self.goneInfo.heightGoneValue {
                    height = value
                }
                else {
                    height = heightDefault
                }
            }
        }
        if type.contains(.leading) {
            if isLeading {
                if let value = self.goneInfo.leadingGoneValue {
                    leading = value
                }
                else {
                    leading = leadingDefault
                }
            }
        }
        if type.contains(.trailing) {
            if isTrailing {
                if let value = self.goneInfo.trailingGoneValue {
                    trailing = value
                }
                else {
                    trailing = trailingDefault
                }
            }
        }
        if type.contains(.top) {
            if isTop {
                if let value = self.goneInfo.topGoneValue {
                    top = value
                }
                else {
                    top = topDefault
                }
            }
        }
        if type.contains(.bottom) {
            if isBottom {
                if let value = self.goneInfo.bottomGoneValue {
                    bottom = value
                }
                else {
                    bottom = bottomDefault
                }
            }
        }

        view.setNeedsLayout()
    }
}

// MARK: - Make Constraints
@MainActor
extension EasyConstraints {
    @MainActor
    public struct ECMakeAnchor {
        private weak var view: UIView?

        init(view: UIView?) {
            view?.translatesAutoresizingMaskIntoConstraints = false
            self.view = view
        }

        @discardableResult
        public func leading(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat) -> Self {
            view?.leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func trailing(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat) -> Self {
            view?.trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func left(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat) -> Self {
            view?.leftAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func right(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat) -> Self {
            view?.rightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func top(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat) -> Self {
            view?.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func bottom(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat) -> Self {
            view?.bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func centerX(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat) -> Self {
            view?.centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func centerY(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat) -> Self {
            view?.centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func firstBaseline(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat) -> Self {
            view?.firstBaselineAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func lastBaseline(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat) -> Self {
            view?.lastBaselineAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func width(_ width: CGFloat) -> Self {
            view?.widthAnchor.constraint(equalToConstant: width).isActive = true
            return self
        }

        @discardableResult
        public func height(_ height: CGFloat) -> Self {
            view?.heightAnchor.constraint(equalToConstant: height).isActive = true
            return self
        }

        @discardableResult
        public func widthAnchor(_ anchor: NSLayoutDimension, multiplier: CGFloat) -> Self {
            view?.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
            return self
        }

        @discardableResult
        public func heightAnchor(_ anchor: NSLayoutDimension, multiplier: CGFloat) -> Self {
            view?.heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
            return self
        }
    }

    public func make() -> ECMakeAnchor {
        return ECMakeAnchor(view: self.view)
    }
}

// MARK: - UIView Extension EasyConstraints
extension UIView {
    private struct EasyConstraintsKey {
        nonisolated(unsafe) static var easyConstraints: UInt8 = 0
    }

    public var ec: EasyConstraints {
        return easyConstraints
    }

    private var easyConstraints: EasyConstraints {
        get {
            if let info = objc_getAssociatedObject(self, &EasyConstraintsKey.easyConstraints) as? EasyConstraints {
                return info
            }
            let info = EasyConstraints(view: self)
            objc_setAssociatedObject(self, &EasyConstraintsKey.easyConstraints, info, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return info
        }
        set {
            objc_setAssociatedObject(self, &EasyConstraintsKey.easyConstraints, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public func addSubViewAutoLayout(_ subview: UIView, edgeInsets: UIEdgeInsets = .zero) {
        self.addSubview(subview)
        self.setSubViewAutoLayout(subview, edgeInsets: edgeInsets)
    }

    public func addSubViewAutoLayout(insertView: UIView, subview: UIView, edgeInsets: UIEdgeInsets = .zero, isFront: Bool) {
        if isFront {
            self.insertSubview(insertView, belowSubview: subview)
        }
        else {
            self.insertSubview(insertView, aboveSubview: subview)
        }
        self.setSubViewAutoLayout(insertView, edgeInsets: edgeInsets)
    }

    private func setSubViewAutoLayout(_ subview: UIView, edgeInsets: UIEdgeInsets) {
        subview.translatesAutoresizingMaskIntoConstraints = false

        let views: Dictionary = ["subview": subview]
        let edgeInsetsDic: Dictionary = [
            "top": (edgeInsets.top),
            "left": (edgeInsets.left),
            "bottom": (edgeInsets.bottom),
            "right": (edgeInsets.right)
        ]

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(left)-[subview]-(right)-|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: edgeInsetsDic,
                                                           views: views))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(top)-[subview]-(bottom)-|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: edgeInsetsDic,
                                                           views: views))
    }

    public func addSubViewAutoLayout(subviews: [UIView],
                                     addType: VIEW_ADD_TYPE,
                                     edgeInsets: UIEdgeInsets = .zero,
                                     itemSpacing: CGFloat = 0.0,
                                     equally: Bool = true) {
        guard !subviews.isEmpty else { return }

        subviews.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        if addType == .horizontal {
            if equally {
                for i in 1..<subviews.count {
                    NSLayoutConstraint.activate([
                        subviews[i].widthAnchor.constraint(equalTo: subviews.first!.widthAnchor)])
                }
            }

            NSLayoutConstraint.activate([
                subviews[0].topAnchor.constraint(equalTo: self.topAnchor, constant: edgeInsets.top),
                subviews[0].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeInsets.left),
                subviews[0].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -edgeInsets.bottom),
            ])

            for i in 1..<subviews.count {
                NSLayoutConstraint.activate([
                    subviews[i].leadingAnchor.constraint(equalTo: subviews[i-1].trailingAnchor, constant: itemSpacing),
                    subviews[i].topAnchor.constraint(equalTo: self.topAnchor, constant: edgeInsets.top),
                    subviews[i].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -edgeInsets.bottom)
                ])
            }

            NSLayoutConstraint.activate([
                subviews.last!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -edgeInsets.right)
            ])
        }
        else {
            if equally {
                for i in 1..<subviews.count {
                    NSLayoutConstraint.activate([
                        subviews[i].heightAnchor.constraint(equalTo: subviews.first!.heightAnchor)])
                }
            }

            NSLayoutConstraint.activate([
                subviews[0].topAnchor.constraint(equalTo: self.topAnchor, constant: edgeInsets.top),
                subviews[0].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeInsets.left),
                subviews[0].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -edgeInsets.right),
            ])

            for i in 1..<subviews.count {
                NSLayoutConstraint.activate([
                    subviews[i].topAnchor.constraint(equalTo: subviews[i-1].bottomAnchor, constant: itemSpacing),
                    subviews[i].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeInsets.left),
                    subviews[i].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -edgeInsets.right)
                ])
            }

            NSLayoutConstraint.activate([
                subviews.last!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -edgeInsets.bottom)
            ])
        }
    }

    public func removeSuperViewAllConstraints() {
        guard let superview: UIView = self.superview else { return }

        for c: NSLayoutConstraint in superview.constraints {
            if c.firstItem === self || c.secondItem === self {
                superview.removeConstraint(c)
            }
        }
    }

    public func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        guard let superview: UIView = self.superview else { return }

        for c: NSLayoutConstraint in superview.constraints {
            if c.firstItem === self && c.firstAttribute == attribute {
                superview.removeConstraint(c)
            }
            else if c.secondItem === self && c.secondAttribute == attribute {
                superview.removeConstraint(c)
            }
        }
    }

    public func removeAllConstraints() {
        self.removeSuperViewAllConstraints()
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }

    public func addSubViewSafeArea(subView: UIView, insets: UIEdgeInsets = .zero, safeBottom: Bool = true) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subView)

        if safeBottom {
            NSLayoutConstraint.activate([
                self.safeLeftAnchor.constraint(equalTo: subView.leftAnchor, constant: -insets.left),
                self.safeRightAnchor.constraint(equalTo: subView.rightAnchor, constant: insets.right),
                self.safeTopAnchor.constraint(equalTo: subView.topAnchor, constant: -insets.top),
                self.safeBottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: insets.bottom)
            ])
        }
        else {
            NSLayoutConstraint.activate([
                self.safeLeftAnchor.constraint(equalTo: subView.leftAnchor, constant: -insets.left),
                self.safeRightAnchor.constraint(equalTo: subView.rightAnchor, constant: insets.right),
                self.safeTopAnchor.constraint(equalTo: subView.topAnchor, constant: -insets.top),
                self.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: insets.bottom)
            ])
        }

    }
}

extension UIView {
    public var topParentViewView: UIView {
        guard let superview: UIView = superview else {
            return  self
        }
        return superview.topParentViewView
    }

    @discardableResult
    public func addSuperView(_ superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
}

// MARK: - UIView Extension SafeArea
extension UIView {
    public var safeTopAnchor: NSLayoutYAxisAnchor {
        return self.safeAreaLayoutGuide.topAnchor
    }

    public var safeLeftAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.leftAnchor
    }

    public var safeLeadingAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.leadingAnchor
    }

    public var safeRightAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.rightAnchor
    }

    public var safeTrailingAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.trailingAnchor
    }

    public var safeBottomAnchor: NSLayoutYAxisAnchor {
        return self.safeAreaLayoutGuide.bottomAnchor
    }
}

#endif


