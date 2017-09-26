//
//  swift
//  21扩展
//
//  Created by Jie Chen on 16/12/12_13.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

// 给一个已有的类、结构体、枚举类型或者协议类型添加新功能。扩展和 OC 中的分类类似( swift 中扩展没有名字)
/** swift 中的扩展可以完成：
 *  添加计算型属性和计算型类型属性
 *  定义实例方法和类型方法
 *  提供新的构造器
 *  定义下标
 *  定义和使用新的嵌套类型
 *  使一个已有类型符合某个协议
 */
/**********************************扩展语法**********************************/
// 关键字：extension
/*
extension SomeType {
    //为 SomeType 添加的新功能写到这里
}
 */
// 通过扩展来扩展一个或多个协议。
/*
extension SomeType: SomeProtocol, AnotherProctocol {
    //协议实现写到这里
}
 */


/**********************************计算型属性**********************************/
// 注：1.扩展可以添加新的计算型属性，但是不可以添加存储型属性，也不可以为已有属性添加属性观察器。
extension Double {
    var km: Double { return self * 1000.0 }
    var m : Double { return self }
    var cm: Double { return self/100.0  }
    var mm: Double { return self/1000.0 }
    var ft: Double { return self/3.28084}
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")


/**********************************构造器**********************************/
// 注：2.扩展能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器。
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
let defaultRect = Rect()
print(defaultRect.origin, defaultRect.size)
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
print(memberwiseRect)

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width/2)
        let originY = center.y - (size.height/2)
        self.init(origin: Point(x:originX, y:originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
print(centerRect)



/**********************************方法**********************************/
// 扩展可以为已有类型添加新的实例方法和类型方法。
extension Int {
    func repetitions(task:() -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
3.repetitions(task: {
    print("hello")
})

// 尾随闭包
3.repetitions {
    print("Hello!")
}

// 可变实例方法
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()


/**********************************下标**********************************/
// 扩展可以为已有类型添加新下标
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
746381295[1]
746381295[8]


/**********************************嵌套类型**********************************/
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}
func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])




print("**********************************其他补充**********************************")
// 其他补充
// 在 swift 的 extension 中不能修改父类方法，如需更改需要在父类方法前加入 dynamic 关键字
class A {
    dynamic func doThing() {
        print("doting super class")
    }
}
class B: A {
    
}
extension B {
    override func doThing() {
        print("doting sub class")
        super.doThing()
    }
}
let b = B()
print(b.doThing())



