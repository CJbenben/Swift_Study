//
//  swift
//  10属性
//
//  Created by Jie Chen on 16/12/7.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

//存储属性存储常量或变量作为是实例的一部分，计算属性计算(不是存储)一个值。计算属性可以用于类、结构体、枚举，存储属性只能用于类和结构体。
/**********************************存储属性**********************************/
//1.常量结构体的存储属性
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 6   //这里报错，即使 firstValue 是变量也不行，主要还是 rangeOfFourItems 为常量
//2.延迟存储属性( OC 中的懒加载或称延迟加载)
//实例：延迟存储属性来避免复杂类中的不需要的初始化
class DataImporter {
    /*
     DataImporter 是一个负责外部文件中的数据导入类。
     这个类的初始化会消耗不少时间。
    */
    var fileName = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    //这里会提供数据管理功能
}
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
//到目前为止 DataImporter 属性还没有被创建

print(manager.importer.fileName)    //DataImporter 实例的 importer 属性现在被创建了
//3.存储属性和实例变量
//在 OC 中有除了属性之外，还可以使用实例变量作为属性值的后端存储。但在 swift 中的属性没有对应的实例变量。



/**********************************计算属性**********************************/
//1.类、结构体、枚举可以定义为计算属性。不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值。
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
print(initialSquareCenter)

square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
//2.简化 setter 声明
//如果 setter 没有定义新的参数名，可以使用默认名称newValue。
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
//3.只读属性
//只有 getter 没有 setter 的计算属性就是只读属性。
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
fourByFiveByTwo.volume



/**********************************属性观察器**********************************/
//每次属性被设置值的时候都会调用属性观察器。可以为除了延迟存储属性之外的其他存储属性添加属性观察器，也可以通过重写属性的方式为继承的属性（存储和计算属性）添加属性观察器。
//可以为属性添加如下的一个或全部观察器
// willSet 在新的值被设置之前调用
// didSet  在新的值被设置之后立即调用
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {    //如果不重新定义变量，默认值为 newValue
            print("Abount to set totalSteps to \(newTotalSteps)")
        }
        didSet {    //这里没有重新定义变量，默认值为 oldValue
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896



/**********************************全局变量和局部变量**********************************/


/**********************************类型属性**********************************/
//1.类型属性语法
struct SomeStructure {
    static var storedTypeProperty = "Some value Structure"
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value Enumeration"
    static var computedTpyeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value Class"
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
//2.获取和设置类型属性的值
print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value"
print(SomeStructure.storedTypeProperty)
print(SomeEnumeration.computedTpyeProperty)
print(SomeClass.overrideableComputedTypeProperty)


