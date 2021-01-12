//
//  ViewController.swift
//  Combine_Test
//
//  Created by Juan Capponi on 1/12/21.
//

import UIKit
import Combine


struct Message {
    let content: String
    let author: String
}

class ViewController: UIViewController {

    
    @IBOutlet weak var allowMessageSwitch: UISwitch!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!

    @Published var canSendMessages: Bool = false
    
    private var switchSuscriber: AnyCancellable?

    @IBAction func sendMessage(_ sender: Any) {
        let message = Message(content: "The current time is \(Date())", author: "ios")
        NotificationCenter.default.post(name: Notification.Name("newMessage"), object: message)
    }
    
    @IBAction func didSwitch(_ sender: UISwitch) {
        canSendMessages = sender.isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       //view.backgroundColor = .red
        allowMessageSwitch.isOn = false
        setSwitcher()
        
        
    }

    func setSwitcher(){
        
        switchSuscriber = $canSendMessages.receive(on: DispatchQueue.main).assign(to: \.isEnabled, on: sendButton)
     
        let messagePublisher = NotificationCenter.Publisher(center: .default, name: Notification.Name("newMessage"))
            .map { notification -> String? in
                return (notification.object as? Message)?.content ?? ""
                    
            }
        
        let messageSubscriber = Subscribers.Assign(object: messageLabel, keyPath: \.text)
        messagePublisher.subscribe(messageSubscriber)
    }
    
    

}

