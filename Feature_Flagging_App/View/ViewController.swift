//
//  ViewController.swift
//  Feature_Flagging_App
//
//  Created by Neosoft on 18/09/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var capitalNicknameLabel: UILabel!
    
    
    lazy var presenter =  FeatureFlagManager(with: self, nicknames: nicknames)
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
    }
    
    //MARK: Viewcontroller Setup UI method
    
    func setupUI(){
        enterButton.isEnabled = false
        nicknameLabel.isHidden = true
        capitalNicknameLabel.isHidden = true
        usernameTextField.delegate = self
    }
    
    
    
    @IBAction func enterButtonClicked(_ sender: UIButton) {
        self.updateUI()
    }
}


//MARK: Textfield delegate method
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let newLength = newText.count
        // Enable the button if the text length is at least 4 characters, otherwise disable it
        enterButton.isEnabled = (newLength >= 4)
        return true
    }
}


//MARK: Presenter view
extension ViewController: PresenterView {
    func updateUI() {
        let nicknameGenerator = FeatureFlagManager(with: self, nicknames: nicknames)
       if let username = usernameTextField.text {
            if let (originalNickname, uppercaseNickname) = nicknameGenerator.generateNickname(for: username, from: nicknames) {
                nicknameLabel.isHidden = false
                usernameTextField.text = nil
                enterButton.isEnabled = false
                nicknameLabel.text = "Your nickname is:  \(originalNickname)"
                capitalNicknameLabel.isHidden = false
                capitalNicknameLabel.text = uppercaseNickname
            }
        }
    }
}
