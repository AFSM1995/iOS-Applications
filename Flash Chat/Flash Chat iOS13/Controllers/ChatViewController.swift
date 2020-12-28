//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    var messageArray: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = Constants.appName
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.hidesBackButton = true
        
        // Register custom cell
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        // Retrive messages from database.
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(Constants.FStore.collectionName)
            // Sorts messages by the dateField variable that we created and is assigned to a message on its conseption.
            .order(by: Constants.FStore.dateField)
            // addSnapshotListener adds a lisiner and reloads all the data on change.
            .addSnapshotListener { (querySnapshot, error) in
            
            // The privious presented data sould be deleted to prevent duplicate messages from showing.
            self.messageArray = []
            
            if let e = error {
                print(e)
            } else {
                if let snapShotDocuments = querySnapshot?.documents {
                    for doc in snapShotDocuments {
                        let data = doc.data()
                        if let senderBody = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String {
                            let newMessage = Message(sender: senderBody, body: messageBody)
                            self.messageArray.append(newMessage)
                            
                            // Good pactice, get hold of main queue since grabbing documents is happening in the background.
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.dateField: Date().timeIntervalSince1970,
                Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: messageBody
            ]) { (error) in
                if let e = error {
                    print(e)
                } else {
                    print("Successfully saved data.")
//                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    // Determin how many rows to make.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    // Populate the rows with information.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messageArray[indexPath.row]
        
        // Cast as custom "MessageCell" we created.
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        cell.message.text = message.body
        
        // Message form the current user.
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.message.textColor = UIColor(named: Constants.BrandColors.purple)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lighBlue)
            cell.message.textColor = UIColor(named: Constants.BrandColors.blue)
        }
        
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    
}
