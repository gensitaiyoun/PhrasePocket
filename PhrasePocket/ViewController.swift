//
//  ViewController.swift
//  PhrasePocket
//
//  Created by 森 仁奈 on 2021/12/12.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    let realm = try! Realm()
    
    @IBOutlet var contentTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var tableview: UITableView!
    var phraseList: [Phrase] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        phraseList = realm.objects(Phrase.self).map { $0 }
        
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
        let new = Phrase()
    
        new.content = content
        new.type = type
        try! realm.write{
            realm.add(new)
        }
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
        phraseList = realm.objects(Phrase.self).map { $0 }
        tableview.reloadData()
        let alert: UIAlertController = UIAlertController (title: "成功", message: "保存しました", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title:"OK",style: .default,handler: nil)
        )
        present(alert, animated: true,completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phraseList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        
        cell.textLabel?.text = phraseList[indexPath.row].content +  "      \(phraseList[indexPath.row].type)"
        cell.detailTextLabel?.text = phraseList[indexPath.row].type
        
        return cell
    }
    
}


