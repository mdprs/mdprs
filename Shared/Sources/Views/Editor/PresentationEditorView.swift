//
//  PresentationEditorView.swift
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

struct PresentationEditorView: View {

  // MARK: - Public Properties

  var body: some View {
    VStack {
      MarkdownEditor(text: $document.text, position: $position, sourceMapVisible: sourceMapVisible)
      StatusBar(position: $position, sourceMapVisible: $sourceMapVisible)
    }
  }

  @Binding
  var document: PresenterDocument

  @State
  var position = (column: 1, line: 1)

  @State
  var sourceMapVisible = true
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    PresentationEditorView(document: .constant(PresenterDocument()))
  }
}