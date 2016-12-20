//
//  swift
//  09类和结构体
//
//  Created by Jie Chen on 16/12/7.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

/**********************************类和结构体对比**********************************/
//1.定义语法
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var framRate = 0.0
    var name: String?
}
//2.类和结构体实例
//生成结构体和类实例的语法非常相似:
let someResolution = Resolution()
let someVideoMode = VideoMode()
//3.属性访问
print("The width of someResolution is \(someResolution.width)")
//swift 可以直接设置 someVideoMode 中 resolution 属性的 width 这个子属性，与OC不同，不需要重新为整个 resolution 属性设置新值。
someVideoMode.resolution.width = 100
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
//4.结构体类型的成员逐一构造器
let vga = Resolution(width: 100, height: 200)



/**********************************结构体和枚举是值类型**********************************/
//枚举和结构体都是值类型(可以理解是浅拷贝)
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema.width = \(cinema.width)")
print("hd.width = \(hd.width)")



/**********************************类是引用类型**********************************/
//类是引用类型(可以理解是深拷贝)复制的是指针,可以理解为：指向同一块内存地址
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.framRate = 25.0
tenEighty.name = "1080i"

let tenEighty2 = tenEighty
tenEighty2.framRate = 30.0

print("tenEighty.framRate = \(tenEighty.framRate), tenEighty2.framRate = \(tenEighty2.framRate)")

//1.恒等运算符
//用够判定两个常量或变量是否引用同一个类实例。等价于( === )、不等价于( !== )
if tenEighty === tenEighty2 {
    print("可以理解为两个变量指向同一块内存地址")
}



/**********************************类和结构体的选择**********************************/

