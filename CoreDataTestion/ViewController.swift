//
//  ViewController.swift
//  CoreDataTestion
//
//  Created by Edward O'Neill on 1/15/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        scoreLabel.text = "Score: \(score)"
        
    }

    @IBAction func increceScore(_ sender: UIButton) {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @IBAction func saveScore(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Device", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        newEntity.setValue(score, forKey: "number")
        
        do {
            try context.save()
            print("saved")
        } catch {
            print("Filed saving \(error)")
        }
        
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Device")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                score = data.value(forKey: "number") as! Int
            }
            
        } catch {
            print("Falied getting data \(error)")
        }
    }
}

