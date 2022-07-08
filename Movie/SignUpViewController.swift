//
//  SignUpViewController.swift
//  Movie
//
//  Created by 신동희 on 2022/07/06.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - Propertys
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var recommendCodeTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var additionalInfoSwift: UISwitch!
    
    private let placeHolders: [String] = ["이메일주소 또는 전화번호", "비밀번호", "닉네임", "위치", "추천 코드 입력"]
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    
    // MARK: - Methods
    func setupUI() {
        
        for (textField, placeHolder) in zip(textFields, placeHolders) {
            // PlaceHolder 글자 색 변경
            textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            
            settingTextFieldUI(textField)
        }
        
        passwordTextField.isSecureTextEntry = true
        
        recommendCodeTextField.keyboardType = .numberPad
        recommendCodeTextField.delegate = self
        
        settingButtonUI(signUpButton)
        
        settingUISwitch(additionalInfoSwift)
    }
    
    
    func settingTextFieldUI(_ textField: UITextField) {
        textField.textAlignment = .center
        textField.backgroundColor = .darkGray
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.clipsToBounds = true
        textField.layer.cornerRadius = textField.frame.height / 5
    }
    
    
    func settingButtonUI(_ button: UIButton) {
        button.clipsToBounds = true
        button.layer.cornerRadius = button.frame.height / 5
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemPink, for: .highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        
    }
    
    
    func settingUISwitch(_ toggle: UISwitch) {
        toggle.setOn(false, animated: true)
        toggle.onTintColor = .systemPink
        toggle.thumbTintColor = .white
        
        toggle.backgroundColor = .lightGray
        toggle.clipsToBounds = true
        toggle.layer.cornerRadius = toggle.frame.height / 2
    }
    
    
    @IBAction func additionalInfoSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
            recommendCodeTextField.isHidden = false
        }else {
            recommendCodeTextField.isHidden = true
        }
    }
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(alertAction)
        
        self.present(alert, animated: true)
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        view.endEditing(true)

        if idTextField.text == "" || passwordTextField.text == "" || passwordTextField.text!.count < 6 {
            presentAlert(title: "아이디와 비밀번호 입력을 확인해주세요.", message: "아이디와 비밀번호는 필수 입력사항입니다. \n 비밀번호는 6자 이상 입력해야 됩니다.")
        }else if nicknameTextField.text == "" {
            presentAlert(title: "닉네임을 입력해주세요.", message: "닉네임도 필수 입력입니다..")
        }else if locationTextField.text == "" {
            presentAlert(title: "위치도 입력해주세요.", message: "위치도 필수 입력입니다..")
        }else if additionalInfoSwift.isOn && recommendCodeTextField.text == "" {
            presentAlert(title: "추천코드를 입력해주세요.", message: "추천코드가 없다면 추가 정보 입력을 off로 변경해주세요.")
        }else {
            presentAlert(title: "회원가입이 완료되었습니다.", message: "환영합니다.")
            textFields.forEach({
                $0.text = ""
            })
        }
    }
    
}



extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == "" {
            return true
        }else {
            presentBottomAlert(message: "숫자만 입력하세요.")
            return false
        }
    }
    
    
    
    func presentBottomAlert(message: String, target: NSLayoutYAxisAnchor? = nil, offset: Double? = -12) {
        view.subviews
            .filter { $0.tag == 999 }
            .forEach { $0.removeFromSuperview() }
        
        let alertSuperview = UIView()
        alertSuperview.tag = 999
        alertSuperview.backgroundColor = UIColor.white
        alertSuperview.layer.cornerRadius = 10
        alertSuperview.isHidden = true
        alertSuperview.translatesAutoresizingMaskIntoConstraints = false
    
        let alertLabel = UILabel()
        alertLabel.textColor = .black
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(alertSuperview)
        alertSuperview.bottomAnchor.constraint(equalTo: target ?? view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
        alertSuperview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertSuperview.addSubview(alertLabel)
        alertLabel.topAnchor.constraint(equalTo: alertSuperview.topAnchor, constant: 6).isActive = true
        alertLabel.bottomAnchor.constraint(equalTo: alertSuperview.bottomAnchor, constant: -6).isActive = true
        alertLabel.leadingAnchor.constraint(equalTo: alertSuperview.leadingAnchor, constant: 12).isActive = true
        alertLabel.trailingAnchor.constraint(equalTo: alertSuperview.trailingAnchor, constant: -12).isActive = true
        
        alertLabel.text = message
        alertSuperview.alpha = 1.0
        alertSuperview.isHidden = false
        UIView.animate(
            withDuration: 2.0,
            delay: 1.0,
            options: .curveEaseIn,
            animations: { alertSuperview.alpha = 0 },
            completion: { _ in
                alertSuperview.removeFromSuperview()
            }
        )
    }
}
