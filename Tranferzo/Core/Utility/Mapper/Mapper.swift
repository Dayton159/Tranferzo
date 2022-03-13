//
//  Mapper.swift
//  Tranferzo
//
//  Created by Dayton on 12/03/22.
//

protocol UniDirectMapper {
  associatedtype Response
  associatedtype Entity
  associatedtype Domain
  
  func transformResponseToEntity(response: Response) -> Entity
  func transformEntityToDomain(entity: Entity) -> Domain
}
