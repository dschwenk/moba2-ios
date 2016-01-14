//
//  ToDoEntity.swift
//  test-app01
//
//  Created by ds-131860 on 12.01.16.
//  Copyright (c) 2016 ds-131860. All rights reserved.
//

import Foundation
import CoreData

class ToDoEntity: NSManagedObject {

    @NSManaged var todo_title: String
    @NSManaged var todo_desc: String
    @NSManaged var todo_date: NSDate

}
