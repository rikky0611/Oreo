//
//  ViewController.swift
//  Oreo
//
//  Created by 荒川陸 on 2016/03/24.
//  Copyright © 2016年 Mikan Laboratories. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate {
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    //let fieldSize = Field.fieldSize

    // MultipeerConnectivity Settings
    let serviceType = "mikanlabsoreo" // unique service name
    var browser: MCBrowserViewController!
    var assistant: MCAdvertiserAssistant!
    var session: MCSession!
    var peerID:  MCPeerID!
    let boardView = Field()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialize()
        
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
    
    func browserViewControllerDidFinish(
        browserViewController: MCBrowserViewController)  {
        // Called when the browser view controller is dismissed (ie the Done
        // button was tapped)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func initialize(){
        
        let boardSize = CGSizeMake(screenWidth,screenHeight)
        let boardOrigin = CGPointMake(0,(screenHeight - boardSize.height)/2)
        
        boardView.frame.origin = boardOrigin
        boardView.frame.size = boardSize
        self.view.addSubview(boardView)
        
        let btnSize = boardSize.width/CGFloat(fieldSize)
        
        for y in 0 ..< fieldSize {
            for x in 0 ..< fieldSize {
                let btn = UIButton(frame: CGRectMake(btnSize * CGFloat(x),btnSize * CGFloat(y),btnSize, btnSize))
                btn.layer.borderWidth = 2.0
                btn.layer.borderColor = UIColor.grayColor().CGColor
                boardView.addSubview(btn)
                
                btn.tag = y*fieldSize + x
                btn.addTarget(self, action:"onBtnClick:" , forControlEvents: .TouchUpInside)
                
            }
        }
    }
    
    func onBtnClick(btn: UIButton){
        
        let x = btn.tag % fieldSize
        let y = btn.tag / fieldSize
        print("x:\(x),y:\(y)")
        let pos = Position(x: x,y: y)
        boardView.burn_at(pos){(status) in
            if status == Field.Cell.Blank {
                btn.backgroundColor = UIColor.blackColor()
                let msg = "test".dataUsingEncoding(NSUTF8StringEncoding,
                                                   allowLossyConversion: false)
                
                do{
                    try self.session.sendData(msg!, toPeers: self.session.connectedPeers,
                                              withMode: MCSessionSendDataMode.Unreliable)
                }catch{
                    //えらー
                }
            }else if status == Field.Cell.Ship{
                btn.backgroundColor = UIColor.yellowColor()
            }else{
                self.setAlert("そこには大砲を打てません")
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
        // Called when a peer sends an NSData to us
        
        // This needs to run on the main queue
        dispatch_async(dispatch_get_main_queue()) {
            //let msg = NSString(data: data, encoding: NSUTF8StringEncoding)
            self.setAlert("攻撃を受けました。")
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

