//
//  swift
//  17可选链式调用
//
//  Created by Jie Chen on 16/12/10.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

// 可选链式调用是一种可以在当前值可能为 nil 的可选值上请求和调用属性、方法及下标的方法。如果可选值有值，那么调用成功，如果可选值为 nil，那么调用返回 nil。和 OC 中向 nil 发送消息有些相像。当 swift 的可选链式调用可以应用于任意类型，并且能检查调用是否成功。
/**********************************使用可选链式调用代替强制展开**********************************/
// 通过在想调用的属性、方法或下标的可选值后面放一个问号(?)，可以定义一个可选链。
class Person {
    var residence: Residence?
}
class Residence {
    var numberOfRooms = 1
}
let john = Person()
//let roomCount = john.residence!.numberOfRooms     // 报错，因为 residence = nil
if let roomCount = john.residence?.numberOfRooms {  // 添加 ? 之后，swift 就会在 residence 不为 nil 的情况下访问 numberOfRooms。
    print("John`s residence has \(roomCount) rooms.")
} else {
    print("Unable to retrieve the number of rooms")
}
john.residence = Residence()        // 此时 john 包含一个实际的 Residence 实例   != nil
if let roomCount = john.residence?.numberOfRooms {
    print("John`s residence has \(roomCount) rooms.")
} else {
    print("Unable to retrieve the number of rooms")
}


/**********************************为可选链式调用定义模型类**********************************/
// 通过使用可选链式调用可以调用多层属性、方法和下标。
class Person2 {
    var residence: Residence2?
}
class Residence2 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}
class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}

/**********************************通过可选链式调用访问属性**********************************/
func createAddress() -> Address {
    print("----Function was called----")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "jingaoRoad"
    
    return someAddress
}
let benben = Person2()
benben.residence?.address = createAddress()     // 方法并未调用，因为 benben.residence = nil

/**********************************通过可选链式调用方法**********************************/
if benben.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
// 重构
if (benben.residence?.address = createAddress()) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}

/**********************************通过可选链式调用访问下标**********************************/
if let firstRoomName = benben.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name")
}
benben.residence?[1] = Room(name: "Bathroom")   // 赋值失败，因为 benben.residence = nil

let benbenHouse = Residence2()                  // 创建一个 Residence实例
benbenHouse.rooms.append(Room(name: "A Room"))
benbenHouse.rooms.append(Room(name: "B Room"))
benben.residence = benbenHouse                  // 这样才赋值成功
if let firstRoomName = benben.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name")
}
// 访问可选类型的下标
// 如果下标返回可选类型值，如 swift 中 Dictionary 类型的键的下标。可以在下标的结尾括号后面加一个问号来在其可选返回值上进行可选链式调用。
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["abc"] = [123]       // 字典拼接
testScores
testScores["Dave"]?[0] = 90
testScores["Bev"]?[2] = 99
testScores["abc"]?[0] = 12      // 调用失败
testScores


/**********************************连接多层可选链式调用**********************************/
// 可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法以及下标。
// 1.如果你访问的值不是可选的，可选链式调用将会返回可选值。
// 2.如果你访问的值就是可选的，可选链式调用不会让可选返回值变得"更可选"
if let benbenStreet = benben.residence?.address?.street {
    print("benbenStreet name is \(benbenStreet)")
} else {
    print("Unable to retrieve the street")
}
// 虽然现在 benben.residence 是有实例的。但是 benben.residence.address = nil -->失败
let benbenAddress = Address()
benbenAddress.buildingName = "benbenAddress_NAME"
benbenAddress.street = "benbenAddress_STREET"
benben.residence?.address = benbenAddress
if let benbenStreet = benben.residence?.address?.street {
    print("benbenStreet name is \(benbenStreet)")
} else {
    print("Unable to retrieve the street")
}

/**********************************在方法的可选返回值上进行可选链式调用**********************************/
// 1.通过可选链式调用来定义 Address 的 buildingIdentifier() 方法。
if let buildIdentifier = benben.residence?.address?.buildingIdentifier() {
    print("benben building identifier is \(buildIdentifier)")
}
// 2.如果在该方法返回值上进行可选链式调用，在方法的圆括号后面加上问号即可：
if let beginsWithThe = benben.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("benben building identifier begins with \"The\".")
    } else {
        print("benben building identifier does not begins with \"The\".")
    }
}

