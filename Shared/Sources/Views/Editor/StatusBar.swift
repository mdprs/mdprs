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
      Text(String(format: "Line: %4u | Column: %4u", position.line, position.column))
      Text("|")
      Button {
        sourceMapVisible = !sourceMapVisible
      } label: {
        Image(systemName: sourceMapVisible ? "map.fill" : "map")
      }
      .help("Toggle Source Map")
      .keyboardShortcut("m", modifiers: .command)
      .buttonStyle(.plain)
      Spacer()
    }
    .padding([.leading, .trailing], 10)
    .padding(.bottom, 5)
    .padding(.top, -5)
  }

  @Binding
  var position: MarkdownEditor.Position

  @Binding
  var sourceMapVisible: Bool
}

