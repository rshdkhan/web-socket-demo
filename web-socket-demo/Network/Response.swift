//
//  Response.swift
//  web-socket-demo
//
//  Created by Rashid Khan on 10/20/21.
//

import Foundation

enum SocketEventType {
    case connected
    case disconnected
    case valueChange
    case error
    case other
}

struct Response<T: Codable> {
    var eventType: SocketEventType
    var data: T?
    var error: Error?
    
    init(eventType: SocketEventType) {
        self.eventType = eventType
    }
    
    init(data: T) {
        self.eventType = .valueChange
        self.data = data
    }
    
    init(error: Error?) {
        self.eventType = .error
        self.error = error
    }
}
