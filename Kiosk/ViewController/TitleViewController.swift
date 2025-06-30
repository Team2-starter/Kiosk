import UIKit
import SnapKit

class TitleViewController: UIViewController {
    
    var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
    }
    
    func setupStackView() {
        self.buttons = createButton(titles: ["추천메뉴", "초밥류", "사이드"])
        
        let horizontalStackView = makeHorizontalStackView(buttons)
        
        view.addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints {make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
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
        
        for title in titles {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
            
            buttons.append(button)
        }
        
        return buttons
    }
    
    @objc func handleButtonTap(sender: UIButton) {
        print("\(sender.currentTitle ?? "") 버튼이 탭되었습니다.")
        
        
        for button in buttons {
            button.isSelected = false
            button.setTitleColor(.black, for: .normal)
        }
        
        sender.isSelected = true
        sender.setTitleColor(.orange, for: .normal)
        
    }
}
