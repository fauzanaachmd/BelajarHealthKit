//
//  ViewController.swift
//  BelajarHealthKit
//
//  Created by Fauzan Achmad on 18/09/19.
//  Copyright © 2019 Fauzan Achmad. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    let healthStore = HKHealthStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        checkIfAvailable()
        getStepCountData()
    }

    func checkIfAvailable()
    {
        if HKHealthStore.isHealthDataAvailable() {
            
            let allTypes = Set([HKObjectType.workoutType(),
                                HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                                HKObjectType.quantityType(forIdentifier: .bodyMassIndex)!,
                                HKObjectType.quantityType(forIdentifier: .stepCount)!,
                                HKObjectType.quantityType(forIdentifier: .heartRate)!])
            
            healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                if !success {
                    // Handle the error here.
                }
            }
        }
    }
    
    func getStepCountData()
    {
        //sample type
        guard let sampleType = HKSampleType.quantityType(forIdentifier: .stepCount) else { return }
        
        //predicate boleh nil
        
        //limit
        let limit = 1
        
        //sortDescriptor bisa nil
        
        
        //query
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: limit, sortDescriptors: nil) { (sampleQuery, results, error) in
            
            guard let samples = results as? [HKQuantitySample] else { return }
            
            for sample in samples {
                print(sample)
            }
            
        }
        
        healthStore.execute(sampleQuery)
    }
}
