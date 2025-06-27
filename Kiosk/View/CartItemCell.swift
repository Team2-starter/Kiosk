import UIKit
import SnapKit

class CartItemCell: UITableViewCell {
    let itemImageView = UIImageView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let quantityLabel = UILabel()
    let minusButton = UIButton(type: .system)
    let plusButton = UIButton(type: .system)

    var onQuantityChange: ((Int) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.image = UIImage(systemName: "photo")

        nameLabel.font = .boldSystemFont(ofSize: 16)
        priceLabel.font = .systemFont(ofSize: 14)
        priceLabel.textColor = .gray

        quantityLabel.font = .systemFont(ofSize: 16)
        quantityLabel.textAlignment = .center

        minusButton.setTitle("−", for: .normal)
        plusButton.setTitle("+", for: .normal)

        minusButton.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)

        [itemImageView, nameLabel, priceLabel, minusButton, quantityLabel, plusButton].forEach {
            contentView.addSubview($0)
        }
    }

    private func setupConstraints() {
        itemImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(itemImageView.snp.trailing).offset(10)
            $0.trailing.lessThanOrEqualTo(minusButton.snp.leading).offset(-10)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(nameLabel)
            $0.bottom.equalToSuperview().offset(-10)
        }

        plusButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }

        quantityLabel.snp.makeConstraints {
            $0.trailing.equalTo(plusButton.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(30)
        }

        minusButton.snp.makeConstraints {
            $0.trailing.equalTo(quantityLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }
    }

    func configure(with item: OrderItem) {
        nameLabel.text = item.name
        priceLabel.text = "\(item.quantity * 10000)원"
        quantityLabel.text = "\(item.quantity)"
    }

    @objc private func minusTapped() {
        guard let qty = Int(quantityLabel.text ?? ""), qty > 1 else { return }
        let newQty = qty - 1
        quantityLabel.text = "\(newQty)"
        onQuantityChange?(newQty)
    }

    @objc private func plusTapped() {
        guard let qty = Int(quantityLabel.text ?? ""), qty < 10 else { return }
        let newQty = qty + 1
        quantityLabel.text = "\(newQty)"
        onQuantityChange?(newQty)
    }
}
