//
//  InputRow.swift
//  MZEDU
//
//  Created by 수진잉 on 12/30/25.
//

import UIKit
import SnapKit
import Photos

final class InfoInputRow: UIView {

    private let titleLabel = UILabel()
    let textField = UITextField()

    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        configureUI(title: title, placeholder: placeholder)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configureUI(title: String, placeholder: String) {

        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .black

        textField.placeholder = placeholder
        textField.font = .systemFont(ofSize: 16, weight: .medium)
        textField.textColor = .black
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.lightGray]
        )

        addSubview(titleLabel)
        addSubview(textField)
    }

    private func setupLayout() {

        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(35)
        }
    }
}
