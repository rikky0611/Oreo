//
//  GameViewController.swift
//  Oreo
//
//  Created by Shimpei Otsubo on 3/28/16.
//  Copyright © 2016 Mikan Laboratories. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity

class MultiGameViewController: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate, FieldViewDelegate {
    
    var fieldViews: [FieldView.Side:FieldView] = [:]
    let ownFieldView = FieldView()
    let enemyFieldView = FieldView()
    
    // MultipeerConnectivity Settings
    let serviceType = "mikanlabsoreo" // unique service name
    var browser: MCBrowserViewController!
    var assistant: MCAdvertiserAssistant!
    var session: MCSession!
    var peerID:  MCPeerID!

    enum GameType {
        case SinglePlaper
        case MultiPlayer
    }
    
    var gameType: GameType = .SinglePlaper
    var toShowBrowser = true
    
    func initialize(type: GameType) {
        self.gameType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        putBothView()
    }
    
    func putBothView() {
        fieldViews[FieldView.Side.Own]   = FieldView()
        fieldViews[FieldView.Side.Enemy] = FieldView()
        
        for (side, view) in self.fieldViews {
            print("\(side)")
            view.delegate = self
            view.initialize(side)
            self.view.addSubview(view)
        }
        fieldViews[FieldView.Side.Own]!.bottom = self.view.bottom
        fieldViews[FieldView.Side.Enemy]!.top  = self.view.top
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if self.gameType == .MultiPlayer && self.session.connectedPeers.count == 0 && toShowBrowser{
            self.presentViewController(self.browser, animated: false, completion: nil)
            self.toShowBrowser = false
        }
    }
    
    func configureMultiPlayerSetting(){
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
    
    func sendMessage(msg: Message) -> Bool {
        switch self.gameType {
        case .MultiPlayer:
            sendMessageToPeers(msg)
        default:
            sendMessageToTheOtherField(msg)
        }
        
        return true
    }
    
    func sendMessageToPeers(msg: Message) {
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
    }
    
    func sendMessageToTheOtherField(msg: Message) {
        recieveMessage(msg, to: FieldView.Side.Enemy)
    }
    
    func browserViewControllerDidFinish(
        browserViewController: MCBrowserViewController)  {
        // Called when the browser view controller is dismissed (ie the Done
        // button was tapped)
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
            self.recieveMessage(msg, to: FieldView.Side.Own)
        }
    }
    
    func recieveMessage(msg: Message, to: FieldView.Side){
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