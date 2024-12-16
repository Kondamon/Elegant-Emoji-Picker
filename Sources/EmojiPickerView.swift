//
//  EmojiPickerView.swift
//
//
//  Created by Kondamon on 16.12.24.
//

import Foundation
import SwiftUI

// SwiftUI Wrapper for ElegantEmojiPicker
public struct EmojiPickerView: UIViewControllerRepresentable {
    @Binding var selectedEmoji: String

    // Configuration properties
    var configuration: ElegantConfiguration
    var localization: ElegantLocalization
    var sourceNavigationBarButton: UIBarButtonItem?
    
    public init(
        selectedEmoji: Binding<String>,
        configuration: ElegantConfiguration = ElegantConfiguration(),
        localization: ElegantLocalization = ElegantLocalization(),
        sourceNavigationBarButton: UIBarButtonItem? = nil) {
        self._selectedEmoji = selectedEmoji
        self.configuration = configuration
        self.localization = localization
        self.sourceNavigationBarButton = sourceNavigationBarButton
    }

    public func makeUIViewController(context: Context) -> ElegantEmojiPicker {
        let emojiPicker = ElegantEmojiPicker(
            delegate: context.coordinator,
            configuration: configuration,
            localization: localization,
            sourceView: nil,
            sourceNavigationBarButton: sourceNavigationBarButton
        )
        return emojiPicker
    }

    public func updateUIViewController(_ uiViewController: ElegantEmojiPicker, context: Context) {
    
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(selectedEmoji: $selectedEmoji)
    }

    // Coordinator to handle delegate methods
    public class Coordinator: NSObject, ElegantEmojiPickerDelegate {
        @Binding var selectedEmoji: String
        var shouldPresentPicker: Bool = true

        public init(selectedEmoji: Binding<String>) {
            _selectedEmoji = selectedEmoji
        }

        public func emojiPicker(_ picker: ElegantEmojiPicker, didSelectEmoji emoji: Emoji?) {
            selectedEmoji = emoji?.emoji ?? ""
            picker.dismiss(animated: true)
        }
    }
}
