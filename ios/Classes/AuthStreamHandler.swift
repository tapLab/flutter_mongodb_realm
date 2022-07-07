//
//  File.swift
//  flutter_mongo_realm

import Foundation


import RealmSwift

@available(iOS 13.0, *)
class MyRLMAuthDelegate: ASLoginDelegate
{
    var _events: FlutterEventSink
    init(eventSink events: @escaping FlutterEventSink){
        self._events = events;
    }
    func authenticationDidComplete(error: Error) {
        
    }
    
    func authenticationDidComplete(user: User) {
//        if (user != nil){
//            self._events(user!.toMap())
//        }
//        else {
//            self._events(nil)
//        }
        switch(user.state){
            case .loggedIn:
                self._events(user.toMap())
                break
                
            case .loggedOut:
                self._events(nil)
                break
                
            case .removed:
                self._events(nil)
                break
                
            default:
                break;
        }
        
    }
    
    
}


@available(iOS 13.0, *)
class AuthStreamHandlerRLM : FlutterStreamHandler{
    var realmApp: App
    var loginDelegate: MyRLMAuthDelegate?
    
    init(realmApp: App) {
        self.realmApp = realmApp
    }
    
    func onListen(withArguments arguments: Any?,
                  eventSink events: @escaping FlutterEventSink) -> FlutterError? {

        loginDelegate = MyRLMAuthDelegate(eventSink: events)
        self.realmApp.authorizationDelegate = loginDelegate!

        if let user = self.realmApp.currentUser {
            if(user.isLoggedIn){
                events(user.toMap())
            }
            else {
                events(nil)
            }
        }
        else{
            events(nil)
        }
        
        
        return nil;
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil;
    }

}

