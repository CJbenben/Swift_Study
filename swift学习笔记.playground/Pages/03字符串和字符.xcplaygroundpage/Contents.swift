//
//  swift
//  03字符串和字符
//
//  Created by Jie Chen on 16/12/5.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

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



/**********************************字符串的截取**********************************/
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

name.insert(contentsOf: "iao".characters, at: name.index(name.startIndex, offsetBy: 5))
print(name)

name.remove(at: name.index(name.endIndex, offsetBy: -4))
print(name)

let range = name.index(name.endIndex, offsetBy: -6) ... name.index(name.endIndex, offsetBy: -4)
name.removeSubrange(range)
print(name)

print("********************")



/**********************************字符串字面量**********************************/
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
for character in cString.characters {
    print("character = \(character)")
}


let catCharacters: [Character] = ["C", "a", "t", "!", "?"]
let catString = String(catCharacters)
print("catString = \(catString)")

