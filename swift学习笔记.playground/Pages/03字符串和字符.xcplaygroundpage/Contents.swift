//
//  swift
//  03字符串和字符
//
//  Created by Jie Chen on 16/12/5.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

/**********************************操作字符**********************************/
/**
 *  1.可以通过检查其Bool类型的isEmpty属性来判断该字符串是否为空
 *  2.可以通过for-in遍历字符串中的characts属性来获取每一个字符的值
 *  3.字符串可以通过传递一个值类型为Character的数组作为自变量来初始化
 */
let aString = ""        //空字符串
let bString = String()  //初始化方法
//两个字符串均为空并等价
if aString.isEmpty {
    print("Nothing to see here")
}


let cString = "chenxiaojie"
for character in cString {
    print("character = \(character)")
}


let catCharacters: [Character] = ["C", "a", "t", "!", "?"]
let catString = String(catCharacters)
print("catString = \(catString)")
// 字符统计
print("catString.count = \(catString.count)")
print("********************")


/**********************************字符串索引**********************************/
let greenting = "chenxiaojie"
print("greenting.startIndex = \(greenting[greenting.startIndex])")
print("greenting.startIndex = \(greenting[greenting.index(after: greenting.startIndex)])")
//let greentRange = ...5
//let rangeStr = greenting.range(of: greentRange)
//print("rangeStr = \(rangeStr)")


/**********************************字符串插入和删除**********************************/
/** 1.插入(insert(_:at:))方法可以在一个字符串的指定索引插入一个字符；
 (insert(contentsOf:at:))方法可以在一个字符串的指定索引插入一个段字符串。
 *   2.删除(remove(at:))方法可以在一个字符串的指定索引删除一个字符；
 *      (removeSubrange(at:))方法可以在一个字符串的指定索引删除一个子字符串。
 *
 */
var name = "chenjie"
//name.insert("x", at: name.startIndex)
name.insert("x", at: name.index(name.startIndex, offsetBy: 4))
print(name)

name.insert(contentsOf: "iao", at: name.index(name.startIndex, offsetBy: 5))
print(name)

name.remove(at: name.index(name.endIndex, offsetBy: -4))
print(name)

let range = name.index(name.endIndex, offsetBy: -6) ... name.index(name.endIndex, offsetBy: -4)
name.removeSubrange(range)
print(name)

print("********************")

/**********************************比较字符串**********************************/
/** 1.字符串的字符相等
 *  2.字符串前缀相等(hasPrefix(_:))
 *  3.字符串后缀相等(hasSuffix(_:))
 */
let stringA = "stringA"
let stringB = "stringA"
if stringA == stringB {
    print("stringA == stringB")
}
var stringC: String?
stringC = "stringA"
if stringA == stringC {
    print("stringA == stringC")
}

print("********************")

/**********************************前缀和后缀相等性**********************************/
/**
*   要检查一个字符串是否拥有特定的字符串前缀或者后缀，调用字符串的 hasPrefix(_:)和 hasSuffix(_:)方法，它们两个都会接受一个 String 类型的实际参数并且返回一个布尔量值。
*/
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
