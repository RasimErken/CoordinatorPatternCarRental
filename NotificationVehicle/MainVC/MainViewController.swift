//
//  ViewController.swift
//  NotificationVehicle
//
//  Created by rasim rifat erken on 31.08.2022.
//

import UIKit



class MainViewController: UIViewController ,  UITableViewDataSource , UITableViewDelegate , UISearchResultsUpdating   {
    
    var coordinator : MainViewCoordinator?
    
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel = VehicleViewModel()
    var schoolList : [VehicleData]?
    var filtered = [VehicleData]()
    var vehiclePhotoList : [Included]?
    

    let tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height ))
        table.register( TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return table
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        tableView.dataSource = self
        tableView.delegate = self

        tableView.rowHeight = 150
        
        setupSearchController()
        
        viewModel.getALLData { [weak self] in
            self?.schoolList = self?.viewModel.vehicleName
            self?.vehiclePhotoList = self?.viewModel.vehiclePhoto
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let LogOutBtn = UIBarButtonItem()
        LogOutBtn.title = "Log Out"
        LogOutBtn.style = .plain
        LogOutBtn.target = self
        LogOutBtn.action = #selector(logOut(sender:))
        self.navigationItem.setRightBarButton(LogOutBtn, animated: true)
        
     
        
        
        
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return self.filtered.count
        }
        return schoolList?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {return UITableViewCell()}
        
        var nycHighSchoolList: VehicleData?
        
        if isFiltering() {
            nycHighSchoolList = filtered[indexPath.row]
        } else {
            nycHighSchoolList = schoolList?[indexPath.row]
        }
        
        if let a = nycHighSchoolList {
            cell.setupCell(withVehicleData: a)
        }
        
        
        
        for i in 0...390 {
            if vehiclePhotoList?[i].id == schoolList?[indexPath.row].relationships.primary_image.data.id {
                if let b = vehiclePhotoList?[i] {
                    cell.setupCellPhoto(withVehiclePhoto: b)
                }
                
            }
        }
        
        return cell
    }
    
    @objc func logOut(sender: UIBarButtonItem) {
        coordinator?.coordinateToLogInVC()
    }
    
    func goToLogin() {
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
    
    
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Vehicles"
        searchController.searchBar.tintColor = UIColor.white
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filtered = (schoolList!.filter({( schools : VehicleData) -> Bool in
            return schools.attributes.name.lowercased().contains(searchText.lowercased())
        }))
        
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}



