//
//  ChatViewController.swift
//  Ludmurik
//
//  Created by Глеб Капустин on 15.04.2024.
//

import UIKit
import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
    
}

struct Message: MessageType {
    var sender: any MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
    
    
}

final class ChatViewController: MessagesViewController {
    
    private let currentUser = Sender(senderId: "self", displayName: "You")
    private let otherUser = Sender(senderId: "other", displayName: "All")
    
    private let mockText = ["hello", "hi", "wassap", "ok", "code?", "yeeeeeeë"]
    private lazy var messages: [MessageType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...mockText.count-1 {
            let addingTimeInterval: Double = Double(-86400)
            messages.append(Message(sender: i % 2 == 0 ? currentUser : otherUser,
                                    messageId: "\(i)",
                                    sentDate: Date().addingTimeInterval(addingTimeInterval),
                                    kind: .text(mockText[i])))
        }
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.reloadData()
    }
}

extension ChatViewController: MessagesDataSource {

    var currentSender: SenderType {
        return currentUser
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
}

extension ChatViewController: MessageCellDelegate {
    
}

extension ChatViewController: MessagesLayoutDelegate {

}
                                    
extension ChatViewController: MessagesDisplayDelegate {
    
}
