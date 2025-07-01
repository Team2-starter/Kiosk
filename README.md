# iOS 키오스크 앱 - UIKit + SnapKit 기반 주문 시스템

이 프로젝트는 iOS UIKit과 SnapKit을 활용해 **초밥 키오스크 주문 시스템**을 구축한 예제입니다.  
사용자는 메뉴를 선택하고 장바구니에 담아 결제할 수 있으며, 페이지별로 구성된 메뉴 UI, 직관적인 버튼 인터랙션을 제공합니다.

---

##  프로젝트 구성도

```
KioskViewController (Main UI)
├── TitleView (카테고리 버튼 + 밑줄)
├── MenuView (스크롤형 메뉴 카드 UI)
│   └── MenuCell (UICollectionView 형식 메뉴 카드)
├── CartItemCell (UITableView 셀 - 장바구니 항목)
├── MenuItem, OrderItem (데이터 모델)
└── Delegate Pattern (카테고리 전환 및 메뉴 추가 처리)
```

---

##  주요 컴포넌트

###  1. `KioskViewController`

- 전체 화면을 구성하는 메인 컨트롤러
- 상단 카테고리 (`TitleView`), 메뉴 카드 뷰 (`MenuView`), 장바구니 UI를 포함
- 주문 목록, 총 결제 금액 계산 및 UI 업데이트
- 결제 및 주문 취소 로직 포함

###  2. `TitleView`

- 추천메뉴 / 초밥류 / 사이드 메뉴를 전환할 수 있는 **카테고리 탭**
- 선택된 버튼에 밑줄과 색상 강조
- `MenuCategoryDelegate`를 통해 선택된 메뉴 타입을 컨트롤러에 전달

###  3. `MenuView`

- 선택된 카테고리별 메뉴 아이템을 카드 형식으로 표시
- 2행 2열의 카드 구성, 한 페이지에 4개씩 표시 (가로 스크롤)
- 메뉴 추가 버튼 탭 시 `OrderTapDelegate`를 통해 주문 항목에 추가
- `UIPageControl`로 현재 페이지 표시

### 4. `MenuCell`

- 메뉴 이미지, 이름, 가격, + 버튼이 포함된 카드 셀
- + 버튼 클릭 시 외부 클로저(`onPlusTapped`)를 통해 이벤트 전달

###  5. `CartItemCell`

- 장바구니 리스트 셀
- - / + 버튼을 통해 수량을 조절하며, 수량 변경은 클로저(`onQuantityChange`)로 외부에 전달
- 메뉴 이미지와 이름이 포함된 미니 카드 스타일

---

##  데이터 모델

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
```

---

##  델리게이트 & 클로저

- `MenuCategoryDelegate`: 카테고리 버튼 → 메뉴 뷰 갱신
- `OrderTapDelegate`: 메뉴 카드 +버튼 → 주문 추가
- `onQuantityChange`: 장바구니 셀에서 수량 조절
- `onPlusTapped`: 메뉴 카드에서 메뉴 선택

---

##  UI 특징

- SnapKit을 활용한 오토레이아웃
- 모든 UI 요소는 코드로 구성
- iPhone 기준에 맞춘 카드 레이아웃
- 카드마다 corner radius, border 처리로 깔끔한 UI 구현

---

##  향후 확장 아이디어

- 가격 포맷을 `NumberFormatter`로 처리
- 장바구니에 동일한 메뉴 누적 시 중복 방지
- 결제 금액 변동에 따른 애니메이션 효과
- 메뉴 정렬 or 필터 기능 추가

---

## 🛠 사용 기술

- UIKit
- SnapKit
- Delegate Pattern
- Closure-based Event Handling
