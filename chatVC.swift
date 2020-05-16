//
//  chatVC.swift
//  practiceMessenger
//
//  Created by Amanda Burger on 5/12/20.
//  Copyright © 2020 Amanda Burger. All rights reserved.
//
import Foundation
import UIKit
import Firebase
class chatVC: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
    var messageArr : [message] = [message]()
  
    @IBOutlet weak var heightCont: NSLayoutConstraint!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTF: UITextField!
  
    @IBOutlet weak var messageTabView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        messageTabView.delegate = self
        messageTabView.dataSource = self
        messageTF.delegate = self
        // Do any additional setup after loading the view.
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTabView.addGestureRecognizer(tapGest)
        
        messageTabView.register(UINib(nibName: "cuCell", bundle: nil), forCellReuseIdentifier: "customTVCell")
        
        
        configureTableView()
        retMess()
        messageTabView.separatorStyle = .none
    }
    @IBAction func sendPressed(_ sender: Any) {
        messageTF.endEditing(true)
        messageTF.isEnabled = false
        sendButton.isEnabled = false
        
        let messageDB = Database.database().reference().child("Messages")
        let messageDict = ["Sender": Auth.auth().currentUser?.email,
                           "MessageBody": messageTF.text!]
        messageDB.childByAutoId().setValue(messageDict){
            (error, reference) in
            if error != nil{
                print(error!)
            }
            else{
                print("messageSaved")
                self.messageTF.isEnabled = true
                self.sendButton.isEnabled = true
            }
            
            
        }
        
    }
    func retMess(){
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapVal = snapshot.value as! Dictionary<String,String>
            let text = snapVal["MessageBody"]!
            let sender = snapVal["Sender"]!
            print(text, sender)
            
            let mess = message()
            mess.messageBody = text
            mess.sender = sender
            self.messageArr.append(mess)
            self.configureTableView()
            self.messageTabView.reloadData()
        }
    }
    @IBAction func logoutPressed(_ sender: Any) {
        
        do{
            
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
            self.performSegue(withIdentifier: "logout", sender: self)
            print("success")
            
        }
        catch{
            print("error")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTVCell", for: indexPath) as! cuCell
        
        cell.messageLabel.text = messageArr[indexPath.row].messageBody
        cell.senderLabel.text = messageArr[indexPath.row].sender
        //cell.imageView?.image = UIImage(named: "amanda")
        if cell.senderLabel.text == "a@b.com"{
            cell.imageView?.image = UIImage(named: "amanda")
        }
        else if cell.senderLabel.text == "c@d.com"{
            cell.imageView?.image = UIImage(named: "steve")
            
        }
        else{
            cell.imageView?.image = UIImage(named: "unknown")
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    @objc func tableViewTapped (){
        messageTF.endEditing(true)
        
    }
    func configureTableView(){
       
        messageTabView.rowHeight = UITableView.automaticDimension
        messageTabView.estimatedRowHeight = 150
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5){
            self.heightCont.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightCont.constant = 53
            self.view.layoutIfNeeded()
        }
        
        
    }
    
}
