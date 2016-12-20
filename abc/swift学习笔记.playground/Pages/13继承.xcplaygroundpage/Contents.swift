//
//  swift
//  13继承
//
//  Created by Jie Chen on 16/12/8.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

/**********************************定义一个基类**********************************/
//基类：不继承于其他类的类
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        //什么也不做-因为车辆不一定会有噪音
    }
}
let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")



/**********************************子类生成**********************************/
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
//可以继续被继承
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")



/**********************************重写**********************************/
//重写某个特性，需要在重写定义前面加上 override 关键字
//1.访问父类的方法、属性及下标。通过关键字 super 前缀来访问
//2.重写方法
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()
//3.重写属性
//重写一个属性的时候，必须将它的名字和类型都写出来。
class Car: Vehicle {
    var gear = 1
    override var description: String {
        //重写 description 属性首先要调用 super.description 返回 Vehicle 类的 description 属性。
        get {
            return super.description + " in gear \(gear)"
        }
        //父类没有 setter 方法，重写版本中可以提供 setter 方法
        set {
//            self.description = "abcdefg" + newValue
        }
    }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")

//car.description = "abcdefg"
//print(car.description)
//4.重写属性观察器
//重写属性为一个继承来的属性添加属性观察器
//注意：1.不可以为继承来的常量存储型属性或继承来的只读属性添加属性观察器，因为这些是不可以被设置的。
//     2.不可以同时提供重写的 setter 和重写的属性观察器
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
//        willSet {
//            
//        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("Automatic: \(automatic.description)")



/**********************************防止重写**********************************/
// 1.可以通过把方法、属性或下标标记未 final 来防止它们被重写。
// 2.可以在关键字 class 前加 final 修饰符来将整个类标记未 final 的。这样的类是不能被继承的。

