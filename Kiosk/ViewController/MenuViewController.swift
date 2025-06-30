import UIKit
import SnapKit

class MenuView: UIView, UIScrollViewDelegate {
    var delegate: OrderTapDelegate?
    let menuData: [MenuItem] = [
        MenuItem(name: "연어롤초밥1", price: 3500, imageName: "salmon"),
        MenuItem(name: "연어롤초밥2", price: 3500, imageName: "salmon"),
        MenuItem(name: "연어롤초밥3", price: 3500, imageName: "salmon"),
        MenuItem(name: "연어롤초밥4", price: 3500, imageName: "salmon"),
        MenuItem(name: "연어초밥5", price: 1500, imageName: "salmon"),
        MenuItem(name: "연어초밥6", price: 1500, imageName: "salmon"),
        MenuItem(name: "연어초밥7", price: 1500, imageName: "salmon"),
        MenuItem(name: "연어초밥8", price: 1500, imageName: "salmon"),
        MenuItem(name: "사이다", price: 2000, imageName: "salmon"),
        MenuItem(name: "콜라", price: 2000, imageName: "salmon"),
        MenuItem(name: "된장국", price: 1000, imageName: "salmon"),
        MenuItem(name: "우동", price: 4000, imageName: "salmon")
    ]

    let scrollView = UIScrollView()
    let pageControl = UIPageControl()
    let cardsPerPage = 4

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupScrollView()
        setupPageControl()
        layoutCards()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
        }
    }

    private func setupPageControl() {
        let totalPages = Int(ceil(Double(menuData.count) / Double(cardsPerPage)))
        pageControl.numberOfPages = totalPages
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .gray
        addSubview(pageControl)
        pageControl.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
    }

    private func layoutCards() {
        let screenWidth = UIScreen.main.bounds.width
        let cardWidth = (screenWidth - 12 * 3 - 32) / 2
        let cardHeight: CGFloat = 140
        let cardSize = CGSize(width: cardWidth, height: cardHeight)

        for (index, item) in menuData.enumerated() {
            let page = index / cardsPerPage
            let positionInPage = index % cardsPerPage
            let row = positionInPage / 2
            let column = positionInPage % 2

            let cardView = MenuCell()
            cardView.configure(with: item)
            cardView.onPlusTapped = {
                self.delegate?.tapMenu(name: item.name)
            }
            scrollView.addSubview(cardView)
            cardView.snp.makeConstraints {
                $0.width.equalTo(cardSize.width)
                $0.height.equalTo(cardSize.height)
                $0.leading.equalTo(scrollView.snp.leading).offset(CGFloat(page) * screenWidth + 16 + CGFloat(column) * (cardSize.width + 12))
                $0.top.equalTo(scrollView.snp.top).offset(CGFloat(row) * (cardSize.height + 12) + 12)
            }
        }

        let totalPages = Int(ceil(Double(menuData.count) / Double(cardsPerPage)))
        scrollView.contentSize = CGSize(width: screenWidth * CGFloat(totalPages), height: 2 * (cardHeight + 12) + 12)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        pageControl.currentPage = page
    }
}
