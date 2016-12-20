//
//  swift
//  12下标
//
//  Created by Jie Chen on 16/12/8.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

/**********************************下标语法**********************************/
//下标允许你通过在实例名称后面的括号中传入一个或者多个索引值来对实例进行存取。定义下标使用 subscript 关键字。
//可以指定一个或这个输入参数和返回值类型，与实例方法区别是：下标可以设定为读写或只读。
/*  可以不指定 setter 的参数( newValue ),如果不指定参数，setter 会提供一个名为 newValue的默认参数。
subscript(index: Int) -> Int {
    get {
        //返回一个适当的 Int 类型的值
    }
    set(newValue) {
        
    }
}
*/
/*  如果是只读属性，可以省略只读下标的 get 关键字
subscript(index: Int) -> Int {
    //返回一个适当的 Int 类型的值
 }
 */
struct TimesTable {
    var multiplier: Int
//    subscript(index: Int) -> Int {
//        return multiplier * index
//    }
    subscript(index2: Int) -> Int {
        get {
            return multiplier * index2
        }
        set {
            multiplier = newValue + index2
        }
    }
}
var threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")

threeTimesTable[3] = 7

print(threeTimesTable[3])


/**********************************下标用法**********************************/
//参考读取和修改字典

/**********************************下标选项**********************************/
//在 C 语言中称之为二维数组
//一个 Double 类型的二维矩阵
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValidRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidRow(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidRow(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
// 构造一个新的 Matrix 实例
var matrix = Matrix(rows: 5, columns: 8)
// 调用下标的 setter 方法
matrix[1, 4] = 23
// 调用下标的 getter 方法
print(matrix[1, 4])
// Matrix 下标的 getter 和 setter 都含有断言，用来检查下标入参 row 和 column 的值是否有效。
//let someValue = matrix[6, 4]   //报错


