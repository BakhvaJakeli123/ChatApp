//
//  CustomClass.swift
//  ChatApp
//
//  Created by bakhva  on 25.04.23.
//

import UIKit

final class ScrollableTextField: UITextView, UITextViewDelegate {
    
    var placeholder = "დაწერე შეტყობინება..."
    var maxNumberOfLines = 5
    
    // MARK: Text View Line Height
    var lineHeight: CGFloat {
        font?.lineHeight ?? 0
    }
    
    // MARK: Placeholder Color
    var placeholderColor: UIColor = .lightGray {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    // MARK: Textview Text
    override var text: String! {
        didSet {
            invalidateIntrinsicContentSize()
            updatePlaceholderVisibility()
        }
    }
    
    // MARK: Content Size Height
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        let maxHeight = CGFloat(maxNumberOfLines) * lineHeight + textContainerInset.top + textContainerInset.bottom
        if size.height > maxHeight {
            size.height = maxHeight
            isScrollEnabled = true
        } else {
            isScrollEnabled = false
        }
        return size
    }
    
    // MARK: Place Holder Label
    private let placeholderLabel = UILabel()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configurePlaceholderLabel()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Text View Change Function
    func textViewDidChange(_ textView: UITextView) {
        invalidateIntrinsicContentSize()
        updatePlaceholderVisibility()
    }
    
    // MARK: Configuring placeholder Label
    private func configurePlaceholderLabel() {
        addSubview(placeholderLabel)
        delegate = self
        autocorrectionType = .no
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.font = font
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    // MARK: Updading Place Holder
    private func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4)
        ])
    }
}
