//
//  TransactionMapper.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

struct TransactionMapper: UniDirectMapper {
  typealias Response = [TransactionResponse]
  typealias Entity = [TransactionEntity]
  typealias Domain = [[TransactionModel]]
  
  func transformResponseToEntity(response: [TransactionResponse]) -> [TransactionEntity] {
    response.map {
      .init(
        id: $0.id,
        amount: $0.amount,
        date: DateFormatter.JSONResponse.dateFromString($0.date),
        description: $0.description ?? "Not Available",
        type: $0.type,
        receipient: ReceipientModel(
          accNumber: $0.receipient?.accNumber ?? $0.sender?.accNumber ?? "-",
          accHolder: $0.receipient?.accHolder ?? $0.sender?.accHolder ?? ""
        )
      )
    }
  }
  
  func transformEntityToDomain(entity: [TransactionEntity]) -> [[TransactionModel]] {
    var domain:[[TransactionModel]] = []
    
    var latestDate:String?
    
    for entity in entity {
      let model = TransactionModel(
        id: entity.id,
        amount: entity.amount.asCurrency(currency: "S$"),
        date: DateFormatter.yearOnBack.stringFromDate(entity.date) ?? "Unknown",
        description: entity.description,
        type: entity.type,
        receipient: entity.receipient
      )
      
      // Date Already Sorted from API
      if latestDate != model.date {
        domain.append([model])
        latestDate = model.date
        continue
      }
      
      // Grouping
      domain[domain.count - 1].append(model)
    }
    return domain
  }
}
