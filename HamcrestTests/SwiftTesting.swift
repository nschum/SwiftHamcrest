//
//  SwiftTesting.swift
//  Hamcrest
//
//  Created by René Pirringer on 10.07.26.
//  Copyright © 2026 Nikolaj Schumacher. All rights reserved.
//
import Testing
import Hamcrest

struct SwiftTesting {
    
    @Test
    @available(iOS 26, *)
    func `assertThat`() async throws {
        Hamcrest.assertThat("foo", equalTo("bar"))
    }
}
