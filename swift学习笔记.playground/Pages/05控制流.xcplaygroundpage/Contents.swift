//
//  swift
//  05控制流
//
//  Created by Jie Chen on 16/12/6.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

/**********************************检测 API 可用性**********************************/
//最后一个参数 * 是必须的，用于指定在所有其他平台中。
if #available(iOS 10, macOS 10.12, *) {
    print("在iOS使用 iOS 10 的 API， 在 macOS 使用 macOS 10.12 的 API")
} else {
    print("使用向前版本的 iOS 和 macOS 的 API")
}
//if #available(iOS 8.2, *) {
//    print(<#T##items: Any...##Any#>)
//}


/**********************************控制转移语句**********************************/
//1.continue
//停止本次循环，重新开始下次循环

//2.break
//立刻结束整个控制流的执行

//3.fallthrough
//补充：提前退出：像if语句一样，guard的执行取决于一个表达式的布尔值。可以使用guard语句来要求条件必须为真时，以执行guard语句后的代码。不同于if语句，一个guard语句总是有一个else语句，如果条件不为真则执行else从句中的代码。
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}
greet(person: ["name": "John"])
// 输出 "Hello John!"
// 输出 "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// 输出 "Hello Jane!"
// 输出 "I hope the weather is nice in Cupertino."


//4.return --> 参见函数部分
//5.throw  --> 参见错误抛出部分

print("**********控制转移语句**********")



/**********************************条件语句**********************************/
//1.If


//2.Switch
//注意：
//(1)swift的switch语句不存在隐式贯穿，如果想显示贯穿case分支，请使用fallthrough语句。
let character: Character = "a"
switch character {
case "a":
    print("The letter is \"a\"")
    fallthrough
case "A":
    print("The letter is \"A\"")
default:
    print("Not the letter A")
}
//(2)为了让单个case可以同时匹配a和A，可以将这两个值组合成一个符合匹配,并用逗号分开
switch character {
case "a", "A":
    print("The letter is A")
default:
    print("The letter is not A")
}
//(3)区间匹配
let score = 80
switch score {
case 0..<60:
    print("不及格")
case 60..<70:
    print("及格")
case 70..<80:
    print("良")
case 80..<90:
    print("好")
default:
    print("优秀")
}
//(4)元组：可以使用元组在一个switch语句中测试多个值。元组中的元素可以是值，也可以是区间。使用下划线(_)来匹配所有可能的值
let point = (1, 1)
switch point {
case (0, 0):
    print("This point is (0, 0)")
case (_, 0):
    print("This point is (_, 0)")
case (0, _):
    print("This point is (0, _)")
case (_, 1):
    print("This point is (_, 1)")
case (-2...2, 0...10):
    print("This point is (-2...2, 0...10)")
default:
    print("Other point")
}
//(5)值绑定：case分支允许将匹配到的值绑定在一个临时的常量或变量，并且在case分支内使用。
let otherPoint = (2, 0)
switch otherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis wiht a y value of\(y)")
case let (x, y):
    print("somewhere else at(\(x), \(y)")
//default:
//    print("default")
}
//(6)case分支的模式可以使用where语句来判断额外的条件
let point2 = (1, -1)
switch point2 {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
//default:
//    <#code#>
}
//(7)复合匹配(同(2))

print("**********条件语句**********")



/**********************************While循环**********************************/
//1.while循环，每次在循环开始时计算条件是否符合。
//2.repeat—while循环，每次在循环结束时计算条件是否符合。同C语言do-while循环



/**********************************FOR IN循环**********************************/
//1.区间操作符(a...b)表示从a到b的数字区间、区间操作符(..<)表示从a到b(不包括b)的数字区间
//index不需要声明，可以自动进行隐式声明，如不需要可用下划线(_)替换变量名忽略此值
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

var base = 0
for _ in 1..<5 {
    base += 1
}
print(base)

let dict = ["key": "value", "key2": "value2", "key3": "value3"]
for (key, value) in dict {
    print(key, value)
}

let arr = ["a", "b", "c", "d", "e"]
for (index, value) in arr.enumerated() {
    print(index, value)
}
print("**********FOR IN循环**********")
