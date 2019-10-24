//
//  ViewControllerFinish.swift
//  Locity
//
//  Created by REYNIKOV ANTON on 08/05/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit
import CoreData

extension UITextView {
    
    func centerVertically() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect
        self.contentInset.top = topCorrect
    }
}

class ViewControllerFinish: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var sizeFont:CGFloat = UIScreen.main.bounds.width / 11.5
    var namesH: [NSManagedObject] = []
    var namesE: [NSManagedObject] = []
    
    
    
    @IBOutlet weak var textInfo: UITextView!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var viewBg2: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var cancelImage: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func cancelButton(_ sender: Any) {
        infoView.isHidden = true
        viewBg.backgroundColor = UIColor.clear
        viewBg2.backgroundColor = UIColor.clear
        hardLabel.backgroundColor = UIColor.clear
        easyLabel.backgroundColor = UIColor.clear
    }
    @IBOutlet weak var hardLabel: UILabel!
    @IBOutlet weak var easyLabel: UILabel!
    @IBOutlet weak var hTableView: UITableView!
    @IBOutlet weak var eTableView: UITableView!
    @IBOutlet weak var finishHomeImage: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBAction func infoButton(_ sender: Any) {
        infoView.isHidden = false
        viewBg.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        viewBg2.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        hardLabel.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        easyLabel.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    }
    @IBOutlet weak var infoImageGG: UIImageView!
    @IBAction func homeButton(_ sender: Any) {
        diff = ""
        round = 1
        points = "0"
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let sB: UIStoryboard = UIStoryboard(name: nameStoryboard, bundle: nil)
        let newVC = sB.instantiateViewController(withIdentifier: "VCS")
        appDel.window?.rootViewController = newVC
        appDel.window?.makeKeyAndVisible()
    }
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
            attributedText.append(NSMutableAttributedString(string: time!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: font2]))
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
            attributedText.append(NSMutableAttributedString(string: time!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font: font2]))
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
    @objc func homeButtonEnable() {
        finishHomeImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        infoImageGG.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        finishHomeImage.isHidden = false
        infoImageGG.isHidden = false
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            self?.finishHomeImage.transform = .identity
            self?.infoImageGG.transform = .identity
        }, completion: { done in
            self.homeButton.isEnabled = true
            self.infoButton.isEnabled = true
        })
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "homeButtonEnable"), object: nil)
    }
    
    
    deinit {
        print("deinitVCF")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textInfo.centerVertically()
        textInfo.isEditable = false
        textInfo.dataDetectorTypes = .all
        infoView.layer.cornerRadius = 10
        infoView.isHidden = true
        homeButton.isEnabled = false
        infoButton.isEnabled = false
        hardLabel.font = hardLabel.font.withSize(sizeFont)
        easyLabel.font = easyLabel.font.withSize(sizeFont)
        finishHomeImage.isHidden = true
        infoImageGG.isHidden = true
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
        NotificationCenter.default.addObserver(self, selector: #selector(homeButtonEnable), name: NSNotification.Name(rawValue: "homeButtonEnable"), object: nil)
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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "waveAndShip"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            action in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "waveAndShip"), object: nil)
        }
        
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
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        NotificationCenter.default.removeObserver(self)
    }
}
