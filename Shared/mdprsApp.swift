//
//  mdprsApp.swift
//  Shared
//
//  Created by Thomas Bonk on 02.07.22.
//

import SwiftUI

@main
struct mdprsApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: mdprsDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
