//
//  PresentationPreview.swift
//  mdprs
//
//  Created by Thomas Bonk on 09.07.22.
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

import mdprsKit
import SwiftUI
import WebView

struct PresentationPreview: View {

  // MARK: - Public Properties

  var body: some View {
    WebView(webView: webViewStore.webView)
      .onAppear {
        self.webViewStore.webView.load(URLRequest(url: URL(string: "http://localhost:\(presentationService.port)/#/\(slide - 1)")!))
      }
  }

  var presentationService: SlidedeckService
  var slide: Int


  // MARK: - Private Properties

  @StateObject
  private var webViewStore = WebViewStore()
}

