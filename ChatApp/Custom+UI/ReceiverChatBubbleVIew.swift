//
//  ReceiverChatBubbleVIew.swift
//  ChatApp
//
//  Created by bakhva  on 27.04.23.
//

import UIKit

final class ReceiverChatBubbleVIew: UIView {
    
    //MARK: Components
    private let color: UIColor = ChatAppColors.receiverBubbleColor
    
    private lazy var mainTextBubble: UIView = {
        let bubble = UIView()
        bubble.translatesAutoresizingMaskIntoConstraints = false
        bubble.backgroundColor = color
        bubble.layer.cornerRadius = ReceiverChatBubbleVIewConstants.mainTextBubbleCornerRadius
        return bubble
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: ReceiverChatBubbleVIewConstants.messageLabelFont)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: ReceiverChatBubbleVIewConstants.dateLabelFont)
        label.textColor = ChatAppColors.dateLabelColor
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addingSubviews()
        constraints()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Adding Sub Views
    private func addingSubviews() {
        addSubview(mainTextBubble)
        addSubview(dateLabel)
        mainTextBubble.addSubview(messageLabel)
    }
    
    // MARK: Constraints
    private func constraints() {
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: mainTextBubble.leadingAnchor, constant: ReceiverChatBubbleVIewConstants.messageLabelPadding),
            messageLabel.bottomAnchor.constraint(equalTo: mainTextBubble.bottomAnchor, constant: -ReceiverChatBubbleVIewConstants.messageLabelPadding),
            messageLabel.topAnchor.constraint(equalTo: mainTextBubble.topAnchor, constant: ReceiverChatBubbleVIewConstants.messageLabelPadding),
            messageLabel.trailingAnchor.constraint(equalTo: mainTextBubble.trailingAnchor, constant: -ReceiverChatBubbleVIewConstants.messageLabelPadding),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: ReceiverChatBubbleVIewConstants.messageLabelMaximumWidth),
            
            mainTextBubble.topAnchor.constraint(equalTo: topAnchor, constant: ReceiverChatBubbleVIewConstants.mainTextBubbleTopPadding),
            mainTextBubble.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ReceiverChatBubbleVIewConstants.mainTextBubbleLeadingPadding),
            mainTextBubble.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ReceiverChatBubbleVIewConstants.dateLabelLeadingPadding),
            mainTextBubble.heightAnchor.constraint(greaterThanOrEqualToConstant: ReceiverChatBubbleVIewConstants.mainTextBubbleMinHeight),
            mainTextBubble.widthAnchor.constraint(greaterThanOrEqualToConstant: ReceiverChatBubbleVIewConstants.mainTextBubbleMinWidth),
            
            dateLabel.topAnchor.constraint(equalTo: mainTextBubble.bottomAnchor, constant: ReceiverChatBubbleVIewConstants.dateLabelTopPadding),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ReceiverChatBubbleVIewConstants.dateLabelLeadingPadding),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ReceiverChatBubbleVIewConstants.dateLabelTopPadding)
        ])
    }
    
    // MARK: Config UI
    private func configUI() {
        backgroundColor = .clear
    }
    
    // MARK: Set Up Bubble
    func setUpBubble(with message: Message) {
        messageLabel.text = message.text
        dateLabel.text = message.dateSent
        if dateLabel.text == ChatAppComponents.errorMessage {
            dateLabel.textColor = .red
        }
    }
    
    // MARK: BazierPath bubbles
    override func draw(_ rect: CGRect) {
        
        let firstBubble = UIBezierPath(
            ovalIn: CGRect(
                x: mainTextBubble.frame.minX - 5,
                y: mainTextBubble.frame.maxY - 17,
                width: ReceiverChatBubbleVIewConstants.firstBubbleHeight,
                height: ReceiverChatBubbleVIewConstants.firstBubbleHeight))
        color.setFill()
        firstBubble.fill()
        
        let secondBubble = UIBezierPath(
            ovalIn: CGRect(
                x: mainTextBubble.frame.minX - 18,
                y: mainTextBubble.frame.maxY,
                width: ReceiverChatBubbleVIewConstants.secondBubbleHeight,
                height: ReceiverChatBubbleVIewConstants.secondBubbleHeight))
        color.setFill()
        secondBubble.fill()
    }
}

// MARK: -ReceiverChatBubbleVIew Constants
private extension ReceiverChatBubbleVIew {
    enum ReceiverChatBubbleVIewConstants {
        static let messageLabelPadding: CGFloat = 10
        static let messageLabelMaximumWidth: CGFloat = 220
        static let mainTextBubbleTopPadding: CGFloat = 10
        static let mainTextBubbleLeadingPadding: CGFloat = 30
        static let mainTextBubbleMinHeight: CGFloat = 50
        static let mainTextBubbleMinWidth: CGFloat = 50
        static let dateLabelTopPadding: CGFloat = 4
        static let dateLabelLeadingPadding: CGFloat = 45
        static let dateLabelHeight: CGFloat = 10
        static let mainTextBubbleCornerRadius: CGFloat = 25
        static let messageLabelFont: CGFloat = 14
        static let dateLabelFont: CGFloat = 8
        static let intrinsicContentSizeHeight: CGFloat = 40
        static let firstBubbleHeight: CGFloat = 20
        static let secondBubbleHeight: CGFloat = 10
    }
}
