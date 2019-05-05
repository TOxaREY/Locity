//
//  ViewController.swift
//  Table
//
//  Created by REYNIKOV ANTON on 04/05/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import CoreData

var diff = String()
var points = "0008"


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == hTableView {
            let personH = namesH[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let name = personH.value(forKeyPath: "name") as? String
            let time = personH.value(forKeyPath: "time") as? String
            let points = personH.value(forKeyPath: "points") as? String
            cell.textLabel?.text = name! + time! + points!
            return cell
        } else if tableView == eTableView {
            let personE = namesE[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            cell.textLabel?.text = personE.value(forKeyPath: "name") as? String
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = Int()
        if tableView == hTableView {
            count = namesH.count
        } else if tableView == eTableView {
            count = namesE.count
        }
        return count
    }


    
    
    
    @IBOutlet weak var hTableView: UITableView!
    @IBOutlet weak var eTableView: UITableView!
    @IBAction func but(_ sender: Any) {

    }
    
    var namesH: [NSManagedObject] = []
    var namesE: [NSManagedObject] = []

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        if editingStyle == .delete {
             if tableView == hTableView {
                let row = namesH[indexPath.row]
                managedContext.delete(row)
                appDelegate!.saveContext()
                self.ddd()
                hTableView.reloadData()
            } else if tableView == eTableView {
                let row = namesE[indexPath.row]
                managedContext.delete(row)
                appDelegate!.saveContext()
                do {
                    namesE = try managedContext.fetch(PersonE.fetchRequest())
                } catch {
                    print("Fetching Failed")
                }
                eTableView.reloadData()
            }
        }
    }

    func saveH(name: String, time: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PersonH", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(name, forKeyPath: "name")
        person.setValue(points, forKey: "points")
        person.setValue(time, forKey: "time")
        do {
            try managedContext.save()
            namesH.append(person)
        } catch let error as NSError {
            print("Could not saveH. \(error)")
        }
    }
    func saveE(name: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PersonE", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(name, forKeyPath: "name")
        do {
            try managedContext.save()
            namesE.append(person)
        } catch let error as NSError {
            print("Could not saveE. \(error)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diff = "H"
        hTableView.dataSource = self
        hTableView.delegate = self
        hTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        eTableView.dataSource = self
        eTableView.delegate = self
        eTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let date = Date()
        let dff = DateFormatter()
        dff.dateFormat = "yyyy-MM-dd HH:mm"
        let time: String = dff.string(from: date)
        
        let alert = UIAlertController(title: "Add Name", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            if diff == "H" {
                self.saveH(name: nameToSave, time: time)
                self.ddd()
                self.hTableView.reloadData()
            } else if diff == "E" {
                self.saveE(name: nameToSave)
                self.eTableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ddd()
    }
    func ddd() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonH")
        let fetchRequest2 = NSFetchRequest<NSManagedObject>(entityName: "PersonE")
        let sort = NSSortDescriptor(key: "points", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            namesH = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        do {
            namesE = try managedContext.fetch(fetchRequest2)
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
    }
}


