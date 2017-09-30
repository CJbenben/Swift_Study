//
//  swift
//  07闭包
//
//  Created by Jie Chen on 16/12/7.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation
import UIKit

/**********************************闭包表达式**********************************/
//1.闭包表达式是一个利用简介语法构建内联闭包的方式。
//sorted方法：会根据你所提供的用于排序的闭包函数将已知类型元素且元素已正确排序的新数组。且原数组不会被sorted(by:)方法修改
//sorted(by:)方法对一个String类型的数组进行字母逆序排序。
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//sorted(by:)方法接受一个闭包，该闭包函数需要传入与数组元素类型相同的两个值，并返回一个布尔类型值来表明当排序结束后传入的第一个参数排在第二个参数前面还是后面。
//所以该排序闭包函数类型需为(String, String) -> Bool
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
//let numbers = [1, 2, 5, 23, 12, 34]
//numbers.sorted(by: <#T##(Int, Int) -> Bool#>)
//2.闭包表达式语法
//利用闭包表达式语法可以更好的构造一个内联排序闭包
/* 闭包表达式语法有如下一般形式：
{
    (parameters) -> returnType in
    statements
}
 */
//函数对应的闭包表达式版本的迭代(参数变成了内联闭包)
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
reversedNames
//3.根据上下文推断类型
//因为所有类型都可以被正确推断，返回箭头和围绕周围的括号，所以可以被省略
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2})
reversedNames
//4.单表达式闭包隐式返回
//单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果
//因为闭包函数体只包含一个单一表达式(s1 > s2)，该表达式返回 Bool 类型值，因此这里没有歧义，return 关键字可以省略
reversedNames = names.sorted(by: { s1, s2 in s1 > s2})
reversedNames
//5.参数名称缩写
//swift 自动为内联闭包提供了参数名称缩写功能，可以直接通过 $0, $1, $2 来顺序调用闭包的参数。in关键字也同样可以被省略。
reversedNames = names.sorted(by: { $0 > $1 })
reversedNames
//$0 和 $1 表示闭包中第一个和第二个 String 类型的参数
//6.运算符方法
//swift 的 String 类型定义了关于大于号(>)的字符串实现，作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。
reversedNames = names.sorted(by: >)

func loadData(finish: (_ message: String) -> Void) {
    print("执行顺序")
    finish("message2")
}

loadData { (message) in
    print(message)
}

func someFunction(arg: (_ index: NSInteger, _ indexPath: NSIndexPath) -> Void) {
    print("function main")
    let indexPath = NSIndexPath(row: 0, section: 0)
    arg(1231, indexPath)
}

someFunction { (index, indexPath) in
    print("index = \(index), indexPath = \(indexPath)")
}


/**********************************尾随闭包**********************************/
//尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，可以不用写出它的参数标签。
func abcd(a: () -> Void) {
    //函数体部分
}
//以下是不使用尾随闭包进行函数调用
abcd(a: {
    //闭包主体部分
})
//以下是使用尾随闭包进行函数调用
abcd() {
    //闭包主体部分
}
//sorted(by:)方法参数的字符串排序闭包可以改写：
reversedNames.sorted(){ $0 > $1 }
reversedNames
//如果闭包表达式是函数或方法的唯一参数时，使用尾随闭包可以省略()
reversedNames.sorted { $0 > $1 }
reversedNames

//完美展示的实例：
let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat{
        let index = number % 10
        output = digitNames[index]! + output
        number /= 10
    } while number > 0
    return output
}
strings



print("****************值捕获****************")
/**********************************值捕获**********************************/
//闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域不存在了，闭包仍然可以在闭包函数体内引用和修改这些值。swift 中最简单的形式是嵌套函数。
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()
//如果你创建了另一个 incrementer，它会有属于自己的引用，指向一个全新、独立的 runningTotal 变量：
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
incrementBySeven()
incrementByTen()



/**********************************闭包是引用类型**********************************/
//上面例子中，incrementByTen 和 incrementBySeven 都是常量，但是这些常量指向的闭包仍然是可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。
//无论将函数或闭包赋值给一个常量还是变量，实际上都是将常量或变量的值设置为对应函数或闭包的引用。
//这意味着如果将闭包赋值给两个不同的常量或变量，两个值都会指向同一个闭包。(一个内存地址)
let incrementByTen2 = incrementByTen
incrementByTen2()



/**********************************逃逸闭包(p136)**********************************/
var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

someFunctionWithEscapingClosure {
    
}











/**********************************自动闭包(p137)**********************************/











