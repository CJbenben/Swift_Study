//
//  swift
//  06函数
//
//  Created by Jie Chen on 16/12/6.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

/**********************************嵌套函数**********************************/
//重构
func chooseStepFunc2(backward: Bool) -> (Int) -> Int {
    func stepForward2(_ input: Int) -> Int {
        return input + 1
    }
    func stepBackward2(_ input: Int) -> Int {
        return input - 1
    }
    return backward ? stepBackward2 : stepForward2
}
var currentVaule2 = -4
let moveNearerToZero2 = chooseStepFunc2(backward: currentVaule2 > 0)
while currentVaule2 != 0 {
    print("\(currentVaule2)...")
    currentVaule2 = moveNearerToZero2(currentVaule2)
}
print("zero2!")


/**********************************函数类型**********************************/
//1.使用函数类型
//和其他类型一样，可以定义一个类型为函数的常量或者变量，并将适当的函数赋值给它。
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
var mathFunction: (Int, Int) -> Int = addTwoInts
print("result = \(mathFunction(4, 6))")
let otherFunchtion = addTwoInts
otherFunchtion(3, 5)
//2.函数类型作为参数类型
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("result = \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 7, 9)
//3.函数类型作为返回类型
//需要做的是在返回箭头(->)后写一个完整的函数类型。
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
func chooseStepFunc(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}
//666666
var currentValue = 3
let moveNearerToZero = chooseStepFunc(backward: currentValue > 0)
while currentValue != 0 {
    print("moveNearerToZero == \(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")

/**********************************函数参数标签和参数名称**********************************/
//1.指定参数标签
func someFunc(argumentLabel paramName: Int) {
    //在函数体内，paramName 代表参数值
}
//2.忽略参数标签
//如果不希望为某个参数添加一个标签，可以使用一个下划线(_)来代替一个明确的参数标签。
func someFunction(_ firstParamName: Int, secondParamName: Int) {
    //在函数体内，firstParamName 和 secondParamName 代表参数中的第一个和第二个参数值
}
someFunction(1, secondParamName: 7)
//3.默认参数值
func method(firstParamName: Int, secondParamName: Int = 12) {
    //如果第二个参数不传，secondParamName 会把默认值12传入函数体中
}
method(firstParamName: 3, secondParamName: 6)   //secondParamName = 6
method(firstParamName: 5)                       //secondParamName = 12
//4.可变参数
//可以接受0个或者多个值。函数调用时，可以用可变参数来指定函数参数可以被传入不确定数量的输入值。通过在变量类型名后面加入...的方式来定义可变参数
//注意：一个函数最多只能拥有一个可变参数
//求n个数的平均值：
func abcd(numbers: Double...) ->Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
abcd(numbers: 1, 4, 8, 21, 13)
//5.输入输出参数（C语言指针）
func swapTwoValue(a: inout Int, b: inout Int) {
    let temp = a
    a = b
    b = temp
}
//不能传入常量或者字面量，因为这些量是不能被修改的
//swapTwoValue(a: &4, b: &9)
var one = 4
var two = 9
swapTwoValue(a: &one, b: &two)
print("one = \(one), two = \(two)")




/**********************************函数参数与返回值**********************************/
//1.无参数函数
func sayHelloWorld() -> String {
    return "Hello World!"
}
print(sayHelloWorld())
//2.多参数函数(无返回值)
func greet(name: String, age: Int) {
    print("\(name) 今年 \(age) 岁了")
}
greet(name: "chenxiaojie", age: 18)
//3.多重返回值函数
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let minAndMax = minMax(array: [1, 3, 5, 2, 8])
print(minAndMax.max)
//可选元组返回类型
//如果函数返回的元组类型有可能整个元组都“没有值”，可以使用(optional)元组返回值类型反映整个元组可以是nil的事实。
func minMax2(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty {
        return nil
    }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let result = minMax2(array: [8, -6, 2, 109, 3, 71]) {
    print(result)
}


/**********************************函数的定义与调用**********************************/
func greet(person: String) -> String {
    return "Hello, " + person + "!"
}

print(greet(person: "chenxiaojie"))
