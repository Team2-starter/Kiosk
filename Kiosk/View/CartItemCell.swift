import UIKit
import SnapKit

class CartItemCell: UITableViewCell {

    var onQuantityChange: ((Int) -> Void)?

    private let containerView = UIView()
    private let iconImageView = UIImageView()    // 이미지뷰 추가
    private let nameLabel = UILabel()
    private let quantityLabel = UILabel()
    private let minusButton = UIButton(type: .system)
    private let plusButton = UIButton(type: .system)

    private var quantity: Int = 1

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()

        backgroundColor = .clear
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        containerView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .gray

        nameLabel.font = .systemFont(ofSize: 16)

        quantityLabel.font = .systemFont(ofSize: 16)
        quantityLabel.textAlignment = .center

        // ——— 여기가 핵심: 버튼을 주황색 동그라미로 스타일링 ———
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(.white, for: .normal)
        minusButton.backgroundColor = UIColor(red: 1.0, green: 0.45, blue: 0.0, alpha: 1.0) // 주황색
        minusButton.layer.cornerRadius = 15
        minusButton.clipsToBounds = true

        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.white, for: .normal)
        plusButton.backgroundColor = UIColor(red: 1.0, green: 0.45, blue: 0.0, alpha: 1.0) // 주황색
        plusButton.layer.cornerRadius = 15
        plusButton.clipsToBounds = true

        minusButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)

        contentView.addSubview(containerView)
        [iconImageView, nameLabel, minusButton, quantityLabel, plusButton].forEach {
            containerView.addSubview($0)
        }
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
            $0.height.equalTo(60)
        }

        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30) // 이미지 크기
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }

        plusButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
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
        quantity = item.quantity
        quantityLabel.text = "\(quantity)"

        // 예시 이미지 넣기 (없으면 기본 이미지나 nil 가능)
        iconImageView.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
    }

    @objc private func decreaseQuantity() {
        guard quantity > 1 else { return }
        quantity -= 1
        quantityLabel.text = "\(quantity)"
        onQuantityChange?(quantity)
    }

    @objc private func increaseQuantity() {
        quantity += 1
        quantityLabel.text = "\(quantity)"
        onQuantityChange?(quantity)
    }
}
