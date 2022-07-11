//
//  Alert.swift
//  mdprs
//
//  Created by Thomas Bonk on 13.06.22.
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
import SwiftUI
import SimpleToast

extension Notification.Name {
  static let Toast = Notification.Name("TOAST_NOTIFICATION")
}

// MARK: - Static Methods

func informationToast<D: Hashable>(message: String, document: D? = nil) -> Toast<D> {
  return Toast<D>(toastType: .information, message: message, document: document)
}

func warningToast<D: Hashable>(message: String, document: D? = nil, error: Error? = nil) -> Toast<D> {
  return Toast<D>(toastType: .warning, message: message, document: document)
}

func errorToast<D: Hashable>(message: String, document: D? = nil, error: Error? = nil) -> Toast<D> {
  return Toast<D>(toastType: .error, message: message, error: error, document: document)
}

func fatalErrorToast<D: Hashable>(message: String, document: D? = nil, error: Error? = nil, dismissCallback: Toast<D>.DismissCallback? = nil) -> Toast<D> {
  return Toast<D>(toastType: .fatalError, message: message, error: error, document: document, dismissCallback: {
    dismissCallback?()
    fatalError(message)
  })
}

struct Toast<Document: Hashable> {

  // MARK: - Public Typealiases

  typealias DismissCallback = () -> ()


  // MARK: - Public Enums

  enum ToastType {
    case information
    case warning
    case error
    case fatalError
  }


  // MARK: - Public Properties

  let toastType: ToastType
  let message: String
  let document: Document?
  let error: Error?
  let toastOptions: SimpleToastOptions
  private(set) var dismissCallback: DismissCallback = {}

  var title: LocalizedStringKey {
    switch toastType {
      case .information:
        return LocalizedStringKey("Information")
      case .warning:
        return LocalizedStringKey("Warning")
      case .error:
        return LocalizedStringKey("Error")
      case .fatalError:
        return LocalizedStringKey("Fatal Error")
    }
  }


  // MARK: - Initialization

  init(
    toastType: ToastType = .information,
    message: String = "",
    error: Error? = nil,
    document: Document? = nil,
    dismissCallback: DismissCallback? = nil) {

      self.toastType = toastType
      self.message = message
      self.document = document
      self.error = error
      self.toastOptions = SimpleToastOptions(
        alignment: self.toastType == .information ? .bottom : .center,
        hideAfter: self.toastType == .information ? 5 : nil,
        modifierType: .fade)

      if dismissCallback != nil {
        self.dismissCallback = dismissCallback!
      }
    }


  // MARK: - Public Methods

  func show() {
    NotificationCenter.default.post(name: .Toast, object: self)
  }

  func isToast(forDocument other: Document) -> Bool {
    return document == nil || document!.hashValue == other.hashValue;
  }
}
