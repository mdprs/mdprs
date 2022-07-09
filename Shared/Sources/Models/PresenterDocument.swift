//
//  PresenterDocument.swift
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

import Foundation
import mdprsKit
import SwiftUI
import UniformTypeIdentifiers

extension UTType {
  static var markdownText: UTType {
    UTType(importedAs: "net.daringfireball.markdown", conformingTo: .plainText)
  }
}

struct PresenterDocument: FileDocument {

  // MARK: - Static Properties

  static var readableContentTypes: [UTType] { [.markdownText] }


  // MARK: - Public Properties

  var text: String


  // MARK: - Initializtaion

  init(text: String = "---\ntitle: Slidedeck Title\n---\n") {
    self.text = text
  }


  // MARK: - FileDocument

  init(configuration: ReadConfiguration) throws {
    guard let data = configuration.file.regularFileContents,
          let string = String(data: data, encoding: .utf8)
    else {
      throw CocoaError(.fileReadCorruptFile)
    }
    text = string
  }

  func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
    let data = text.data(using: .utf8)!
    return .init(regularFileWithContents: data)
  }
}
