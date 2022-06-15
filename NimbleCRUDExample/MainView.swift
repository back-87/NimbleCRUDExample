//
//  MainView.swift
//  NimbleCRUDExample
//
//  Created by Braden Ackerman on 2022-06-02.
//

import SwiftUI
import NimbleCRUD

var kTEST_ENTITY_NAME: String = "TestEntity"
var kTEST_SORT_ATTRIBUTE: String = "sequential"


struct MainView: View {
    
    var memoryCoreDataTesting = InMemoryCoreDataTesting()
    @State var showLoadingText = true
    @State var showAlert = false
    var body: some View {
        
            if !showLoadingText {
                NimbleCRUDView(memoryCoreDataTesting.inMemoryTestingPersistentContainer, entityName: kTEST_ENTITY_NAME, attributeNameToSortBy: kTEST_SORT_ATTRIBUTE)
            } else {
                
                Text("Adding \(numberOfTestRows) test rows\n This may take a few seconds...")
                    .onAppear {
                        
                        DispatchQueue.global().async {
                            if memoryCoreDataTesting.requiresTestData(container: memoryCoreDataTesting.inMemoryTestingPersistentContainer) {
                                
                                    memoryCoreDataTesting.addRandomTestData(container: memoryCoreDataTesting.inMemoryTestingPersistentContainer) {
                                        
                                        showLoadingText = false
                                        
                                    }
                         
                            } else {
                                showLoadingText = false
                            }
                        }
                    }
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
