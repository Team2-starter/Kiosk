초밥 키오스크
Ios용 초밥 주문 앱입니다. 사용자는 다양한 초밥을 선택해 장바구니에 담고 주문할 수 있습니다.

프로잭트 개요
목적:손쉽게 초밥을 주문할 수 있는 키오스크 앱 제작
UI기반: UIKit 사용, 직관적인 인터페이스로 사용자 편의성 강조

##Features
다양한 초밥종류 제공
장바구니 담기 및 수량 조절
주문확인 및 취소버튼

데이터 모델
```swift
struct MenuItem {
    let name: String
    let price: Int
    let imageName: String
}
struct OrderItem {
    let name: String
    var quantity: Int
    let imageName: String
}

Part
1. `KioskViewController`
- 전체 화면을 구성하는 메인 컨트롤러
- 상단 카테고리 (`TitleView`), 메뉴 카드 뷰 (`MenuView`), 장바구니 UI를 포함
- 주문 목록, 총 결제 금액 계산 및 UI 업데이트
- 결제 및 주문 취소 로직 포함

2. `TitleView`
- 추천메뉴 / 초밥류 / 사이드 메뉴를 전환할 수 있는 카테고리
- 선택된 버튼에 밑줄과 색상 강조
- `MenuCategoryDelegate`를 통해 선택된 메뉴 타입을 컨트롤러에 전달

3. `MenuView`
- 선택된 카테고리별 메뉴 아이템을 카드 형식으로 표시
- 2행 2열의 카드 구성, 한 페이지에 4개씩 표시 (가로 스크롤)
- 메뉴 추가 버튼 탭 시 `OrderTapDelegate`를 통해 주문 항목에 추가
- `UIPageControl`로 현재 페이지 표시

4. `MenuCell`
- 메뉴 이미지, 이름, 가격, + 버튼이 포함된 카드 셀
- + 버튼 클릭 시 외부 클로저(`onPlusTapped`)를 통해 이벤트 전달

5. `CartItemCell`
- 장바구니 리스트 셀
- - / + 버튼을 통해 수량을 조절하며, 수량 변경은 클로저(`onQuantityChange`)로 외부에 전달
- 메뉴 이미지와 이름이 포함된 미니 카드 스타일


사용기술
Swift + UIKit + SnapKit
스토리보드 기반 화면 구성
MVC 아키텍쳐 적용

알림창 띄우기 
        @objc func cancelOrder() {
        let alert = UIAlertController(title: "주문 취소", message: "정말 주문을 취소하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "아니요", style: .cancel))
        alert.addAction(UIAlertAction(title: "네", style: .destructive, handler: { _ in
            self.orderItems.removeAll()
            self.tableView.reloadData()
            self.updateTotalPrice()
        }))
        present(alert, animated: true)
    }
    
    @objc func payOrder() {
        if !hasOrder {
            let alert = UIAlertController(title: "알림", message: "주문할 메뉴가 없습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "결제 완료", message: "주문이 정상적으로 결제되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                self.orderItems.removeAll()
                self.tableView.reloadData()
                self.updateTotalPrice()
            }))
            present(alert, animated: true)


SnapKit을 활용한 오토레이아웃
            nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(12)
            $0.right.lessThanOrEqualToSuperview().inset(12)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.left.equalTo(nameLabel)
        }

델리게이트 & 클로저
- `MenuCategoryDelegate`: 카테고리 버튼 → 메뉴 뷰 갱신
- `OrderTapDelegate`: 메뉴+버튼 → 주문 추가
- `onQuantityChange`: 장바구니 셀에서 수량 조절
- `onPlusTapped`: 메뉴에서 메뉴 선택


//feature/menuSection
//담당자:이서범
//feature/cartsection
//담담자:김재만
//feature/titleSection
//담당자:정수용











