//
//  StatementViewController.swift
//  santander-test-clean-swift
//
//  Created by Cesar Giupponi Paiva on 12/04/19.
//  Copyright (c) 2019 Cesar Paiva. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol StatementDisplayLogic: class {
    func displayStatements(statement: [Statements.Data.Statement])
    func showAlert(title: String, message: String)
    func displayUserAccountInfo(userAccountInfo: LoginModel.Data.UserAccount)
}

class StatementViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, StatementDisplayLogic {
    
    var interactor: StatementBusinessLogic?
    var router: (NSObjectProtocol & StatementRoutingLogic & StatementDataPassing)?
    
    var userId: String?
    var statements: [Statements.Data.Statement] = []

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = StatementInteractor()
    let presenter = StatementPresenter()
    let router = StatementRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.statementViewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.registerXib()
    self.setupTableView()
    getUserId()
    getUserAccountInfo()
    getStatements()
  }
  
  // MARK: Do something
  
    @IBOutlet weak var labelClientName: UILabel!
    @IBOutlet weak var labelAccountNumber: UILabel!
    @IBOutlet weak var labelBalance: UILabel!
    @IBOutlet weak var tableViewStatement: UITableView!

    private func registerXib() {
        let xib = UINib(nibName: "StatementTableViewCell", bundle: nil)
        self.tableViewStatement.register(xib, forCellReuseIdentifier: "statementCell")
    }
    
    private func setupTableView() {
        tableViewStatement.dataSource = self
        tableViewStatement.delegate = self
        
        tableViewStatement.rowHeight = UITableView.automaticDimension
        tableViewStatement.estimatedRowHeight = 104
    }
    
    func displayUserAccountInfo(userAccountInfo: LoginModel.Data.UserAccount) {
        self.labelClientName.text = userAccountInfo.name
        if let agency = userAccountInfo.agency, let bankAccount = userAccountInfo.bankAccount {
            self.labelAccountNumber.text = "\(bankAccount) / \(agency.maskAgency())"
        }
        if let balance = userAccountInfo.balance {
            self.labelBalance.text = Double(balance).currency
        }
        if let id = userAccountInfo.userId {
            self.userId = String(id)
        }
        
    }
    
    private func getUserId() {
        if let userId = router?.dataStore?.userAccount?.userId {
            self.userId = String(userId)
        }
    }
    
    func getUserAccountInfo() {
        interactor?.getUserAccountInfo()
    }
    
    func getStatements() {
        if let userId = self.userId {
            interactor?.getStatementsByUser(userId: userId)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewStatement.dequeueReusableCell(withIdentifier: "statementCell") as! StatementTableViewCell
        cell.setStatement(statement: self.statements[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titleHeaderSection = "Recentes"
        return titleHeaderSection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let heightHeaderSection = CGFloat(42)
        return heightHeaderSection
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.textColor = UIColor(red: 0.28, green: 0.33, blue: 0.4, alpha: 1.0)
        headerView.textLabel?.font = UIFont(name: "HelveticaNeue", size: 17)
        headerView.textLabel?.frame = headerView.frame
        headerView.textLabel?.textAlignment = .left
        headerView.backgroundView?.backgroundColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
  
    func displayStatements(statement: [Statements.Data.Statement]) {
        self.statements = statement
        self.tableViewStatement.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        interactor?.clearUserDefaults()
        self.navigationController?.popViewController(animated: true)
    }

}
