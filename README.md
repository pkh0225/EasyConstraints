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
```


<br>

![SampleTestApp](https://github.com/pkh0225/EasyConstraints/tree/master/Images/Sample.png)
### ↑↑ please refer test sample project 👾👾


<br>

## USE like this


```
view.leadingConstraint = value // get AutoLayout Contraint value
let value = view.leadingConstraint // set AutoLayout Contraint value

let defaultValue = view.widthDefaultConstraint // first set AutoLayout value

view.isGone = true // Android view gone function


view.viewDidDisappear = {
    print("viewDidDisappear ")
}

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
public func getConstraint(_ layoutAttribute: NSLayoutAttribute, toTaget: UIView) -> NSLayoutConstraint? {
        let constraints = self.getLayoutAllConstraints(layoutAttribute)
        let result = constraints.filter { (value) -> Bool in
            return value.firstItem === toTaget || value.secondItem === toTaget
        }
        
        return result.first
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

```
