//
//  ListCatViewController.swift
//  CatApp
//
//  Created by Escurra Colquis on 29/11/22.
//

import UIKit
import AlamofireImage

// MARK: - ListCatViewProtocol
protocol ListCatViewProtocol: AnyObject {
    func showListCat(cat: [CatResponse])
    func showProgressView()
    func hideProgressView()
}

class ListCatViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var listCatTableView: UITableView!
    
    // MARK: - Properties
    var presenter: ListCatPresenterProtocol?
    var listCatConfigurator: ListCatConfiguratorProtocol?
    var refresh: UIRefreshControl!
    var arrayListCat: [CatResponse]? = []
    var listCat: [CatResponse]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshService()
        configureListCat()
        presenter?.getListCat()
    }
    
    //MARK: - Functions
    private func configureListCat() {
        listCatConfigurator = ListCatConfigurator()
        listCatConfigurator?.configureListCatView(viewController: self)
    }
    
    private func setupRefreshService() {
        self.refresh = UIRefreshControl()
        self.listCatTableView.alwaysBounceVertical = true
        self.refresh?.tintColor = UIColor.gray
        self.refresh?.backgroundColor = UIColor.white
        self.refresh?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        self.refresh?.attributedTitle = NSAttributedString(string: NSLocalizedString("refreshData", comment: "refreshData"), attributes: attributes)
        self.listCatTableView.addSubview(refresh)
    }
    
    @objc func refreshData() {
        DispatchQueue.main.async {
            self.listCatTableView.reloadData()
        }
        stopRefreshData()
    }
    
    private func stopRefreshData() {
        self.refresh?.endRefreshing()
    }
    
    private func setupTableView() {
        listCatTableView.delegate = self
        listCatTableView.dataSource = self
        listCatTableView.register(UINib(nibName: ListCatTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ListCatTableViewCell.nibName)
        listCatTableView.separatorStyle = .none
    }
}

// MARK: - UITableViewDelegate - UITableViewDataSource
extension ListCatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowListCat = arrayListCat {
            return rowListCat.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listCatTableView.dequeueReusableCell(withIdentifier: ListCatTableViewCell.nibName, for: indexPath) as? ListCatTableViewCell
        cell?.nameCatLabel.text = "\(NSLocalizedString("nameCat", comment: "nameCat"))" + "\(arrayListCat?[indexPath.row].name ?? "")"
        cell?.countryCatLabel.text = "\(NSLocalizedString("countryCat", comment: "countryCat"))" + "\(arrayListCat?[indexPath.row].origin ?? "")"
        cell?.intelligenceCatLabel.text = arrayListCat?[indexPath.row].origin
        let intelligence: Int = arrayListCat?[indexPath.row].intelligence ?? 0
        let value = String(describing: intelligence)
        cell?.intelligenceCatLabel.text = "\(NSLocalizedString("intelligenceCat", comment: "intelligenceCat"))" + "\(value)"
        let urlPhotoCat = arrayListCat?[indexPath.row].image?.url
        let url = urlPhotoCat
        let urlPhotoCatOptional = (url != nil) ? (url ?? "") : ""
        if let url = URL(string: urlPhotoCatOptional){
            cell?.iconCatImageView.af.setImage(withURL: url, placeholderImage:  UIImage(named: "shop-placeholder"))
        }
        let borderColorViewA = UIColor(named: "borderWhite")
        cell?.iconCatImageView.layer.borderColor = borderColorViewA?.cgColor
        cell?.iconCatImageView.layer.borderWidth = 2.0
        cell?.iconCatImageView.layer.cornerRadius = 20
        cell?.iconCatImageView.layer.masksToBounds = true
        cell?.selectionStyle = .none
        cell?.layer.cornerRadius = 10
        cell?.backgroundColor = UIColor.clear
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ListCatTableViewCell.sizeListCat
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset < -95 {
            self.refresh.attributedTitle = NSAttributedString(string: NSLocalizedString("successData", comment: "successData"), attributes: [NSAttributedString.Key.foregroundColor: refresh.tintColor!])
        } else {
            self.refresh.attributedTitle = NSAttributedString(string: NSLocalizedString("refreshData", comment: "refreshData"), attributes: [NSAttributedString.Key.foregroundColor: refresh.tintColor!])
        }
        self.refresh?.backgroundColor = UIColor.white
    }
}

// MARK: - ListCatViewProtocol
extension ListCatViewController: ListCatViewProtocol {
    func showListCat(cat: [CatResponse]) {
        arrayListCat = cat
        listCat?.insert(contentsOf: cat, at: 0)
        listCatTableView.reloadData()
    }
    
    func showProgressView() {
        let progress = MBProgressHUD.showAdded(to: self.view, animated: true)
        progress.label.text = NSLocalizedString("loadData", comment: "loadData")
        progress.detailsLabel.text = NSLocalizedString("pleaseWait", comment: "pleaseWait")
        progress.isUserInteractionEnabled = false
    }
    
    func hideProgressView() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
