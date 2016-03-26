//
//  ViewController.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/24.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate, FieldViewDelegate {
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    // MultipeerConnectivity Settings
    let serviceType = "mikanlabsoreo" // unique service name
    var browser: MCBrowserViewController!
    var assistant: MCAdvertiserAssistant!
    var session: MCSession!
    var peerID:  MCPeerID!
    let ownFieldView = FieldView()
    let enemyFieldView = FieldView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ownFieldView.initialize(FieldView.Side.Own)
        ownFieldView.delegate = self
        ownFieldView.bottom = self.view.bottom
        self.view.addSubview(ownFieldView)
        
        enemyFieldView.initialize(FieldView.Side.Enemy)
        enemyFieldView.delegate = self
        enemyFieldView.top = self.view.top
        self.view.addSubview(enemyFieldView)
        
        self.peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        self.session = MCSession(peer: peerID)
        self.session.delegate = self
        
        // create the browser ViewController with a unique service name
        self.browser = MCBrowserViewController(serviceType: serviceType,
                                               session: self.session)
        
        self.browser.delegate = self
        
        self.assistant = MCAdvertiserAssistant(serviceType: serviceType,
                                               discoveryInfo: nil, session: self.session)
        
        // tell the assistant to start advertising our fabulous chat
        self.assistant.start()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if self.session.connectedPeers.count == 0 {
            self.presentViewController(self.browser, animated: true, completion: nil)
        }
    }
    
    func sendMessage(msg: Message) -> Bool {
        do {
            let str = msg.toJson()
            print(str)
            let data = str.dataUsingEncoding(NSUTF8StringEncoding,
                                          allowLossyConversion: false)
            try self.session.sendData(data!, toPeers: self.session.connectedPeers,
                                  withMode: MCSessionSendDataMode.Unreliable)
        }catch{
            // error handling
        }
        
        return true
    }
    
    func browserViewControllerDidFinish(
        browserViewController: MCBrowserViewController)  {
        // Called when the browser view controller is dismissed (ie the Done
        // button was tapped)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        

    }
    
    func setAlert(message:String){
        let alert:UIAlertController = UIAlertController(title: "警告", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            action in
            // ボタンが押された時の処理
            print ("pushed")
        }))
        self.presentViewController(alert, animated: true, completion: {
            // 表示完了時の処理
            print("finished")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func browserViewControllerWasCancelled(
        browserViewController: MCBrowserViewController)  {
        // Called when the browser view controller is cancelled

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func session(session: MCSession, didReceiveData data: NSData,
                 fromPeer peerID: MCPeerID)  {
        
        
        dispatch_async(dispatch_get_main_queue()) {
            print("start getting attacked")
            
            let rawStr = String(data: data, encoding: NSUTF8StringEncoding)
            guard let str = rawStr else {
                print("data couldn't be parsed")
                return
            }
            
            let rawMsg = Message(json: str)
            guard let msg = rawMsg else {
                print("msg is nil\n\(str)")
                return
            }
            
            print(msg.description)
            
            
            
            switch msg.type {
            case .Attack:
                self.ownFieldView.getAttackedAt(msg.target)
                self.setAlert("攻撃を受けました。")
            default:
                if msg.is_success {
                    self.enemyFieldView.markBurnedAt(msg.target)
                    self.setAlert("攻撃が成功しました。")
                }else{
                    self.enemyFieldView.markMissedAt(msg.target)
                    self.setAlert("攻撃は失敗しました。")
                }
            }
        }
        
        
    }
    
    // The following methods do nothing, but the MCSessionDelegate protocol
    // requires that we implement them.
    func session(session: MCSession,
                 didStartReceivingResourceWithName resourceName: String,
                                                   fromPeer peerID: MCPeerID, withProgress progress: NSProgress)  {
        
        // Called when a peer starts sending a file to us
    }
    
    func session(session: MCSession,
                 didFinishReceivingResourceWithName resourceName: String,
                                                    fromPeer peerID: MCPeerID,
                                                             atURL localURL: NSURL, withError error: NSError?)  {
        // Called when a file has finished transferring from another peer
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream,
                 withName streamName: String, fromPeer peerID: MCPeerID)  {
        // Called when a peer establishes a stream with us
    }
    
    func session(session: MCSession, peer peerID: MCPeerID,
                 didChangeState state: MCSessionState)  {
        // Called when a connected peer changes state (for example, goes offline)
        
    }
    
    
    
}

