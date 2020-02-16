//
//  SnackBarView.swift
//  Snackbar
//
//  Created by Aqib Ali on 16/02/20.
//  Copyright © 2020 Aqib Ali. All rights reserved.
//

import UIKit
class SnackBarView:UIView{
    
    
    private var label = { () -> UILabel in
        let label = UILabel()
        label.numberOfLines = 0
        label.tag = 94321
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private var button = { () -> UIButton in
        let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitle("DONE", for: .normal)
        button.addTarget(self, action:#selector(btnDoneAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }()
    
    var action:(()->())?
    var message:String?{
        didSet{
            label.text = message
        }
    }
    
    init(message:String?){
        super.init(frame: .zero)
        
        tag = 943210
        layer.cornerRadius = 0
        clipsToBounds = true
        backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        translatesAutoresizingMaskIntoConstraints = false
        
        label.text = message
        
        
        let stack = UIStackView(arrangedSubviews: [label,button])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(stack)
        
        stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
    }
    
    
    func showSnackBar(action:(()->())?){
        layoutIfNeeded()
        self.action = action
        let height = frame.height + 100
        transform = CGAffineTransform(translationX: 0, y: height)
        
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.transform = .identity
        }) { (finished) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let _ = self.superview{
                    self.removeSnackBar()
                }
            }
        }
    }
    
    
    private func removeSnackBar(){
        layoutIfNeeded()
        let height = frame.height + 100
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.transform = .init(translationX: 0, y: height)
        }) { (finished) in
            UIViewController.isSnackBarShown = false
            self.layer.removeAllAnimations()
            self.layoutIfNeeded()
            self.removeFromSuperview()
        }
    }
    
    @objc func btnDoneAction(){
        action?()
        removeSnackBar()
    }
    
    deinit {
//        print("Removed",self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
