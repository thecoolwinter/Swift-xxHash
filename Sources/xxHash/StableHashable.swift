//
//  StableHashable.swift
//  xxHash
//
//  Copyright (C) 2025  Khan Winter
//  See the LICENSE file distributed with this program for applicable license and warranty.
//

public protocol StableHashable {
    func hash(into hasher: inout xxHash128) throws
}
