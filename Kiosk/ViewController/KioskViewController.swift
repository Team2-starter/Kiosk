import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // 메뉴 데이터
    let menuList: [MenuItem] = Array(repeating: MenuItem(name: "연어롤초밥", price: 3500, imageName: "salmon"), count: 6)
    
    // 컬렉션 뷰 레이아웃 설정
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 190)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    // 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        layoutCollectionView()
    }

    // 컬렉션뷰 설정
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
    }

    // SnapKit 제약
    func layoutCollectionView() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - 데이터소스, 델리게이트
extension KioskViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
        let item = menuList[indexPath.item]
        cell.configure(with: item)
        return cell
    }
}
