import UIKit
import SnapKit

class MenuCell: UICollectionViewCell {
    static let identifier = "MenuCell"

    // MARK: - UI 요소
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let plusButton = UIButton(type: .system)

    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 데이터 설정
    func configure(with item: MenuItem) {
        imageView.image = UIImage(named: item.imageName)
        nameLabel.text = item.name
        priceLabel.text = "\(item.price)원"
    }

    // MARK: - UI 구성
    private func setupView() {
        // 셀 스타일
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        contentView.clipsToBounds = true

        // UI 속성 설정
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.textAlignment = .center

        priceLabel.font = .boldSystemFont(ofSize: 13)
        priceLabel.textAlignment = .center

        plusButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        plusButton.tintColor = .systemOrange

        // 하위 뷰 추가
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(plusButton)
    }

    // MARK: - 제약조건 설정
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(100)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(4)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
        }

        plusButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }
}
