//
//  swift
//  22协议
//
//  Created by Jie Chen on 16/12/13.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

/**********************************协议语法**********************************/
protocol SomeProtocol {
 // 这里是协议的定义部分
}
// 如何遵循某个协议
struct SomeStructure: SomeProtocol {
    // 这里是结构体的定义部分
}
// 拥有父类的类在遵循协议时,应该将父类名放在协议名之前,以逗号分隔:
class SomeSuperClass {
    
}
class SomeClass: SomeSuperClass, SomeProtocol {
    // 这里是类的定义部分
}

/**********************************属性要求**********************************/
// 注：协议总是用 var 关键字来声明变量属性,在类型声明后加上 { set get } 来表示属性是可读可写的,可读属性则用 { get } 来表示
protocol SomeProtocol2 {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
// 定义类型属性时,只能使用 static 关键字作为前缀。
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}
protocol FullyNamed {
    var fullName: String { get }
}
struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")
john.fullName

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullName


/**********************************方法要求**********************************/
// 定义一个协议方法像普通方法一样放在协议的定义中,但是不需要大括号和方法体。
protocol SomeProtocol3 {
    // 定义类类型方法时,只能使用 static 关键字作为前缀。
    static func someTypeMethod()
}
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) / m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")


/**********************************Mutating 方法要求**********************************/
// 在方法中改变方法所属的实例。
protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On
        case .On:
            self = .Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()


/**********************************构造器要求**********************************/
// 不需要写花括号和构造器的实体:
protocol SomeProtocol4 {
    init(someParameter: Int)
}
// 构造器要求在类中的实现，在遵循协议的类中实现构造器，必须为构造器实现标上 required 修饰符:
class SomeClass2: SomeProtocol4 {
    required init(someParameter: Int) {
        // 这里是构造器的实现部分 
    }
}
// 使用 required 修饰符可以确保所有子类也必须提供此构造器实现。
protocol SomeProtocol5 {
    init()
}
class SomeSuperClass2 {
     init() {
        // 这里是构造器的实现部分 
    }
}
class SomeSubClass: SomeSuperClass2, SomeProtocol5 {
    // 因为遵循协议,需要加上 required
    // 因为继承自父类,需要加上 override
    required override init() {
        // 这里是构造器的实现部分
    }
}

/**********************************协议作为类型**********************************/
// a:作为函数、方法和构造器中的参数或返回值类型
// b:作为常量、变量或属性的类型
// c:作为数组、字典或其他容器中的元素类型
class Dice {
    let sides:Int
    let generator:RandomNumberGenerator     // 协议类型
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}


/**********************************委托（代理）模式**********************************/



/**********************************通过扩展添加协议一致性**********************************/
// p262 - p272
























