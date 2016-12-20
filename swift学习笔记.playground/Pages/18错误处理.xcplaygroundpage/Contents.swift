//
//  swift
//  18错误处理
//
//  Created by Jie Chen on 16/12/12.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

// 响应错误以及从错误中恢复的过程。swift 提供了运行时对可恢复错误的抛出、捕获、传递和操作的一系列支持。
// 抛出一个错误可以向我们表明有意外情况发生，导致正常的执行流程无法继续执行。
/**********************************表示并抛出错误**********************************/
// 在 swift 中，错误用符合 Error 协议的类型的值来表示。
// 例子中表示在一个游戏中操作自动贩卖机时可能出现的错误状态：
enum VendingMachineError: Error {
    case invalidSelection                       //选择无效
    case insufficienFunds(coninsNeeded: Int)    //金额不足
    case outOfStock                             //缺货
}
// 抛出错误使用 throw 关键字。
throw VendingMachineError.insufficienFunds(coninsNeeded: 5) //表示贩卖机还需要 5 个硬币。



/**********************************错误处理**********************************/
// 某个错误被抛出时，附近的某部分代码必须负责处理这个错误。
//  a:将函数抛出的错误传递给调用此函数的代码
//  b:用 do-catch 语句处理错误
//  c:将错误作为可选类型处理
//  d:断言此错误根本不会发生
// 1.用 throwing 函数传递错误
// 为了标识出抛出错误的地方，在调用一个能抛出错误的函数、方法或者构造器之前，加上 try 关键字，或者 try? 或 try! 这种变体。
// 为了表示一个函数、方法或者构造器可以抛出错误，在函数声明的参数列表之后加上 throws 关键字。称之为 throwing 函数

/*  一个 throwing 函数可以在其内部抛出错误，并将错误传递到函数被调用时的作用域
func canThrowErrors() throws -> String
func cannotThorwsErrors() -> String
*/
struct Item {
    var price: Int
    var count: Int
}
class VendingMachine {
    var inventory = [
        "Candy Bay": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection      //选择无效
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock            //缺货
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficienFunds(coninsNeeded: item.price - coinsDeposited)   //金额不足
        }
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}
let favoriteSnake = [
        "Alice": "Chips",
        "Bob": "Licorice",
        "Eve": "Pretzels",
    ]
func bugFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let shackName = favoriteSnake[person] ?? "Candy Bar"
    print(shackName)
    try vendingMachine.vend(itemNamed: shackName)
}

// 2.用 do-catch 处理错误
// 可以使用一个 do-catch 语句运行一段闭包代码来处理错误。如果在 do 子句中的代码抛出一个错误，这个错误会与 catch 子句做匹配，从而决定哪条子句能处理它。
/*  do-catch 语句的一般形式:
do {
    try expression
    statements
} catch pattern 1 {
    statements
} catch pattern 2 where condition {
    statements
}
*/
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try bugFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficienFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins")
}
// 打印 "Insufficient funds. Please insert an additional 2 coins"

// 3.将错误转换成可选值
// 可以使用 try? 通过将错误转换成一个可选值来处理错误。
// 下例中 x 和 y 有着相同的数值和等价的含义：
func someThrowingFunction() throws -> Int {
    //...
    return 1    //为了不报错误，随便写的一个 return 语句
}
let x = try? someThrowingFunction()
let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}
// 如果 someThrowingFunction() 抛出一个错误，x 和 y 的值都是 nil，否则 x 和 y 的值就是该函数的返回值。

// 4.禁用错误传递
// 有时如果知道某个 throwing 函数实际上在运行上是不会抛出错误的，这时可以在表达式前面写 try! 来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。
/*
let photo = try! loadImage(atPath: "./Resources/123.jpg")
*/



/**********************************指定清理操作**********************************/
// 使用 defer 语句在即将离开当前代码块时执行一系列语句。
/*
func processFile(filename: String) throws {
    if exists(filename) {
        // 打开文件
        let file = open(filename)
        defer {
            close(file)
        }
        while let lin3 = try file.readline() {
            // 处理文件
        }
        // close(file)会在这里被调用，即作用域的最后。
    }
}
*/










