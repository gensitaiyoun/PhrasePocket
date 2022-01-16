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
    
    @IBOutlet var contentTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let memo: Phrase? = read()
        
        if let memo = memo {
            contentTextField.text = memo.content
            typeTextField.text = memo.type
            
        }
    }
    func read() -> Phrase? {
        return realm.objects(Phrase.self).first
    }
    
    @IBAction func save() {
        let content: String = contentTextField.text!
        let type: String = typeTextField.text!
    
        let memo: Phrase? = read()
    
        if memo != nil {
             try! realm.write{
                 memo!.content = content
                 memo!.type = content
             }
        } else {
             let newMemo = Phrase()
             newMemo.content = content
            newMemo.type = type
            
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
