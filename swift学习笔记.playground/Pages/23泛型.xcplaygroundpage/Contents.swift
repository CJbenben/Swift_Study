//
//  swift
//  23泛型
//
//  Created by Jie Chen on 16/12/14.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

// 泛型代码让你能够根据自定义的需求，编写出适用于任意类型、灵活可重用的函数及类型。
/**********************************泛型所解决的问题**********************************/
// 这是一个标准的非泛型函数。
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporary = a
    a = b
    b = temporary
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
someInt
anotherInt
// 以上是交换两个 Int 类型的两个值，那么 Double 和 String 如果想交换怎么办？
func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}
func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}
// 感觉是不是很不好，如果有一个更实用灵活的函数来交换两个任意类型的值。泛型代码完全可以。


/**********************************泛型函数**********************************/
// 泛型函数可适用于任何类型。
// <T>是 swapTwoValues(_:_:) 函数定义内的一个占位类型名，所以 swift 不会去找名为 T 的实际类型。
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporary = a
    a = b
    b = temporary
}
// Int
var someInt2 = 3
var anotherInt2 = 107
swapTwoValues(&someInt2, &anotherInt2)
someInt2
anotherInt2
// String
var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
print(someString, anotherString)


/**********************************类型参数**********************************/
// 上例中占位类型 T 是类型参数的一个例子。提供多个类型参数是，写在尖括号中，用逗号分开。


/**********************************命名类型参数**********************************/
// Dictionary<Key, Value> 中的 Key 和 Value
// Array[Element] 中的 Element
// 但没有任何意义时，可以用 T、U、V等表示。


/**********************************泛型类型**********************************/
// 这部分内容将向你展示如何编写一个名为(栈)的泛型合类型。栈是一系列值的有序 合,和 类似,但它相比 Swift 的类型有更多的操作限制。数组允许在数组的任意位置插入新元素或是删除其中任意位置的元素。而栈只允许在合的末端添加新的元素(称之为入栈)。类似的,栈也只能从末端移除元素(称之为出栈)。后进先出。
// 非泛型版本的栈
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
// 泛型版本
struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
// 创建一个 String 类型的栈
var stackOfStrings = Stack<String>()
stackOfStrings.push(item: "uno")
stackOfStrings.push(item: "dos")
stackOfStrings.push(item: "tres")
stackOfStrings.push(item: "cuatro")
print(stackOfStrings)
// 移除并返回栈顶部的值 cuatro -> 出栈
let fromTheTop = stackOfStrings.pop()
print(stackOfStrings)


/**********************************扩展一个泛型类型**********************************/
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}

/**********************************类型约束**********************************/
// 1.类型约束语法
class SomeClass {
    
}
protocol SomeProtocol {
    
}
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // 这里是泛型函数的函数体部分
}
// 第一个参数 T 必须是 SomeClass 子类的类型约束;第二个参数 U 必须符合 SomeProtocol 协议的类型约束。
// 2.类型约束实践
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
     print("The index of llama is \(foundIndex)")
}
// 泛型实例
func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        //编译报错：swift 无法猜到“相等”意味着什么
//        if value == valueToFind {
//            return index
//        }
    }
    return nil
}
// 任何符合 Equatable 协议的类型 T
func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let doubleIndex = findIndex(array: [3.14159, 0.1, 0.25], 9.3)
let stringIndex = findIndex(array: ["Mike", "Malcolm", "Andrea"], "Andrea")

/**********************************关联类型**********************************/
// 关联类型为协议中的某个类型提供了一个占位名(或者说别名),其代表的实际类型在协议被采纳时才会被指定。你可以通过 associatedtype 关键字来指定关联类型。
// 1.关联类型实践
protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack2: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分 
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
// 泛型 Stack 结构体遵从 Container 协议
struct Stack2<Element>: Container {
    // Stack<Element> 的原始实现部分
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // Container 协议的实现部分
    mutating func append(item: Element) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
// 2.通过扩展一个存在的类型来指定关联类型


/**********************************泛型 where 语句**********************************/
// 类型约束让你能够为泛型函数或泛型类型的类型参数定义一些强制要求。为关联类型定义约束,可以在参数列表中通过 where 子句为关联类型定义约束。
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
        // 检查两个容器含有相同数量的元素
        if someContainer.count != anotherContainer.count {
            return false
        }
        // 检查每一对元素是否相等
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        // 所有元素都匹配,返回 true 
        return true
}




