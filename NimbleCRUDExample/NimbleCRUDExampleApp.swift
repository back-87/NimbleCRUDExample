//
//  NimbleCRUDExampleApp.swift
//  NimbleCRUDExample
//
//  Created by Braden Ackerman on 2022-04-01.
//

import SwiftUI
import NimbleCRUD





var kTEST_ENTITY_NAME: String = "TestEntity"
var kTEST_SORT_ATTRIBUTE: String = "sequential"

@main

struct NimbleCRUDExampleApp: App {
    
    var memoryCoreDataTesting = InMemoryCoreDataTesting()
    @State var showLoadingText = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
        
                NimbleCRUDView(memoryCoreDataTesting.inMemoryTestingPersistentContainer, entityName: kTEST_ENTITY_NAME, attributeNameToSortBy: kTEST_SORT_ATTRIBUTE)

                if showLoadingText {
                    ZStack {
                        Color.clear
                                .frame(maxWidth: .infinity, maxHeight:  .infinity)
                        VStack {
                          Spacer()
                            Text("Adding \(numberOfTestRows) test rows")
                            Text("This could take a few seconds...")
                            Spacer()
                        }
                    }
                    .background(Color.white)
                }
     
            }.onAppear {
                if memoryCoreDataTesting.requiresTestData(container: memoryCoreDataTesting.inMemoryTestingPersistentContainer) {
                    showLoadingText = true
                    print("No sample data exists, adding \(numberOfTestRows) sample rows with each supported CoreData type. This may take several seconds.")
                    DispatchQueue.global(qos: .default).async {
                        memoryCoreDataTesting.addRandomTestData(container: memoryCoreDataTesting.inMemoryTestingPersistentContainer)
                        showLoadingText = false
                    }
                }
            }
        }
    }
}
