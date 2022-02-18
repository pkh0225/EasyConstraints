# Easy AutoLayout - UIView Extension

## 🎊 No more @IBOutlets
🕵🏻‍♂️ With this extension, now you don't have to @IBOulet from your storyboard to get constraints.

### Get & Set Constraints - as you wish

> widthConstraint, heightConstraint, topConstraint, leadingConstraint, bottomConstraint,  trailingConstraint, centerXConstraint, centerYConstraint

### Get Default Constraints - constraints that you first set in SB

> widthDefaultConstraint, heightDefaultConstraint, topDefaultConstraint, leadingDefaultConstraint, bottomDefaultConstraint, trailingDefaultConstraint, centerXDefaultConstraint, centerYDefaultConstraint



#### + 🤧😆 view gone functions (Android mimic ver.)

> isGone, isGoneWidth, isGoneHeight

#### + 👻👻 viewDidDisappear Timer

```
    public var viewDidDisappear: VoidClosure? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.viewDidDisappear) as? VoidClosure
        }
        set {
            objc_setAssociatedObject ( self, &AssociatedKeys.viewDidDisappear, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            viewDidDisappearCADisplayLink?.invalidate()
            if newValue != nil {
                viewDidDisappearCADisplayLink = CADisplayLink(target: self, selector: #selector(onViewDidDisappear))
                viewDidDisappearCADisplayLink?.add(to: .current, forMode: .common)
                if #available(iOS 10.0, *) {
                    viewDidDisappearCADisplayLink?.preferredFramesPerSecond = 5
                } else {
                    viewDidDisappearCADisplayLink?.frameInterval = 5
                }
            }
            else {
                viewDidDisappearCADisplayLink = nil
            }
        }
    }
```


<br>

![SampleTestApp](https://github.com/pkh0225/EasyConstraints/blob/master/Images/Sample.png)
### ↑↑ please refer test sample project 👾👾


<br>

## USE like this


```
view.ea.leading = value // set AutoLayout Constraint value
view.ea.leading(10).top(10).trailing(10).bottom(10) // set AutoLayout Constraint value

let value = view.ea.leading // get AutoLayout Constraint value

let defaultValue = view.ea.widthDefault // first set AutoLayout Constraint value

view.ea.isGone = true // Android view gone function

view.ea.reset(.top, .trailing, .width, .height) // set Default Constraint Value

view.viewDidDisappear = {
    print("viewDidDisappear ")
}

```

<br>
<br>


## Core Functions

### 👀 Check view is visible or not 
```
 public var isShow: Bool {
        
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
```

### 👉🏻 get Constraints

```
    @inline(__always) private func getAttributeConstrains(constraints: Set<NSLayoutConstraint>, layoutAttribute: NSLayoutConstraint.Attribute) -> Array<NSLayoutConstraint> {
        var constraintsTemp = Array<NSLayoutConstraint>()
        constraintsTemp.reserveCapacity(100)
        for constraint in constraints {

            switch layoutAttribute {
            case .width, .height:
                if type(of:constraint) === NSLayoutConstraint.self {
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
                if constraint.firstAttribute == layoutAttribute  && constraint.secondAttribute == layoutAttribute {
                    if (constraint.firstItem === self.view && (constraint.secondItem === self.view.superview || constraint.secondItem is UILayoutGuide)) ||
                        (constraint.secondItem === self.view && (constraint.firstItem === self.view.superview || constraint.firstItem is UILayoutGuide)) {
                        constraintsTemp.append(constraint)
                    }
                    else if constraint.firstItem === self.view || constraint.secondItem === self.view {
                        constraintsTemp.append(constraint)
                    }
                }
            case .top :
                if  constraint.firstItem === self.view && constraint.firstAttribute == .top  && constraint.secondAttribute == .bottom {
                    constraintsTemp.append(constraint)
                }
                else if  constraint.secondItem === self.view && constraint.secondAttribute == .top  && constraint.firstAttribute == .bottom {
                    constraintsTemp.append(constraint)
                }
                else if constraint.firstAttribute == .top  && constraint.secondAttribute == .top {
                    if (constraint.firstItem === self.view && constraint.secondItem === self.view.superview ) ||
                        (constraint.secondItem === self.view && constraint.firstItem === self.view.superview ) {
                        constraintsTemp.append(constraint)
                    }
                    else {
                        if (constraint.firstItem === self.view && constraint.secondItem is UILayoutGuide) ||
                            (constraint.secondItem === self.view &&  constraint.firstItem is UILayoutGuide) {
                            constraintsTemp.append(constraint)
                        }
                        else if constraint.firstItem === self.view || constraint.secondItem === self.view {
                            constraintsTemp.append(constraint)
                        }
                    }
                }
            case .bottom :
                if  constraint.firstItem === self.view && constraint.firstAttribute == .bottom  && constraint.secondAttribute == .top {
                    constraintsTemp.append(constraint)
                }
                else if  constraint.secondItem === self.view && constraint.secondAttribute == .bottom  && constraint.firstAttribute == .top {
                    constraintsTemp.append(constraint)
                }
                else if constraint.firstAttribute == .bottom  && constraint.secondAttribute == .bottom {
                    if (constraint.firstItem === self.view && constraint.secondItem === self.view.superview ) ||
                        (constraint.secondItem === self.view && constraint.firstItem === self.view.superview ) {
                        constraintsTemp.append(constraint)
                    }
                    else  {
                        if (constraint.firstItem === self.view && constraint.secondItem is UILayoutGuide) ||
                            (constraint.secondItem === self.view &&  constraint.firstItem is UILayoutGuide) {
                            constraintsTemp.append(constraint)
                        }
                        else if constraint.firstItem === self.view || constraint.secondItem === self.view {
                            constraintsTemp.append(constraint)
                        }
                    }
                }
            case .leading :
                if  constraint.firstItem === self.view && constraint.firstAttribute == .leading  && constraint.secondAttribute == .trailing {
                    constraintsTemp.append(constraint)
                }
                else if  constraint.secondItem === self.view && constraint.secondAttribute == .leading  && constraint.firstAttribute == .trailing {
                    constraintsTemp.append(constraint)
                }
                else if constraint.firstAttribute == .leading  && constraint.secondAttribute == .leading {
                    if (constraint.firstItem === self.view && constraint.secondItem === self.view.superview ) ||
                        (constraint.secondItem === self.view && constraint.firstItem === self.view.superview ) {
                        constraintsTemp.append(constraint)
                    }
                    else  {
                        if (constraint.firstItem === self.view && constraint.secondItem is UILayoutGuide) ||
                            (constraint.secondItem === self.view &&  constraint.firstItem is UILayoutGuide) {
                            constraintsTemp.append(constraint)
                        }
                        else if constraint.firstItem === self.view || constraint.secondItem === self.view {
                            constraintsTemp.append(constraint)
                        }
                    }
                }
            case .trailing :
                if  constraint.firstItem === self.view && constraint.firstAttribute == .trailing  && constraint.secondAttribute == .leading {
                    constraintsTemp.append(constraint)
                }
                else if  constraint.secondItem === self.view && constraint.secondAttribute == .trailing  && constraint.firstAttribute == .leading {
                    constraintsTemp.append(constraint)
                }
                else if constraint.firstAttribute == .trailing  && constraint.secondAttribute == .trailing {
                    if (constraint.firstItem === self.view && constraint.secondItem === self.view.superview ) ||
                        (constraint.secondItem === self.view && constraint.firstItem === self.view.superview ) {
                        constraintsTemp.append(constraint)
                    }
                    else {
                        if (constraint.firstItem === self.view && constraint.secondItem is UILayoutGuide) ||
                            (constraint.secondItem === self.view &&  constraint.firstItem is UILayoutGuide) {
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

```
