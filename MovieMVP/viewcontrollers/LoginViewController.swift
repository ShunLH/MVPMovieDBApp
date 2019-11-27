//
//  LoginViewController.swift
//  MovieMVP
//
//  Created by AcePlus Admin on 11/26/19.
//  Copyright © 2019 SLH. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	
	@IBOutlet weak var tfUsername : UITextField!
	@IBOutlet weak var tfpassword : UITextField!
	@IBOutlet weak var btnLogin : UIButton!
	
	let mPresenter : LoginPresenterImpl = LoginPresenterImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
		btnLogin.layer.cornerRadius = 5
		btnLogin.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		btnLogin.layer.borderWidth = 1
		tfUsername.delegate = self
		tfpassword.delegate = self
		tfUsername.text = "ShunLeiHmu"
		tfpassword.text = "shunlhshunlh"
		mPresenter.onUIReady()
		mPresenter.attachView(view: self)
		print ("subviews\(self.view.subviews.count)")
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let sessionId = UserDefaults.standard.string(forKey: DEFAULT_SESSION_ID){
			print("session id \(sessionId)")
			self.tabBarController?.selectedIndex = 1
		}
	}
	@IBAction func clickOnLogin(_ sender: Any) {
		let username = self.tfUsername.text ?? ""
		let password = self.tfpassword.text ?? ""
		mPresenter.onClickLoginBtn(username: username, password: password)
	}
	

}
extension LoginViewController : UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		view.endEditing(true)
	}
}

extension LoginViewController : LoginView {
	
	func displayLoading() {
		showIndicatior("Loading...")
	}
	
	func showProfileView() {
		self.tabBarController?.selectedIndex = 1
	}
	
	
}
