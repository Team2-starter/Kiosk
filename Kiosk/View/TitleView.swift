import UIKit
import SnapKit

enum MenuType {
    case recommendation
    case sushi
    case side
}

protocol MenuCategoryDelegate: AnyObject {
    func didSelectCategory(_ type: MenuType)
}

class TitleView: UIView {

    var buttons: [UIButton] = []
    var underlineViews: [UIView] = []
    weak var delegate: MenuCategoryDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupStackView() {
        self.buttons = createButton(titles: ["추천메뉴", "초밥류", "사이드"])

        var verticalStacks: [UIStackView] = []

        for (index, button) in buttons.enumerated() {
            let underline = UIView()
            underline.backgroundColor = UIColor(red: 0.9, green: 0.93, blue: 0.96, alpha: 1.0) // 연회색
            underline.isHidden = false
            underline.layer.cornerRadius = 1.5
            underlineViews.append(underline)

            let verticalStack = UIStackView(arrangedSubviews: [button, underline])
            verticalStack.axis = .vertical
            verticalStack.spacing = 4
            verticalStack.alignment = .center
            verticalStack.distribution = .equalSpacing

            underline.snp.makeConstraints { make in
                make.width.equalTo(40)
                make.height.equalTo(3)
            }

            button.snp.makeConstraints { make in
                make.bottom.equalTo(underline.snp.top).offset(-2)
            }

            verticalStacks.append(verticalStack)
        }

        let horizontalStackView = UIStackView(arrangedSubviews: verticalStacks)
        horizontalStackView.spacing = 20
        horizontalStackView.distribution = .fillEqually

        addSubview(horizontalStackView)

        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(280)
            make.height.equalTo(70)
        }

        // 초기 상태에서 첫 번째 버튼 활성화
        setSelected(index: 0)
    }

    func makeHorizontalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }

    func createButton(titles: [String]) -> [UIButton] {
        var buttons: [UIButton] = []

        for (index, title) in titles.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            button.tag = index
            button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
            buttons.append(button)
        }

        return buttons
    }

    @objc func handleButtonTap(sender: UIButton) {
        print("\(sender.currentTitle ?? "") 버튼이 탭되었습니다.")

        setSelected(index: sender.tag)

        switch sender.tag {
        case 0: delegate?.didSelectCategory(.recommendation)
        case 1: delegate?.didSelectCategory(.sushi)
        case 2: delegate?.didSelectCategory(.side)
        default: break
        }
    }

    func setSelected(index: Int) {
        for (i, button) in buttons.enumerated() {
            let isSelected = (i == index)
            button.setTitleColor(isSelected ? .orange : .black, for: .normal)
            // underlineViews[i].isHidden = !isSelected
        }
    }
}
