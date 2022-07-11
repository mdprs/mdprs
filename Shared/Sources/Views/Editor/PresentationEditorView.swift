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
import SimpleToast
import SwiftUI
import SwiftUIKit

struct PresentationEditorView: View {

  // MARK: - Public Properties

  var body: some View {

    VStack {
      ConditionalView(if: showPreview) {
        PresentationPreview(presentationService: presentationService, slide: slide)
      } else: {
        MarkdownEditor(text: documentBinding(), position: $position, slide: $slide)
      }
      StatusBar(
                position: $position,
                   slide: $slide,
        showPresentation: $showPresentation.didSet(togglePresentation(visible:)),
             showPreview: $showPreview,
             servicePort: servicePort)
      .padding(.vertical, 2)
    }
    .onAppear(perform: startPresentationService)
    .onAppear(perform: registerToastNotifications)
    .onDisappear(perform: stopPresentationService)
    .onDisappear(perform: deregisterToastNotifications)
    .simpleToast(isPresented: $showToast, options: toast.toastOptions, onDismiss: toast.dismissCallback) {
      ToastView(toast: toast)
        .background(Color(NSColor.controlBackgroundColor).opacity(0.9))
        .padding()
    }
    .onAppear {
      fatalErrorToast(message: "This is an informational message!", document: document, error: CocoaError(.fileReadCorruptFile)).show()
    }
  }

  @Binding
  var document: PresenterDocument


  // MARK: - Private Properties

  @State
  private var position = (column: 1, line: 1)

  @State
  private var slide = 1

  @State
  private var showPresentation = false

  @State
  private var showPreview = false

  @State
  private var presentationService: SlidedeckService!

  @State
  private var showToast = false

  @State
  private var toastCancellable: AnyCancellable? = nil

  @State
  private var toast = Toast<PresenterDocument>()

  private var servicePort: UInt16 {
    return presentationService?.port ?? 0
  }


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
      errorToast(
         message: "An error occured when attempting to the start the presentation service.\nYou can try to close and reopen the document to start the service.",
        document: self.document,
           error: error)
      .show()
    }
  }

  private func registerToastNotifications() {
    toastCancellable = NotificationCenter.default.publisher(for: .Toast).sink { notification in
      if let toast = (notification.object as? Toast<PresenterDocument>) {
        if toast.isToast(forDocument: self.document) {
          self.toast = toast
          self.showToast = true
        }
      }
    }
  }

  private func deregisterToastNotifications() {
    toastCancellable?.cancel()
  }

  private func stopPresentationService() {
    presentationService.stop()
  }

  private func togglePresentation(visible: Bool) {
    // TODO
  }
}
