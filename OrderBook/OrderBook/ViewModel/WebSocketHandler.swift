//
//  WebSocketHandler.swift
//  OrderBook
//
//  Created by MacDev1 on 8/9/23.
//

import Foundation

public protocol WebSocketHandlerDelegate: AnyObject {
    func didReceiveMessage(_ message: String)
    // Add more delegate methods as needed
}

public class WebSocketHandler {
    private var webSocketTask: URLSessionWebSocketTask?
    public weak var delegate: WebSocketHandlerDelegate?

    public init(url: URL) {
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
    }

    public func connect() {
        webSocketTask?.resume()

        receiveMessages()
    }

    public func send(message: String) {
        let message = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("Error sending message: \(error)")
            }
        }
    }

    private func receiveMessages() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.delegate?.didReceiveMessage(text)
                case .data(_):
                    // Handle received binary data
                    break
                @unknown default:
                    fatalError()
                }
            case .failure(let error):
                print("Error receiving message: \(error)")
            }
            self?.receiveMessages() // Continue receiving messages
        }
    }

    public func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
}
