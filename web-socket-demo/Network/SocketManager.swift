//
//  NetworkClient.swift
//  web-socket-demo
//
//  Created by Rashid Khan on 10/19/21.
//

import Foundation
import SocketIO
import Starscream

class SocketManager {
    static let shared = SocketManager()
    
    var socket: WebSocket!
    
    private init() {
    }
    
    func connect<T: Codable>(type: T.Type, completionHandler: @escaping(Response<T>)->()) {
        var request = URLRequest(url: URL(string: "ws://159.89.15.214:8080/")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        
        socket.onEvent = { [weak self] event in
            guard let _ = self else { return }
            
            switch event {
            case .connected(_):
                completionHandler(Response(eventType: .connected))
                break
                
            case .disconnected(_, _):
                completionHandler(Response(eventType: .disconnected))
                break
                
            case .text(let text):
                let data = text.data(using: .utf8)!
                do {
                    let model: T = try JSONDecoder().decode(type, from: data)
                    
                    completionHandler(Response(data: model))
                } catch {
                    print("error occure while parsing data")
                }
                break
                
            case .error(let error):
                completionHandler(Response(error: error))
                break
                
            case .binary, .ping, .pong, .viabilityChanged, .reconnectSuggested, .cancelled:
                completionHandler(Response(eventType: .other))
                break
            }
            }
        
        socket.connect()
    }
    
    func disconnect() {
        self.socket.disconnect()
    }
    
    func subscribe(companyISIN: String) {
        self.socket.write(string: "{\"subscribe\":\"\(companyISIN)\"}")
    }
}
