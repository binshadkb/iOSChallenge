//
//  Result.swift
//  iOS Challenge
//
//  Created by Binshad K B on 17/04/23.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
