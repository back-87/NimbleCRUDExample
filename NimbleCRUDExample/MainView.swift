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
                Color.clear
                .onAppear {
                        if memoryCoreDataTesting.requiresTestData(container: memoryCoreDataTesting.inMemoryTestingPersistentContainer) {
                            
                            showLoadingText = true
                            
                            showAlert.toggle()
                           
                                memoryCoreDataTesting.addRandomTestData(container: memoryCoreDataTesting.inMemoryTestingPersistentContainer)
                                
                            showLoadingText = false //trust me you do not want NimbleCRUDView instantiated off mainQueue
                            
                        } else {
                            showLoadingText = false
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
