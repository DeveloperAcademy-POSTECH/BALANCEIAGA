//
//  ReceiptViewModel.swift
//  SickSangHae
//
//  Created by user on 2023/07/15.
//

import CoreData
import Foundation

class CoreDataViewModel: ObservableObject {
    private let viewContext = PersistentController.shared.viewContext
    @Published var receipts: [Receipt] = []
    
    var shortTermUnEatenList: [Receipt] {
        return receipts.filter{ $0.currentStatus == .shortTermUnEaten}
    }
    
    var shortTermPinnedList: [Receipt] {
        return receipts.filter{ $0.currentStatus == .shortTermPinned}
    }
    
    var longTermUnEatenList: [Receipt] {
        return receipts.filter{ $0.currentStatus == .longTermUnEaten}
    }
    
    var eatenList: [Receipt] {
        return receipts.filter{ $0.currentStatus == .Eaten }
    }
    
    var spoiledList: [Receipt] {
        return receipts.filter{ $0.currentStatus == .Spoiled }
    }
    
    init() {
        getAllReceiptData()
    }
    
    
}

extension CoreDataViewModel {
    func getAllReceiptData() {
        let request = NSFetchRequest<Receipt>(entityName: "Receipt")
        request.sortDescriptors = [
            NSSortDescriptor(key: "dateOfPurchase", ascending: false),
            NSSortDescriptor(key: "name", ascending: true)]
        do {
            receipts = try viewContext.fetch(request)
        } catch {
            print("Cannot fetch receipts from SickSangHae Model")
        }
    }
    
    
    func saveChanges() {
        do {
            if viewContext.hasChanges {
                try viewContext.save()
            }
        } catch {
            print("Error while Saving in CoreData")
        }
    }
    
    func createReceiptData() {
        
        let receipt = Receipt(context: viewContext)
        receipt.id = UUID()
        receipt.name = "TestName \(receipts.count)"
        receipt.dateOfPurchase = Date.now
        receipt.dateOfHistory = Date.distantPast
        receipt.isLongTerm = false
        receipt.icon = "icon_test"
        receipt.price = 6000.0
        receipt.status = .UnConsumed
        
        saveChanges()
        self.getAllReceiptData()
    }
    
    func deleteReceiptData(target: Receipt) {
        viewContext.delete(by: target)
        getAllReceiptData()
    }
    
    func updateReceiptStateData(target: Receipt, status: Status) {
        guard let receipt = viewContext.get(by: target.objectID) else { return }
        if status == .Pinned {
            if target.status != .UnConsumed {
                return
            }
        }
        
        receipt.state = status.rawValue
        receipt.dateOfHistory = Date.now
        
        saveChanges()
        getAllReceiptData()
    }
    
    func toggleIsLongTerm(target: Receipt) {
        guard let receipt = viewContext.get(by: target.objectID) else { return }
        guard receipt.status == .UnConsumed else { return }
        
        target.isLongTerm.toggle()
        
        saveChanges()
        getAllReceiptData()
    }
}
