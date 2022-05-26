//
//  InMemoryCoreDataTesting.swift
//  NimbleCRUDExample
//
//  Created by Braden Ackerman on 2022-04-01.
//

import Foundation
import CoreData


let numberOfTestRows = 10000
let randomSizeLowerBounds = 0
let randomSizeUpperBounds = 1000

class InMemoryCoreDataTesting {

    public lazy var inMemoryTestingPersistentContainer: NSPersistentContainer = {
        
      let container = NSPersistentContainer(name: "NimbleCRUDExample")

      let description = NSPersistentStoreDescription()
      description.url = URL(fileURLWithPath: "/dev/null")
      //container.persistentStoreDescriptions = [description]

      container.loadPersistentStores(completionHandler: { _, error in
        if let error = error as NSError? {
          fatalError("Failed to load stores: \(error), \(error.userInfo)")
        }
      })
        
        
        //add actual sample data (random) * 1000 if it doesn't exist
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: kTEST_ENTITY_NAME)
        
        var objectCount = 0
        do {
            try objectCount = container.viewContext.count(for: fetch)
            if objectCount < 1 {
                print("No sample data exists, adding \(numberOfTestRows) sample rows with each supported CoreData type. This may take several seconds.")
                addRandomTestData(container: container)
            }
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        

        
        
      return container
    }()
    
    private func addRandomTestData(container : NSPersistentContainer) {
        
        //Int.random(in: 1...99)
        for index in 0..<numberOfTestRows {
            let newItem = TestEntity(context: container.viewContext)
            
            //timestamp
            newItem.timestamp = Date()
            
            //binary
            newItem.testAttribBinary = Data(randomString(length: Int.random(in: randomSizeLowerBounds...randomSizeUpperBounds)).utf8)
            
            //bool
            newItem.testAttribBool = randomBool()
            
            //date
            newItem.testAttribDate = generateRandomDate(daysBack: Int.random(in: randomSizeLowerBounds...randomSizeUpperBounds))
            
            //decimal aka currency
            newItem.testAttribDecimal = NSDecimalNumber(value: Float(Int.random(in: randomSizeLowerBounds...randomSizeUpperBounds)) + Float(Int.random(in: 0...2) / 100))
            
            //double
            newItem.testAttribDouble = Double(Int.random(in: randomSizeLowerBounds...randomSizeUpperBounds)) + Double.random0to1()
            
            //float
            newItem.testAttribFloat = Float(Int.random(in: randomSizeLowerBounds...randomSizeUpperBounds)) + Float(Double.random0to1())
            
            //int16
            newItem.testAttribInt16 =  Int16(Int.random(in: randomSizeLowerBounds...randomSizeUpperBounds))
            
            
            //int32
            newItem.testAttribInt32 =  Int32(Int.random(in: randomSizeLowerBounds...randomSizeUpperBounds))
            
            //int64
            newItem.testAttribInt64 =  Int64(Int.random(in: randomSizeLowerBounds...randomSizeUpperBounds))
            
            //String
            newItem.testAttribString = randomString(length: Int.random(in: randomSizeLowerBounds...randomSizeUpperBounds))
            
            //URI
            newItem.testAttribURI =  URL(string: "file:///some/dir/foobar.txt")
    
            //UUID
            newItem.testAttribUUID = UUID()
            
            //sequential index
            newItem.sequential = Int32(index)
            
            container.viewContext.insert(newItem)
        }
        

        
        do {
            try container.viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
private func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}
    
private func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
}
    

    
func generateRandomDate(daysBack: Int)-> Date?{
            let day = arc4random_uniform(UInt32(daysBack))+1
            let hour = arc4random_uniform(23)
            let minute = arc4random_uniform(59)
            
            let today = Date(timeIntervalSinceNow: 0)
            let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
            var offsetComponents = DateComponents()
            offsetComponents.day = -1 * Int(day - 1)
            offsetComponents.hour = -1 * Int(hour)
            offsetComponents.minute = -1 * Int(minute)
            
            let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
            return randomDate
        }
    
}

extension Double {
    private static let arc4randomMax = Double(UInt32.max)

    static func random0to1() -> Double {
         return Double(arc4random()) / arc4randomMax
    }
}
