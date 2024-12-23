# Easy AutoLayout - UIView Extension

[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)

## 🎊 No more @IBOutlets
🕵🏻‍♂️ With this extension, now you don't have to @IBOulet from your storyboard to get constraints.

### Get & Set Constraints - as you wish

> widthConstraint, heightConstraint, topConstraint, leadingConstraint, bottomConstraint,  trailingConstraint, centerXConstraint, centerYConstraint

### Get Default Constraints - constraints that you first set in SB

> widthDefaultConstraint, heightDefaultConstraint, topDefaultConstraint, leadingDefaultConstraint, bottomDefaultConstraint, trailingDefaultConstraint, centerXDefaultConstraint, centerYDefaultConstraint



#### + 🤧😆 view gone functions (Android mimic ver.)

> isGone, isGoneWidth, isGoneHeight

<br>

![SampleTestApp](https://github.com/pkh0225/EasyConstraints/blob/master/Images/Sample.png)
### ↑↑ please refer test sample project 👾👾


<br>

## USE like this


```
// make constraints
let testView = UIView()
testView.backgroundColor = .red
testView.ec
    .addSuperView(self.view)
    .makeConstraints {
        $0.leading = (self.view.leadingAnchor, 0)
        $0.top = (self.view.topAnchor, 0)
    }
            

// set get
view.ea.leading = value // set AutoLayout Constraint value
view.ea.leading(10).top(10).trailing(10).bottom(10) // set AutoLayout Constraint value

let value = view.ec.leading // get AutoLayout Constraint value

let defaultValue = view.ec.widthDefault // first set AutoLayout Constraint value

view.ec.gone = true // Android view gone function

view.ec.reset(.top, .trailing, .width, .height) // set Default Constraint Value


/// make test
let v = UIView()
v.translatesAutoresizingMaskIntoConstraints = false
v.backgroundColor = .red
v.addSuperView(self.view)
    .ec.make()
    .top(view4.topAnchor, 10)
    .leading(view4.leftAnchor, 10)
    .width(50)
    .height(50)
    
```

<br>
<br>


## Core Functions

### 👀 Check view is visible or not 
```
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
