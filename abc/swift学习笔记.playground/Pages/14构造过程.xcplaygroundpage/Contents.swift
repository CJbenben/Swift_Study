//
//  swift
//  14构造过程
//
//  Created by Jie Chen on 16/12/9.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

/**********************************存储属性的初始赋值**********************************/
// 构造器：以关键字 init 命名
// 两种方式实现：
// 1.在构造器中为存储属性赋初值
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature) Fahrenheit")
// 2.在定义属性时为其设置默认值
// 两者效果一样
struct Fahrenheit2 {
    var temperature = 32.0
}


/**********************************自定义构造过程**********************************/
// 可以通过参数和可选类型的属性来自定义构造过程，同样可以在构造过程中修改常量属性。
// 1.构造参数
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
boilingPointOfWater.temperatureInCelsius
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
freezingPointOfWater.temperatureInCelsius

// 2.参数的内部名称和外部名称
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

// 3.不带外部名的构造器参数
// 使用下划线(_)来显示描述它的外部名。
struct Celsius2 {
    let temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
//注意区别（其实和参数定义章节中可以同理解为参数标签问题）
let bodyTemperature = Celsius2(37.5)
bodyTemperature.temperatureInCelsius

// 4.可选属性类型
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response
cheeseQuestion.response = "Yes, I do like cheese"
cheeseQuestion.response

// 5.构造过程中常量属性的修改
// let text 在 SurveyQuestion2 的实例被创建之后不会再被修改。尽管 text 属性现在是常量，仍然可以在类的构造器中设置它的值。注意：不能在子类构造过程中修改。
class SurveyQuestion2 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}


/**********************************默认构造器**********************************/
// 如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 swift 会给这些结构体或类提供一个默认构造器。
class ShoppingListItem {
    var name: String?
    var quanity = 1
    var purchased = false
}
var item = ShoppingListItem()
item.quanity
// 1.结构体的逐一成员构造器
// 如果结构体没有提供自定义构造器，它将自动获得一个逐一成员构造器，即使结构体的存储型属性没有默认值。
// 逐一成员构造器是用来初始化结构体新实例成员属性的快捷方法。
struct Point {
    var x, y: Double
}
let point = Point(x: 2.0, y: 4.0)

struct Size {
    var width = 0.0, height = 0.0
}
let size = Size(width: 2.0, height: 2.0)



/**********************************值类型的构造器代理**********************************/
// 构造器代理：构造器可以通过调用其他构造器来完成实例的部分构造过程。
// 对于值类型，可以使用 self.init 在自定义构造器中引用相同类型中的其他构造器。只能在构造器内部调用 self.init.
// 注：1.如果值类型定义了一个自定义构造器，将无法再访问到默认构造器（结构体：无法访问逐一成员构造器）
//    2.如果希望默认构造器、逐一成员构造器和自定义构造器都可以来创建实例。可以将自定义的构造器写到 扩展(extension)中。
struct Size2 {
    var width = 0.0, height = 0.0
}
struct Point2 {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point2()
    var size = Size2()
    // 1.使用被初始化为默认值的 origin 和 size 属性来初始化。
    // 同自动获得默认构造器一样。
    init() {}
    // 2.提供指定的 origin 和 size 实例来初始化。
    // 功能上在结构体没有自定义构造器获得的逐一成员构造器一样。
    init(origin: Point2, size: Size2) {
        self.origin = origin
        self.size   = size
    }
    // 3.提供指定的 center 和 size 来初始化
    init(center: Point2, size: Size2) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point2(x: originX, y: originY), size: size)
    }
}
let basicRect = Rect()
print(basicRect)

let originRect = Rect(origin: Point2(x: 2.0, y: 2.0), size: Size2(width: 5.0, height: 5.0))
print(originRect)

let centerRect = Rect(center: Point2(x: 4.0, y: 4.0), size: Size2(width: 3.0, height: 3.0))
print(centerRect)



/**********************************类的继承和构造过程**********************************/
// swift 为类类型提供了两种构造器来确保实例中所有存储属性都能获得初始值。指定构造器、便利构造器
// 1.指定构造器和便利构造器

// 2.指定构造器和便利构造器语法
/* 指定构造器
init(parameters) {
    statements
}
*/
/*  便利构造器
convenience init(parameters) {
    statements
}
*/
// 3.类的构造器代理规则
// (1)指定构造器必须调用其直接父类的指定构造器
// (2)便利构造器必须调用同类中定义的其他构造器
// (3)便利构造器必须最终导致一个指定构造器被调用
// 总结为：指定构造器必须总是向上代理；便利构造器必须总是横向代理。





/**********************************可失败构造器**********************************/






/**********************************必要构造器**********************************/
// 在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器。
class SomeClass {
    required init() {
        //构造器的实现代码
    }
}
// 在子类重写父类的必要构造器时，必须在子类的构造器前也添加 required 修饰符。在重写父类中必要的指定构造器，不需要添加 override 修饰符。
class SomeSubclass: SomeClass {
    required init() {
        //构造器的实现代码
    }
}


/**********************************通过闭包或函数设置属性的默认值**********************************/









