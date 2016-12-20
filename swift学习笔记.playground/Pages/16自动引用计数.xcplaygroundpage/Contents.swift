//
//  swift
//  16自动引用计数
//
//  Created by Jie Chen on 16/12/10.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

/**********************************自动引用计数的工作机制**********************************/


/**********************************自动引用计数实践**********************************/
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
// 因为创建的是可选类型，会自动初始化 nil，目前还不会引用到 Person 类的实例
var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "chenxiaojie")
// 由于 Person 类的新实例被赋值给了 reference1 变量，所以 reference1 到 Person 类的新实例之间建立了一个强应用。
reference2 = reference1
reference3 = reference1
// 现在这个 Person 实例已经有三个强引用了。
// 通过给两个变量赋值 nil 的方式断开两个强引用。Person 实例不会被销毁。
reference1 = nil    // 没有打印 deinit
reference2 = nil    // 没有打印 deinit
// 当永远不再使用 Person 的实例的时候，第三个强引用被断开时，ARC 会销毁它。
reference3 = nil    // 此时才调用 deinit 方法，销毁 Person 实例


/**********************************类实例之间的循环强引用**********************************/
// 循环强引用：如果两个类实例相互持有对方的强引用，因而每个实例都让对方一直存在。
class Person2 {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}
class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    var tenant: Person2?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}
var john: Person2?
var unit4A: Apartment?
john = Person2(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

// ! 用来展开和访问可选变量 john 和 unit4A 中的实例，这样的实例才能被赋值。
john!.apartment = unit4A
unit4A!.tenant = john
//  Person 实例现在拥有了一个指向 Apartment 实例的强引用，而 Apartment 实例也有了一个指向 Person 实例的强引用。因此断开 john 和 unit4A 变量所持有的强引用时，引用计数并不会变为0，实例也不会被 ARC 销毁
john = nil      // 析构函数并未调用
unit4A = nil    // 析构函数并未调用
// 最终在程序中导致内存泄漏



/**********************************解决实例之间的循环强引用**********************************/
// 两种解决办法：弱引用、无主引用
// 1.弱引用 使用关键字 weak
// 因为弱引用不会保持所引用的实例，即使引用存在，实例也可能被销毁。通常弱引用被定义为可选类型，因为弱引用的值可能在运行的时候被赋值为 nil
class Person3 {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment3?
    deinit {
        print("$$$$\(name) is being deinitialized$$$$")
    }
}
class Apartment3 {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    weak var tenant: Person3?
    deinit {
        print("$$$$Apartment \(unit) is being deinitialized$$$$")
    }
}
var john3: Person3?
var unit4A3: Apartment3?
john3 = Person3(name: "John Appleseed3")
unit4A3 = Apartment3(unit: "4A3")

john3!.apartment = unit4A3  //强引用
unit4A3!.tenant = john3     //弱引用

john3 = nil     // 此实例销毁，不影响弱引用实例
unit4A3 = nil   // 此时才销毁

// 2.无主引用
// 与弱引用不同的是：无主引用在其他实例有相同或者更长的生命周期时使用。 使用关键字 unowned
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("****\(name) is being deinitialized")
    }
}
class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("****Card #\(number) is being deinitialized")
    }
}
var john4: Customer?
john4 = Customer(name: "John Appleseed")
john4!.card = CreditCard(number: 1234_5678_1234_5678, customer: john4!) //强引用

john4 = nil         // 两个实例都销毁了


// 总结：(1).Person 和 Apartment 的例子展示两个属性都允许为 nil，并潜在可能出现循环引用。这种场景适合用弱引用解决。
//      (2).Customer 和 CreditCard 的例子展示一个属性允许为 nil，另个属性不允许为 nil，也可能造成循环引用。这种场景适合通过无主引用来解决。
// (3).两个属性都必须有值，并且初始化后永远不为 nil。这种场景，需要一个类使用无主属性，一个类使用隐式解析可选属性。如下：

// 3.无主引用以及隐式解析可选属性(p217)
class Country {
    let name: String
    var capitalCity: City!      // 通过在类型结尾处加上 ! 的方式，将 Country 的 capitalCity 属性声明为隐式解析可选类型属性。默认值为 nil
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)`s capital city is called \(country.capitalCity.name)")



/**********************************闭包引起的循环强引用**********************************/
// 循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时。
class HTMLElement {
    let name: String
    let text: String?
    lazy var asHTML: (Void) -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("######\(name) is being deinitialized")
    }
}
let heading = HTMLElement(name: "h1")
//heading.text = "some default text"
// 自定义闭包取代默认值
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())

paragraph = nil         // 析构函数并没有调用，表示发生了循环强引用。（实例的 asHTML 属性持有闭包的强引用。闭包在其闭包体内使用了 self (引用了 self.name 和 self.text )，因此闭包捕获了 self，意味着闭包反过来也持有了 HTMLElement 实例的强引用）



/**********************************解决闭包引起的循环强引用**********************************/
// 解决方案：闭包捕获列表。在定义闭包同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。
// 1.定义捕获列表
// 捕获列表中的每一项都由一对元素组成，一个元素是 weak 或 unowned 关键字，另一个元素是类实例的引用(例如 self )或初始化过的变量(如 delegate = self.delegate!)。
/*  
    闭包无参或者无返回值类型，捕获列表和关键字 in 放在闭包最开始的地方
    lazy var someClosure: (Void) -> String = {
        [unowned self, weak delegate = self.delegate!] in
        //这里是闭包的函数体
    }
    闭包有参有返回值类型：
    lazy var someClosure: (Int, String) -> String = {
        [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
        //这里是闭包的函数体
    }
*/
// 2.弱引用和无主引用
// 在闭包和捕获的实例总是相互引用并且总是同时销毁时，将闭包类的捕获定义为无主引用。
// 在被捕获的引用可能会变成 nil 时，将闭包内的捕获定义为弱引用。如果不会变为 nil，则使用无主引用。
class HTMLElement2 {
    let name: String
    let text: String?
    lazy var asHTML: (Void) -> String = {
        [unowned self] in           //此行为捕获列表，将 self 捕获为无主引用而不是强引用,不会持有 HTMLElement 实例的强引用
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("---------\(name) is being deinitialized----------")
    }
}
var paragraph2: HTMLElement2? = HTMLElement2(name: "p", text: "HELLO WORLD")
print(paragraph2!.asHTML())

paragraph2 = nil            // 此时的析构函数调用了


