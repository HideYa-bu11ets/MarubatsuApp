//
//  QuestionViewController.swift
//  MarubatsuApp
//
//  Created by 沼田英也 on 2023/09/04.
//

import UIKit

class QuestionViewController: UIViewController,UITextFieldDelegate {


    @IBOutlet weak var questionText: UITextField!
    
    @IBOutlet weak var selectAnswer: UISegmentedControl!
    

    var questions: [[String: Any]] = []
    var answer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard

        if userDefaults.object(forKey: "add") != nil {
            questions = userDefaults.object(forKey: "add") as! [[String: Any]]
        
        }
        questionText.delegate = self // テキストフィールドのデリゲートを設定
        
      

        // Do any additional setup after loading the view.
    }
    
    // UITextFieldDelegateメソッド: テキストフィールドが編集モードに入る直前に呼ばれる
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // テキストを空に設定
        textField.text = ""
        
        // テキストの色を黒に設定
        textField.textColor = UIColor.black
        
        // 編集を許可
        return true
    }
    
    

    @IBAction func selectAnswer(_ sender: UISegmentedControl) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            answer = false
        case 1:
            answer = true
        default:
            break
        }
    }
    @IBAction func topButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAnswer(_ sender: UIButton) {
        if questionText.text != "" {
            if let newText = questionText.text {
                var newQuestions: [String: Any] = [:]
                newQuestions["question"] = newText
                newQuestions["answer"] = answer
                questions.append(newQuestions)
                questionText.text = ""
                print(questions)
                let userDefaults = UserDefaults.standard
                userDefaults.set(questions, forKey: "add")
            }
        } else {
            showAlert(title: "問題が空です", message: "問題が入力されてません")
        }
    }
    @IBAction func deleteAnswer(_ sender: UIButton) {
        questions = []
        let userDefaults = UserDefaults.standard
        userDefaults.set(questions, forKey: "add")
        showAlert(title: "問題削除！！", message: "問題が削除されました")
        questionText.text = "問題がありません。追加してください。"
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
