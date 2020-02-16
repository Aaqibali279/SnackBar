//
//  ViewController.swift
//  Snackbar
//
//  Created by Aqib Ali on 16/02/20.
//  Copyright © 2020 Aqib Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func messageAction(_ sender: Any) {
        showSnackBar(message: "Message chnaged in the SnackBar!")
    }
    
    @IBAction func show(_ sender: Any) {
        showSnackBar(message: "Hello this is the SnackBar!",action: {
            print("DONE ACTION")
            self.view.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        })
    }
    
    
    
    
}






extension UIViewController{
    
    static var isSnackBarShown = false
    
    func showSnackBar(message:String?,action:(()->())? = nil){
        guard let window = UIApplication.shared.windows.last else {return}
        guard !UIViewController.isSnackBarShown else {
            if let snackBarView = window.viewWithTag(943210) as? SnackBarView{
                snackBarView.message = message
                snackBarView.action = action
            }
            return
        }
        UIViewController.isSnackBarShown = true
        
        let snackBarView = SnackBarView(message: message)
        
        window.addSubview(snackBarView)
        
        snackBarView.leadingAnchor.constraint(equalTo: window.leadingAnchor,constant: 0).isActive = true
        snackBarView.trailingAnchor.constraint(equalTo: window.trailingAnchor,constant: 0).isActive = true
        snackBarView.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor,constant: 0).isActive = true
        
        
        snackBarView.showSnackBar(action:action)
        
        
    }
    
}











