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
        
        let horizontalStackView = makeHorizontalStackView(buttons)
        
        addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints {make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(280)
            make.height.equalTo(50)
        }
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
        
        switch sender.tag {
        case 0: delegate?.didSelectCategory(.recommendation)
        case 1: delegate?.didSelectCategory(.sushi)
        case 2: delegate?.didSelectCategory(.side)
        default: break
        }
        
        for button in buttons {
            button.isSelected = false
            button.setTitleColor(.black, for: .normal)
        }
        
        sender.isSelected = true
        sender.setTitleColor(.orange, for: .normal)
        
    }
}
