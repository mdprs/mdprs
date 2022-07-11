//
//  ToastView.swift
//  mdprs
//
//  Created by Thomas Bonk on 11.07.22.
//

import SwiftUI

struct ToastView<Document: Hashable>: View {

  // MARK: - Public Properties

  var body: some View {
    VStack {
      HStack {
        Spacer()
        Text(toast.title).font(.title)
        Spacer()
      }

      HStack {
        AlertImage().padding(.all, 20)

        VStack {
          Text(toast.message).multilineTextAlignment(.center)
            .padding(.vertical, 15)

          if let err = toast.error {
            Text(err.localizedDescription)
          }
        }
      }
    }
    .padding(.vertical, 20)
  }

  var toast: Toast<Document>


  // MARK: - Private Methods

  private func AlertImage(size: CGFloat = 64.0) -> some View {
    switch toast.toastType {
      case .information:
        return Image(systemName: "info.circle.fill")
          .resizable()
          .frame(width: size, height: size)
          .foregroundColor(.green)
      case .warning:
        return Image(systemName: "exclamationmark.triangle.fill")
          .resizable()
          .frame(width: size, height: size)
          .foregroundColor(.yellow)
      case .error:
        return Image(systemName: "exclamationmark.octagon.fill")
          .resizable()
          .frame(width: size, height: size)
          .foregroundColor(.red)
      case .fatalError:
        return Image(systemName: "xmark.shield.fill")
          .resizable()
          .frame(width: size, height: size)
          .foregroundColor(.red)
    }
  }
}
