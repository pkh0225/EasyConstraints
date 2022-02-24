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
        textField1.text = "\(view1.ea.leadingDefault)"
        textField2.text = "\(view1.ea.trailingDefault)"
        textField3.text = "\(view2.ea.topDefault)"
        textField4.text = "\(view2.ea.trailingDefault)"
        textField5.text = "\(view2.ea.widthDefault)"
        textField6.text = "\(view2.ea.heightDefault)"
        
        
        view1.ea.reset(.leading, .trailing)
        view2.ea.reset(.top, .trailing, .width, .height)
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
            view1.ea.leading(value)
        }
    }
    
    @IBAction func onView1Trailing(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view1.ea.trailing = value
        }
    }
    
    @IBAction func onView2Top(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view2.ea.top = value
        }
    }
    
    @IBAction func onView2Trailing(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view2.ea.trailing = value
        }
    }
    
    @IBAction func onView2Width(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view2.ea.width = value
        }
    }
    
    @IBAction func onView2Height(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view2.ea.height = value
        }
    }
    
    @IBAction func onDefaultContraints(_ sender: Any) {
        setDefaultConstrains()
    }
    
    @IBAction func onGone(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        view3.ea.gone = sender.isSelected
        
        if sender.isSelected {
            sender.setTitle("No Gone", for: .normal)
        }
        else {
            sender.setTitle("Gone", for: .normal)
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
