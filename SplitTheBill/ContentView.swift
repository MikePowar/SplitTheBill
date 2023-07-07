
//
//  ContentView.swift
//  WeSplit
//
//  Created by Mike Powar on 2023-06-28.
//

import SwiftUI

struct ContentView: View {
    // 3 states we need to track:
    @State private var checkAmount = 0.0
    //2 sets to 3rd row = 4 people
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    // Focus on Amount to assist with keyPad disappearing when not needed
    @FocusState private var amountIsFocused: Bool
    
    // let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // calculate total per person here
        
        // people count - cast to Double
        let peopleCount = Double(numberOfPeople + 2)
        
        //Then calculate - amountPerPerson
        let amountPerPerson = grandTotal / peopleCount
             
        return amountPerPerson
    }
    
    // Challenge 2: Add another section
    // - total amount for the check (original amount + tip value, w/o dividing by # of people)
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: localCurrency)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: localCurrency)
                } header: {
                Text("Amount Per Person")
                }
                // Challenge 2: Add another section
                // - total amount for the check (original amount + tip value, w/o dividing by # of people)
                Section {
                    Text(grandTotal, format: localCurrency)
                } header: {
                    Text("Grand Total")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    // System convention - pushing "done" button to right
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
