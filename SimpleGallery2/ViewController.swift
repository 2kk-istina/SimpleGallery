//
//  ViewController.swift
//  SimpleGallery2
//
//  Created by Истина on 23/04/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var backgroundImage: UIView!
    var myImageView = UIImageView()
    
    var galleryLabel = UILabel()
    var loginLabel = UILabel()
    
    var googleButton = UIButton()
    var fbButton = UIButton()
    var emailButton = UIButton()
    var continueButton = UIButton()
    
    var buttonStack = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GalleryLabel
        galleryLabel.frame = CGRect(x: 0, y: 0, width: 90, height: 100)
        galleryLabel.translatesAutoresizingMaskIntoConstraints = false
        galleryLabel.text =
        """
        Simple
        Gallery
        """
        galleryLabel.numberOfLines = 0
        galleryLabel.textAlignment = NSTextAlignment.center
        galleryLabel.font = UIFont.boldSystemFont(ofSize: 55)
        galleryLabel.textColor = UIColor.white
        galleryLabel.center = self.view.center
        self.view.addSubview(galleryLabel)
        
        NSLayoutConstraint.activate([
            galleryLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            galleryLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -130)
            ])
        
        //LoginLabel
        loginLabel.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "Log in to see more"
        loginLabel.numberOfLines = 0
        loginLabel.textAlignment = NSTextAlignment.center
        loginLabel.font = UIFont(name: "ArialHebrew-Bold", size: 20)
        loginLabel.textColor = UIColor.white
        loginLabel.center = self.view.center
        self.view.addSubview(loginLabel)
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -45)
            ])

        
        //CreateButtons
        CreateButtons(buttons: googleButton, background: "Google", title: "Sign in with", nameOfPicture: "Google", constraint: 5)
        CreateButtons(buttons: fbButton, background: "FB", title: "Sign in with", nameOfPicture: "FB", constraint: 85)
        CreateButtons(buttons: emailButton, background: "Email", title: "Sign in with", nameOfPicture: "Email", constraint: 160)
        CreateButtons(buttons: continueButton, background: "Continue", title: "Without logging in", nameOfPicture: "imgonline-com-ua-Resize-Vogh8dBmhvjzq", constraint: 200)
    
        //StackView
        buttonStack.axis = .vertical
        buttonStack.backgroundColor = UIColor.black
        buttonStack.distribution = .equalSpacing
        buttonStack.alignment = .center
        buttonStack.spacing = 5
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: CGFloat(80))
           ])
    }
    @objc func buttonClicked(sender: UIButton){
        performSegue(withIdentifier: "showGallery", sender: self)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

        func CreateButtons(buttons: UIButton, background: String, title: String, nameOfPicture: String, constraint: Int){
        
        let background = UIImage(named: nameOfPicture)
        let buttons = UIButton(type: .system)
        buttons.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        buttons.translatesAutoresizingMaskIntoConstraints = true
        buttons.setTitle(title, for: .normal)
        buttons.titleLabel?.font = UIFont(name: "Palatino", size: 18)
        buttons.titleEdgeInsets = UIEdgeInsets(top: 0, left: -80, bottom: 0, right: 0)
        buttons.setBackgroundImage(background, for: .normal)
        buttons.tintColor = UIColor.black
        buttons.alpha = 0.85
        buttons.center = self.view.center
            
           if nameOfPicture == "imgonline-com-ua-Resize-Vogh8dBmhvjzq"{
                buttons.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
            }
            
        self.view.addSubview(buttons)
        
        buttonStack.addArrangedSubview(buttons)
        
    }
    
}


