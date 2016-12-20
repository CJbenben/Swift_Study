//
//  swift
//  02基本运算符
//
//  Created by Jie Chen on 16/12/5.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

/**********************************区间运算符**********************************/
/** 1.闭区间运算符(a...b)定义一个从a到b的所有值的区间。a不能超过b。如可以在for in遍历数组中使用
 *  2.半开区间运算符(a..<b)定义一个从a到b不包括b的区间。
 */
let names = ["A", "B", "C", "D", "E"]
for i in 0..<names.count {
    print("第 \(i + 1) 个人名字叫 \(names[i])")
}


/**********************************空合运算符**********************************/
/** 空合运算符（a ?? b）将对 可选类型 a 进行空判断，如果包含一个值就进行解封，否则就返回一个默认值b。
 *  表达式a必须是Optional类型。默认值b的类型必须要和a存储值的类型保持一致。
 *
 *  空合运算符是对以下代码的简短表达方法：
 *  a != nil ? a! : b
 */

let defaultColor = "red"
var customColor: String?    //默认值nil
//customColor = "yellow"
var resultColor = customColor ?? defaultColor
print("resultColor = ",resultColor)



/**********************************比较运算符**********************************/

/** 1.自增自减运算符
 *
 * 自增自减运算符在swift已经废弃
 * 以下两种写法会发生编译错误
 */
//a++
//++a


/** 2.恒等与不恒等运算符
 *
 * swift提供了恒等(===)和不恒等(!==)这两个比较云算法来判断两个对象是否引用一个对象实例。
 */
