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
    var messageArray: [MessageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.title = Constants.appName
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.hidesBackButton = true
        
        // Register custom cell for use.
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        // Retrive messages from database.
        loadMessages()
    }
    
    func loadMessages() {
        // Target Firebase database named X.
        db.collection(Constants.FStore.collectionName)
            // Sorts messages by the dateField variable that we created and is assigned to a message on its conseption.
            .order(by: Constants.FStore.dateField)
            // addSnapshotListener adds a lisiner and reloads all the data on database change.
            .addSnapshotListener { (querySnapshot, error) in
            
            // The privious presented data sould be deleted to prevent duplicate messages from showing.
            self.messageArray = []
            
            if let e = error {
                print(e)
            } else {
                if let snapShotDocuments = querySnapshot?.documents {
                    // Loop through the database to create meesages and load them on the screen.
                    for doc in snapShotDocuments {
                        let data = doc.data()
                        if let senderBody = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String {
                            // Create a message and append it to the messages array that is used to populate the screen.
                            let newMessage = MessageModel(messageSender: senderBody, messageBody: messageBody)
                            self.messageArray.append(newMessage)
                            
                            // Good pactice, get hold of main queue since grabbing documents is happening in the background.
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                // Unlike the table view displayed in settings, this app only has one section.
                                // Scroll the table view to the latest message and clear the entry field.
                                let indexPath = IndexPath(row: self.messageArray.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                self.messageTextfield.text = ""
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            // Load Firebase database and add entry.
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                // Create entry
                Constants.FStore.dateField: Date().timeIntervalSince1970,
                Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: messageBody])
            { (error) in
                // Catch errors
                if let e = error {
                    print(e)
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
        cell.message.text = message.messageBody
        
        if message.messageSender == Auth.auth().currentUser?.email {
            // Format message from the current user.
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.message.textColor = UIColor(named: Constants.BrandColors.purple)
        } else {
            // Format message from another user.
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lighBlue)
            cell.message.textColor = UIColor(named: Constants.BrandColors.blue)
        }
        return cell
    }
}
