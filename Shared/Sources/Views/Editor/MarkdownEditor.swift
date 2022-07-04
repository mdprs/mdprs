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

import CodeEditorView
import SwiftUI

struct MarkdownEditor: View {

  // MARK: - Public Typealiases

  typealias Position = (column: Int, line: Int)


  // MARK: - Public Properties

  var body: some View {
    CodeEditor(
          text: $text,
      position: positionBinding(),
      messages: $messages,
      language: markdown,
          layout: CodeEditor.LayoutConfiguration(showMinimap: sourceMapVisible))
    .environment(\.codeEditorTheme, colorScheme == .dark ? Theme.defaultDark : Theme.defaultLight)
  }

  @Binding
  var text: String

  @Binding
  var position: Position

  var sourceMapVisible: Bool


  // MARK: - Private Properties

  @State
  private var internalPos = CodeEditor.Position()

  @State
  private var messages: Set<Located<Message>> = []

  @Environment(\.colorScheme)
  private var colorScheme: ColorScheme

  private let markdown = LanguageConfiguration(
    stringRegexp: LanguageConfiguration.swift.stringRegexp,
    characterRegexp: nil,
    numberRegexp: LanguageConfiguration.swift.numberRegexp,
    singleLineComment: nil,
    nestedComment: (open: "<!--", close: "-->"),
    identifierRegexp: nil,
    reservedIdentifiers: [
      "---", "title", "description", "author", "keywords", "theme", "true", "false"
    ])


  // MARK: - Private Methods

  private func positionBinding() -> Binding<CodeEditor.Position> {
    return Binding {
      internalPos
    } set: { newPos in
      internalPos = newPos
      position = cursorPosition(for: internalPos)
    }
  }

  private func insertionPoint(of position: CodeEditor.Position) -> NSRange? {
    return position.selections.first(where: { $0.length == 0 })
  }

  private func cursorPosition(for position: CodeEditor.Position) -> Position {
    if let rng = insertionPoint(of: position) {
      return cursorPosition(for: rng)
    }

    return (column: 1, line: 1)
  }

  private func cursorPosition(for range: NSRange) -> Position {
    let index = text.index(text.startIndex, offsetBy: range.location)
    let textBeforeCursor = text.endIndex < index ? text[...index] : text[..<index]
    let y = textBeforeCursor.reduce(0, { $1 == "\n" ? $0 + 1 : $0 }) + 1
    let lastLine = textBeforeCursor.components(separatedBy: "\n").last
    let x = (lastLine?.count ?? 0) + 1

    return (column: x, line: y)
  }
}
