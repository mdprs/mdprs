//
//  MarkdownEditor.swift
//  mdprs
//
//  Created by Thomas Bonk on 03.07.22.
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

import CodeEditor
import Combine
import SwiftUI

struct MarkdownEditor: View {

  // MARK: - Public Typealiases

  typealias Position = (column: Int, line: Int)


  // MARK: - Public Properties

  var body: some View {
    CodeEditor(
         source: $text,
      selection: Binding(get: { selection }, set: { updatePosition($0) }),
       language: .markdown,
          theme: .default)
  }

  @Binding
  var text: String

  @Binding
  var position: Position


  // MARK: - Private Properties

  @State
  private var selection: Range<String.Index> = Range(uncheckedBounds: ("".startIndex, "".endIndex))

  @Environment(\.colorScheme)
  private var colorScheme: ColorScheme


  // MARK: - Private Methods

  private func updatePosition(_ selection: Range<String.Index>) {
    self.selection = selection
    DispatchQueue.main.async {
      self.position = text.position(from: self.selection.upperBound)
    }
  }

  private func toInt(_ index: String.Index) -> Int {
    if index > text.endIndex {
      return text.count
    } else {
      return text.distance(from: text.startIndex, to: self.selection.upperBound)
    }
  }

  private func cursorPosition(for range: NSRange) -> Position {
    let cursorIndex = text.index(text.startIndex, offsetBy: range.location)
    let textToCursor = text[..<cursorIndex]
    let lines = textToCursor.components(separatedBy: "\n")
    let line = lines.count
    let column = lines.last?.count ?? 1

    return (column: max(1, column), line: line)
  }
}
