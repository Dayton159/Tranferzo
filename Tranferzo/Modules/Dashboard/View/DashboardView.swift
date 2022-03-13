//
//  DashboardView.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

import UIKit

class DashboardView: BaseView, DashboardViewProtocol, AlertPopUpPresentable {

  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  
  private lazy var headerView: DashboardHeaderView = {
    let header = DashboardHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 235))
    return header
  }()
  
  var transactionLists: [[TransactionModel]] = [] {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  private let status: String
  private let secrets: SecretStore
  var loadBalances: (() -> Void)?
  var loadTransactions:(() -> Void)?
  var logOutSelected:(() -> Void)?
  
  
  // MARK: - Initializers
  init(status: String, secrets: SecretStore) {
    self.status = status
    self.secrets = secrets
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureNavBar()
    self.configureRightBarButtonItem(title: "Log Out")
    self.bindView()
    self.configureTableView()
    self.loadBalances?()
    self.loadTransactions?()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.showError(title: "\(status)!", errorMessage: status)
  }
  
  // MARK: - Helpers
  func didGetBalance(with balance: BalanceModel) {
    self.headerView.configureView(with: balance, holder: UserData.accHolder)
  }
  
  func showError(by message: String) {
    Delay.wait {
      self.showError(errorMessage: message)
    }
  }
  
  func state(_ state: NetworkState) {
    switch state {
    case .loading:
      self.showLoader()
    default:
      self.hideLoader()
    }
  }
  
  func configureTableView() {
    self.tableView.registerReusableCell(TransactionTableViewCell.self)
    self.tableView.tableHeaderView = headerView
    self.tableView.tableFooterView = UIView()
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = UITableView.automaticDimension
    self.tableView.separatorStyle = .none
    self.tableView.contentInsetAdjustmentBehavior = .never
    self.tableView.dataSource = self
    self.tableView.delegate = self
  }
  
  func bindView() {
    self.barBtn.addTarget(self, action: #selector(self.didTapRightBarBtn(_:)), for: .touchUpInside)
  }
  
  // MARK: - Selector
  @objc func didTapRightBarBtn(_ sender: UIButton) {
    do {
      try secrets.removeValue(for: Secrets.authJwtToken)
      UserData.accHolder = ""
      self.logOutSelected?()
    } catch {
      self.showError(title: "Log Out Failed", errorMessage: error.localizedDescription)
    }
  }
}

// MARK: - Extensions
extension DashboardView: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.transactionLists.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.transactionLists[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: TransactionTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
    let data = self.transactionLists[indexPath.section][indexPath.row]
    cell.configureCell(with: data)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 40
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let data = self.transactionLists[section].first?.date
    let header = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
    header.configureView(with: data)
    
    return header
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footer = SectionFooterView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
    return footer
  }
}
