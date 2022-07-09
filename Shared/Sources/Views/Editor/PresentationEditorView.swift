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

import Combine
import mdprsKit
import SwiftUI

struct PresentationEditorView: View {

  // MARK: - Public Properties

  var body: some View {
    VStack {
      MarkdownEditor(text: documentBinding(), position: $position, slide: $slide)
      StatusBar(position: $position, slide: $slide, showPreview: $showPreview).padding(.vertical, 2)
    }
    .onAppear(perform: startPresentationService)
    .onDisappear(perform: stopPresentationService)
  }

  @Binding
  var document: PresenterDocument


  // MARK: - Private Properties

  @State
  private var position = (column: 1, line: 1)

  @State
  private var slide = 1

  @State
  private var showPreview = false

  @State
  private var presentationService: SlidedeckService!


  // MARK: - Private Methods

  private func documentBinding() -> Binding<String> {
    return Binding {
      return document.text
    } set: { value in
      document.text = value
      presentationService.slidedeck = value
    }
  }

  private func startPresentationService() {
    if presentationService == nil {
      presentationService = SlidedeckService()
    }
    presentationService.slidedeck = document.text
    do {
      try presentationService.start()
    } catch {
      // TODO Handle error
    }
  }

  private func stopPresentationService() {
    presentationService.stop()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    PresentationEditorView(document: .constant(PresenterDocument()))
  }
}
