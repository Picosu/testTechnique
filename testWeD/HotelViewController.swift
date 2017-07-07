//
//  ViewController.swift
//  testWeD
//
//  Created by Maxence de Cussac on 07/07/2017.
//  Copyright © 2017 Maxence de Cussac. All rights reserved.
//

import UIKit

let hotelCellIdentifier = "hotelCellIdentifier"
let weekendCellIdentifier = "weekendCellIdentifier"
let detailSegueIdentifier = "detailSegueIdentifier"

class HotelViewController: UITableViewController {
    
    // Attributs
    var dataSource = [WDHotel]()
    
    // Outlets
    @IBOutlet weak var hotelActivityIndicator: UIActivityIndicatorView! {
        didSet {
            self.setupSpinner()
            self.hotelActivityIndicator.layoutIfNeeded()
        }
    }
    @IBOutlet var hotelTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.retrieveDataFromApi { (hotels) in
            self.dataSource = hotels
            self.actualiserTableView()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: hotelCellIdentifier) as! HotelTableViewCell
        
        headerCell.currentHotel = dataSource[section]
        
        return headerCell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].label
    }

    
    // MARK: - UITableViewDatasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].weekends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentWeekend = dataSource[indexPath.section].weekends[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: weekendCellIdentifier) as? WeekendTableViewCell else {
            return WeekendTableViewCell(withWeekend: currentWeekend)
        }
        
        cell.currentWeekend = currentWeekend
        
        return cell
    }
    
    // MARK: - Méthodes privées
    private func actualiserTableView()
    {
        self.hotelActivityIndicator.startAnimating()
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
            self.hotelActivityIndicator.stopAnimating()
            return
        })
    }
    
    func setupSpinner(){
        self.hotelActivityIndicator.center = CGPoint(x:UIScreen.main.bounds.size.width / 2, y:UIScreen.main.bounds.size.height / 2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let weTVC = sender as? WeekendTableViewCell {
            if let detailViewController = segue.destination as? DetailsViewController {
                detailViewController.currentWeekend = weTVC.currentWeekend
            }
        }
    }
}
