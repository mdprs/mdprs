//
//  String+Cursor.swift
//  mdprs
//
//  Source: https://stackoverflow.com/q/47207611/44123
//

import Foundation

extension String {

  // MARK: - Public Methods

  func position(from index: String.Index) -> MarkdownEditor.Position {
    let numericIndex = index.index(in: self)
    let length = self.count

    let textBeforeCursor = numericIndex == length ? self : String(self[..<index])
    let lines = textBeforeCursor.components(separatedBy: .newlines)
    let lastLine = lines.last
    var column = 0

    if numericIndex == length && lastLine != nil && lastLine!.count == 0 {
      column = 1
    } else {
      if let line = lastLine {
        column = line.count + 1
      } else {
        column = 1
      }
    }

    return (column: column, line: lines.count)
  }
}
