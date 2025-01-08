//
//  EasyConstrains+Gone.swift
//  EasyConstraints
//
//  Created by 박길호(파트너) - 서비스개발담당App개발팀 on 12/23/24.
//

import UIKit

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

extension EasyConstraints {
    class GoneInfo {
        var widthEmptyConstraint: NSLayoutConstraint?
        var heightEmptyConstraint: NSLayoutConstraint?
        var widthGoneValue: CGFloat?
        var heightGoneValue: CGFloat?
        var topGoneValue: CGFloat?
        var leadingGoneValue: CGFloat?
        var bottomGoneValue: CGFloat?
        var trailingGoneValue: CGFloat?
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

