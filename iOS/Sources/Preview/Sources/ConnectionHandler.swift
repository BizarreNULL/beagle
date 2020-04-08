/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

import Starscream

protocol ConnectionHandlerDelegate: AnyObject {
    func onLayoutChange(_ json: String)
}

class ConnectionHandler {

    weak var delegate: ConnectionHandlerDelegate?

    init() {
        self.config = BeaglePreviewConfig.buildDefaultConfig()
    }

    func connect() {
        print("trying to connect")
        self.socket = WebSocket(request: URLRequest(url: URL(string: self.config.host)!))
        self.socket.onEvent = { [weak self] event in
            guard let self = self else { return }
            self._onEvent(event)
        }
        self.socket.connect()
        self.running = true
        self.schedulePing()
    }

    func disconnect() {
        print("disconnecting from server")
        self.running = false
        self.socket.disconnect(closeCode: 1000)
        self.socket = nil
    }

    // MARK: Private

    private var running: Bool = false
    private var config: BeaglePreviewConfig
    private var socket: WebSocket!

    private func _onEvent(_ event: WebSocketEvent) {

        if case .text(let json) = event {
            let index = json.index(json.startIndex, offsetBy: min(json.count, 128))
            print("handling event: \(json[..<index])...")
        } else {
            print("handling event: \(event)")
        }

        if case .text(let json) = event, !json.contains("Welcome") {
            print("notifying layout update...")
            delegate?.onLayoutChange(json)
        }

        if case .cancelled = event {
            print("lost connection to server")
            self.disconnect()
        }
    }

    private func schedulePing() {

        guard running else {
            return
        }

        print("re-scheduling ping...")
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3.0, execute: {
            print("sending ping...")
            self.socket?.write(ping: Data(), completion: {})
            self.schedulePing()
        })
    }

}
