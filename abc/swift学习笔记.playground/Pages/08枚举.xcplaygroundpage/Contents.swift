//
//  swift
//  08枚举
//
//  Created by Jie Chen on 16/12/7.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

/**********************************枚举语法**********************************/
//1.使用 enum 关键字创建枚举并且把它们的整个定义放在一对大括号内：
enum CompassPoint {
    //枚举定义放在这里
    case north      //枚举成员值(成员)
    case sourth
    case east
    case west
}
//swift 的枚举成员在被创建时不会被赋予一个默认的整型值。这些枚举成员本身就是完整的值，这些值的类型是已经明确定义好的 CompassPoint 类型。
//对个成员值可以出现在同一行：
enum Planet {
    case mercury, venus, earth, mars
}
var directionToHead = CompassPoint.west
//一旦 directionToHead 被声明为 CompassPoint 类型，即可以使用 .语法
directionToHead = .north


/**********************************使用 Switch 语句匹配枚举值**********************************/
directionToHead = .sourth
switch directionToHead {
case .north:
    print("north")
case .sourth:
    print("sourth")
case .east:
    print("east")
case .west:
    print("west")
}


/**********************************关联值**********************************/
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = Barcode.qrCode("ABCDEFG")
switch productBarcode {
case .upc(let number1, let number2, let number3, let number4):
    print("UPC = \(number1), \(number2), \(number3), \(number4)")
case .qrCode(let productCode):
    print("QR code = \(productCode)")
}

productBarcode = .upc(1, 2, 3, 4)
switch productBarcode{
case let .upc(number1, number2, number3, number4):
print("UPC = \(number1), \(number2), \(number3), \(number4)")
case let .qrCode(productCode):
print("QR code = \(productCode)")
}


/**********************************原始值**********************************/
//枚举值可以被默认值(原始值)预填充，类型必须相同。
//原始值：在定义枚举时预先填充的值，对一个特定的枚举成员，原始值始终保持不变。
//关联值：创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值是可以变化的。
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
//1.在使用原始值为整数或者字符串类型的枚举时，不需要显示地为每一个枚举成员设置原始值，swift 会自动赋值。
//(1)如果用整数作为原始值时，隐式赋值的值依次递增1。如果第一个没值，默认为0
enum Planet2: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
//Planet2.venus = 2
//(2)如果用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称
enum CompassPoint2: String {
    case north, south, west, east
}
//CompassPoint2.west 拥有隐式原始值 west
//2.使用枚举成员的 rawValue 属性可以访问该枚举成员的原始值
let earthsOrder = Planet2.earth.rawValue
let sunsetDirection = CompassPoint2.west.rawValue
//3.使用原始值初始化枚举实例
if let somePlanet = Planet2(rawValue: 15) {
    print(somePlanet)
} else {
    print("初始化失败")
}



/**********************************递归枚举**********************************/
//它有一个或多个枚举成员使用该枚举类型的实例作为关联值。在枚举成员前加上 indirect 来表示该成员可以递归。
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
//或者这样：表示所有成员都可递归
indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}
//实例：展示使用递归枚举创建表达式(5 + 4) * 2
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
//对算术表达式求值函数：
func evaluate (_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product))


