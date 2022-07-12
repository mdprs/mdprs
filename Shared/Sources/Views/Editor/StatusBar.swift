//
//  StatusBar.swift
//  mdprs
//
//  Created by Thomas Bonk on 02.07.22.
//  Copyright 2022 Thomas Bonk <thomas@meandmymac.de>
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import SwiftUI

struct StatusBar: View {
  
  // MARK: - Public Properties

  var body: some View {
    HStack {
      Text("Line: \(position.line) Col: \(position.column)")

      Divider().frame(height: 20)

      Text("Slide: \(slide)")

      Spacer()

      Text("Port: \(String(servicePort))")

      Divider().frame(height: 20)

      Button {
        showPresentation = !showPresentation
      } label: {
        Image(systemName: "play.rectangle")
      }
      .help("Open Presentation Window")
      .keyboardShortcut("s", modifiers: .command)
      .buttonStyle(.plain)

      Button {
        showPreview = !showPreview
      } label: {
        Image(systemName: showPreview ? "tv.fill" : "tv")
      }
      .help("Show Preview")
      .keyboardShortcut("p", modifiers: .command)
      .buttonStyle(.plain)
    }
    .padding([.leading, .trailing], 10)
    .padding(.bottom, 5)
    .padding(.top, -5)
  }

  @Binding
  var position: MarkdownEditor.Position

  @Binding
  var slide: Int

  @Binding
  var showPresentation: Bool

  @Binding
  var showPreview: Bool

  var servicePort: UInt16
}

