//
//  NimbleCRUDExampleApp.swift
//  NimbleCRUDExample
//
//  Created by Braden Ackerman on 2022-04-01.
//

import SwiftUI
import NimbleCRUD

var kTEST_ENTITY_NAME: String = "TestEntity"

@main
struct NimbleCRUDExampleApp: App {
    let persistenceController = PersistenceController.shared
    let memoryCoreDataTesting = InMemoryCoreDataTesting()
    var body: some Scene {
        WindowGroup {
             
            //NimbleCRUDView(modelName: "NimbleCRUDExample", entityName: kTEST_ENTITY_NAME)
            NimbleCRUDView(memoryCoreDataTesting.inMemoryTestingPersistentContainer, entityName: kTEST_ENTITY_NAME, attributeNameToSortBy: "sequential")
        }
    }
}
