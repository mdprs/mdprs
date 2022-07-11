//
//  Binding+didSet.swift
//  mdprs
//
//  Created by Thomas Bonk on 10.07.22.
//  Source: https://stackoverflow.com/a/59391476/44123
//

import Foundation
import SwiftUI

extension Binding {
  /// Execute block when value is changed.
  ///
  /// Example:
  ///
  ///     Slider(value: $amount.didSet { print($0) }, in: 0...10)
  func didSet(_ execute: @escaping (Value) ->Void) -> Binding {
    return Binding(
      get: {
        return self.wrappedValue
      },
      set: {
        self.wrappedValue = $0
        execute($0)
      }
    )
  }
}
