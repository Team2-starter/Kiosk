// CartViewController.swift (변경 없음)

import UIKit
import SnapKit

protocol OrderTapDelegate: AnyObject {
    func tapMenu(name: String)
}

class KioskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UI Components
    let titleView = TitleView()
    let menuView = MenuView()
    let tableView = UITableView()
    let titleLabel = UILabel()
    let tableLabel = UILabel()
    let solidLineView1 = UIView()
    let solidLineView2 = UIView()
    let finalPriceTitleLabel = UILabel()
    let totalPriceLabel = UILabel()
    let cancelButton = UIButton(type: .system)
    let payButton = UIButton(type: .system)
    let bottomContainer = UIView()
    
    let deepOrange = UIColor(red: 1.0, green: 0.45, blue: 0.0, alpha: 1.0)
    
    // MARK: Data
    
    var orderItems: [OrderItem] = []
    
    var hasOrder: Bool {
        orderItems.reduce(0) { $0 + $1.quantity } > 0
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        updateTotalPrice()
        titleView.delegate = self
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleView)
        view.addSubview(menuView)
        menuView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartItemCell.self, forCellReuseIdentifier: "CartItemCell")
        
        titleLabel.text = "장바구니"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        solidLineView1.backgroundColor = .lightGray
        solidLineView2.backgroundColor = .lightGray
        
        finalPriceTitleLabel.text = "결제 금액"
        finalPriceTitleLabel.font = .boldSystemFont(ofSize: 18)
        
        totalPriceLabel.font = .boldSystemFont(ofSize: 18)
        totalPriceLabel.textAlignment = .right
        
        cancelButton.setTitle("취소하기", for: .normal)
        cancelButton.backgroundColor = .white
        cancelButton.setTitleColor(deepOrange, for: .normal)
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 2
        cancelButton.layer.borderColor = deepOrange.cgColor
        cancelButton.addTarget(self, action: #selector(cancelOrder), for: .touchUpInside)
        
        payButton.setTitle("결제하기", for: .normal)
        payButton.backgroundColor = deepOrange
        payButton.setTitleColor(.white, for: .normal)
        payButton.layer.cornerRadius = 10
        payButton.layer.borderWidth = 2
        payButton.layer.borderColor = deepOrange.cgColor
        payButton.addTarget(self, action: #selector(payOrder), for: .touchUpInside)
        
        
        view.addSubview(bottomContainer)
        [titleLabel, solidLineView1, tableView, solidLineView2, finalPriceTitleLabel, totalPriceLabel, cancelButton, payButton].forEach {
            bottomContainer.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(250)
            $0.height.equalTo(80)
        }
        
        menuView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(-20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(390)
        }
        
        bottomContainer.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(350)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(bottomContainer).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        solidLineView1.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(solidLineView1.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(150) // 셀 4개 높이
        }
        solidLineView2.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalTo(finalPriceTitleLabel.snp.top).offset(-8)
        }
        
        finalPriceTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(cancelButton.snp.top).offset(-12)
            $0.height.equalTo(40)
            $0.width.equalTo(80)
        }
        
        totalPriceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(finalPriceTitleLabel)
            $0.height.equalTo(40)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.bottom.equalToSuperview().offset(-12)
            $0.width.equalTo(140)
            $0.height.equalTo(50)
        }
        
        payButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-12)
            $0.width.equalTo(140)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: Logic
    
    func updateTotalPrice() {
        let total = orderItems.reduce(0) { $0 + $1.quantity * 10000 }
        totalPriceLabel.text = "\(total)원"
    }
    
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
        }
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemCell
        let item = orderItems[indexPath.row]
        cell.configure(with: item)
        cell.onQuantityChange = { [weak self] newQty in
            self?.orderItems[indexPath.row].quantity = newQty
            self?.updateTotalPrice()
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell
    }
}

extension KioskViewController: OrderTapDelegate {
    func tapMenu(name: String) {
        if let index = orderItems.firstIndex(where: { orderItem in
            orderItem.name == name
        }) {
            orderItems[index].quantity += 1
        } else {
            let newMenu = OrderItem(name: name, quantity: 1)
            orderItems.append(newMenu)
        }
        tableView.reloadData()
        updateTotalPrice()
    }
}
extension KioskViewController: MenuCategoryDelegate {
    func didSelectCategory(_ type: MenuType) {
        menuView.changeMenu(to: type)
    }
}
