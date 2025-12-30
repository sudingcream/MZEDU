import UIKit

extension UILabel {
    static func styled(
        text: String,
        font: UIFont,
        color: UIColor = .black,
        kern: CGFloat = -1,
        numberOfLines: Int = 1
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.numberOfLines = numberOfLines
        label.attributedText = NSAttributedString(
            string: text,
            attributes: [.kern: kern]
        )
        return label
    }
}
