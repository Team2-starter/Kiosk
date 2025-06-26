import UIKit
import SnapKit

// 메뉴 카테고리 타입
enum CategoryType: Int {
    case recommended = 0
    case sushi
    case side
}

class ViewController: UIViewController {
    
    // 카테고리 세그먼트
    let categorySegment = UISegmentedControl(items: ["추천메뉴", "초밥", "사이드"])
    var selectedCategory: CategoryType = .recommended

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCategorySegment()
    }

    // 세그먼트 UI 구성
    func setupCategorySegment() {
        view.addSubview(categorySegment)
        
        categorySegment.selectedSegmentIndex = 0
        categorySegment.addTarget(self, action: #selector(categoryChanged(_:)), for: .valueChanged)
        
        categorySegment.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // 탭 선택 시 처리
    @objc func categoryChanged(_ sender: UISegmentedControl) {
        if let category = CategoryType(rawValue: sender.selectedSegmentIndex) {
            selectedCategory = category
            print("선택된 카테고리: \(category)")
        }
    }
}

