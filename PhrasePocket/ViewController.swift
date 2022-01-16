//
//  ViewController.swift
//  PhrasePocket
//
//  Created by 森 仁奈 on 2021/12/12.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    let realm = try! Realm()
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let memo: PhrasePocket? = read()
        
        if let memo = memo {
            titleTextField.text = memo.title
            contentTextField.text = memo.content
            
        }
    }
    func read() -> PhrasePocket? {
        return realm.objects(PhrasePocket.self).first
    }
    
    @IBAction func save() {
        let title: String = titleTextField.text!
        let content: String = contentTextField.text!
    
        let memo: PhrasePocket? = read()
    
        if memo != nil {
             try! realm.write{
                 memo!.title=title
                 memo!.content = content
             }
        } else {
             let newMemo = PhrasePocket()
             newMemo.title = title
             newMemo.content = content
            
             try! realm.write{
                realm.add(newMemo)
             }
        }
        let alert: UIAlertController = UIAlertController (title: "成功", message: "保存しました", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title:"OK",style: .default,handler: nil)
        )
        present(alert, animated: true,completion: nil)
    }
}
