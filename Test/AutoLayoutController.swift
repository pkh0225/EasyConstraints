//
//  AutoLayoutController.swift
//  Test
//
//  Created by pkh on 2018. 8. 14..
//  Copyright © 2018년 pkh. All rights reserved.
//

import UIKit

class AutoLayoutController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var textField6: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultConstrains()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setDefaultConstrains()  {
        textField1.text = "\(view1.leadingDefaultConstraint)"
        textField2.text = "\(view1.trailingDefaultConstraint)"
        textField3.text = "\(view2.topDefaultConstraint)"
        textField4.text = "\(view2.trailingDefaultConstraint)"
        textField5.text = "\(view2.widthDefaultConstraint)"
        textField6.text = "\(view2.heightDefaultConstraint)"
        
        
        view1.leadingConstraint = view1.leadingDefaultConstraint
        view1.trailingConstraint = view1.trailingDefaultConstraint
        view2.topConstraint = view2.topDefaultConstraint
        view2.trailingConstraint =  view2.trailingDefaultConstraint
        view2.widthConstraint = view2.widthDefaultConstraint
        view2.heightConstraint = view2.heightDefaultConstraint
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onView1Leading(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view1.leadingConstraint = value
        }
    }
    
    @IBAction func onView1Trailing(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view1.trailingConstraint = value
        }
    }
    
    @IBAction func onView2Top(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view2.topConstraint = value
        }
    }
    
    @IBAction func onView2Trailing(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view2.topConstraint = value
        }
    }
    
    @IBAction func onView2Width(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view2.widthConstraint = value
        }
    }
    
    @IBAction func onView2Height(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view2.heightConstraint = value
        }
    }
    
    @IBAction func onDefaultContraints(_ sender: Any) {
        setDefaultConstrains()
    }
    @IBAction func onGone(_ sender: UIButton) {
        view3.gone = !view3.gone
        if view3.gone {
            sender.setTitle("No gone", for: .normal)
        }
        else {
            sender.setTitle("gone", for: .normal)
        }
        
    }
}

extension String {
    public func toCGFloat() -> CGFloat {
        if let num = NumberFormatter().number(from: self) {
            return CGFloat(num.floatValue)
        }
        else {
            return 0
        }
    }
}
