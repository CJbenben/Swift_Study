//
//  swift
//  11方法
//
//  Created by Jie Chen on 16/12/8.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

//在 swift 中除了类可以定义方法之外，结构体和枚举也可以定义方法( C/OC 不可以)
/**********************************实例方法**********************************/
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.count
counter.increment(by: 5)
counter.count
counter.reset()
counter.count
//1.self 属性
//上面的方法可以重写
/*
func increment() {
    self.count += 1
}
 */
//但是我们一般不写 self，在下面这种情况，我们会使用 self 属性来区分参数名称和属性名称
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
//2.在实例方法中修改值类型
struct Point2 {
    var x = 0.0, y = 0.0
/*  报错 --> 结构体和枚举是值类型。正常情况值类型的属性是不能再它的实例方法中被修改。
    func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
 */
    //添加关键字 mutating (可变)，可以从其他方法内部改变它的属性。
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX //结构体中的 值类型变量 x、y 就可以被 moveByX(_:y:) 函数进行修改了。
        y += deltaY
    }
}
var somePoint2 = Point2(x: 1.0, y: 1.0)
//该方法调用时修改了这个点，而不是返回一个新点。方法定义加上 mutating 关键字，表示属性允许修改。
somePoint2.moveByX(deltaX: 2.0, y: 3.0)
print("The point is now at (\(somePoint2.x), \(somePoint2.y))")
//注意：不能在结构体类型的常量上调用可变方法、报错。
let fixedPoint = Point2(x: 3.0, y: 3.0)
// fixedPoint.moveByX(deltaX: 2.0, y: 3.0)

//3.在可变方法中给 self 赋值
struct Point3 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point3(x: x + deltaX, y: y + deltaY)
    }
}
var testPoint = Point3(x: 3.0, y: 2.0)
testPoint.moveBy(x: 1.0, y: 4.0)
print("The point3 is now at (\(testPoint.x), \(testPoint.y))")


//枚举的可变方法可以把 self 设置为同一枚举类型中不同的成员
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()



/**********************************类型方法**********************************/
//在 OC 中只能为类类型定义类型方法，在 func 关键字之前加上关键字 static，类还可以用关键字 class 来允许子类重写父类的方法实现。
//在 swift 中可以为所有的类、结构体和枚举定义类型方法，每一个类型方法都被它所支持的类型显示包含。
class SomeClass {
    class func someTypeMethod() {
        //在这里实现类型方法
    }
    static func someTpyeMethod2() {
    
    }
}
//类名调用
SomeClass.someTypeMethod()





