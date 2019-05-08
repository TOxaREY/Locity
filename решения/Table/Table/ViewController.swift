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
var points = "88"


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var sizeFont:CGFloat = UIScreen.main.bounds.width / 11.5

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let font = UIFont(name:"Menlo-Bold", size: sizeFont / 1.25)!
        let font2 = UIFont(name:"Code New Roman", size: sizeFont / 2)!
        let font3 = UIFont(name:"Code New Roman", size: sizeFont)!
        if tableView == hTableView {
            let personH = namesH[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let name = personH.value(forKeyPath: "name") as? String
            let time = personH.value(forKeyPath: "time") as? String
            let points = personH.value(forKeyPath: "points") as? String
            let attributedText = NSMutableAttributedString(string: name! + " ", attributes: [NSAttributedString.Key.font: font])
            attributedText.append(NSMutableAttributedString(string: time!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red:0, green:0, blue:1, alpha:1.0),NSAttributedString.Key.font: font2]))
            attributedText.append(NSMutableAttributedString(string: " " + points!, attributes: [NSAttributedString.Key.font: font3]))
            cell.textLabel?.attributedText = attributedText
            cell.textLabel?.textAlignment = .right
            return cell
        } else if tableView == eTableView {
            let personE = namesE[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            let name = personE.value(forKeyPath: "name") as? String
            let time = personE.value(forKeyPath: "time") as? String
            let points = personE.value(forKeyPath: "points") as? String
            let attributedText = NSMutableAttributedString(string: name! + " ", attributes: [NSAttributedString.Key.font: font])
            attributedText.append(NSMutableAttributedString(string: time!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red:0, green:0, blue:1, alpha:1.0),NSAttributedString.Key.font: font2]))
            attributedText.append(NSMutableAttributedString(string: " " + points!, attributes: [NSAttributedString.Key.font: font3]))
            cell.textLabel?.attributedText = attributedText
            cell.textLabel?.textAlignment = .right
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
                self.loadSortPoints()
                hTableView.reloadData()
            } else if tableView == eTableView {
                let row = namesE[indexPath.row]
                managedContext.delete(row)
                appDelegate!.saveContext()
                self.loadSortPoints()
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
    func saveE(name: String, time: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PersonE", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(name, forKeyPath: "name")
        person.setValue(points, forKey: "points")
        person.setValue(time, forKey: "time")
        do {
            try managedContext.save()
            namesE.append(person)
        } catch let error as NSError {
            print("Could not saveE. \(error)")
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sizeFont + 5.0
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        /////
        diff = "E"
        /////
        if points.count == 1 {
            points.append("00")
            points = String(points.reversed())
        } else if points.count == 2 {
            points = String(points.reversed())
            points.append("0")
            points = String(points.reversed())
        }
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
        dff.dateFormat = "yyyy-MM-dd"
        let time: String = dff.string(from: date)
        
        let alert = UIAlertController(title: "Add Name", message: nil, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            let textField = alert.textFields?.first
            var nameToSave = String()
            if textField!.text!.count > 10 {
                nameToSave = String(textField!.text!.dropLast(textField!.text!.count - 10))
            } else {
                nameToSave = textField!.text!
            }

            if diff == "H" {
                self.saveH(name: nameToSave, time: time)
                self.loadSortPoints()
                self.hTableView.reloadData()
            } else if diff == "E" {
                self.saveE(name: nameToSave, time: time)
                self.loadSortPoints()
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
        loadSortPoints()
    }
    func loadSortPoints() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonH")
        let fetchRequest2 = NSFetchRequest<NSManagedObject>(entityName: "PersonE")
        let sort = NSSortDescriptor(key: "points", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest2.sortDescriptors = [sort]
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


