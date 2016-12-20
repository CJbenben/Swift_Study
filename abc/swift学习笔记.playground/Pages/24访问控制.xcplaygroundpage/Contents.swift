//
//  swift
//  24访问控制
//
//  Created by Jie Chen on 16/12/15.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

// 访问控制可以限定其他源文件或模块中的代码对你的代码的访问级别。
/**********************************模块和源文件**********************************/
// 一个模块可以使用 import 关键字导入另一个模块
// 源文件就是 swift 中的源代码文件，它通常属于一个模块，一个应用程序或者框架。


/**********************************访问级别**********************************/
// 开放访问、公开访问、内部访问、文件私有访问、私有访问
// 1.访问级别基本原则：不可以在某个实体中定义访问级别更低（更严格）的实体。
// 2.默认访问级别：默认级别为 internal 级别
// 3.单目标应用程序的访问级别：只为该应用服务，不需要提供给其他应用或门口使用，使用默认访问级别 internal 即可。
// 4.框架的访问级别：需要把一些对外的接口定义为开放访问或公开访问级别。其他人可使用这些功能。-> API
// 5.单元测试目标的访问级别：p290


/**********************************访问控制语法**********************************/
// 修饰符：open、public、internal、filepart、private

/**********************************自定义类型**********************************/
public class SomePublicClass {                  // 显示公开内
    public var somePublicProperty = 0           // 显示公开类成员
    var someInternalProperty = 0                // 隐式内部类成员
    fileprivate func someFilePrivateMethod() {} // 显式文件私有类成员
    private func somePrivateMethod() {}         // 显式私有类成员
}
class SomeInternalClass {                       // 隐式内部类
    var someInternalProperty = 0                // 隐式内部类成员
    fileprivate func someFilePrivateMethod() {} // 显式文件私有类成员
    private func somePrivateMethod() {}         // 显式私有类成员
}
fileprivate class SomeFilePrivateClass {        // 显示文件私有类
    func someFilePrivateMethod() {}             // 隐式文件私有类成员
    private func somePrivateMethod() {}         // 显示私有类成员
}
private class SomePrivateClass {                // 显示私有类
    func somePrivateMethod() {}                 // 隐式私有类成员
}
// 1.元组类型：元组的访问级别由元组中访问级最严格的类型来决定。
// 2.函数类型：函数的访问级别由参数类型或返回值类型的访问级别来决定。
/*
                        // 隐式内部类        // 显示私有类  --> 虽然没有明确定义函数访问级别，该函数访问级别为 private
func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    // 此处是函数实现部分
}
private func someFunction() -> (SomeInternalClass, SomePrivateClass) { --> 通过编译
    // 此处是函数实现部分
}
*/
// 3.枚举类型：枚举成员的访问级别和该枚举类型相同，不能为枚举成员单独制定不同的访问级别。
public enum CompassPoint {
    case North      // 枚举成员也为 public
    case South
    case East
    case West
}
// 4.嵌套类型：如果在 private 级别的类型中定义嵌套类型，嵌套类型自动拥有 private 访问级别。


/**********************************子类**********************************/
// 子类访问级别不能高于父类的访问级别。但是我们可以通过重写为继承来的类成员提供更高的访问级别。这里报错了
/*
public class A {
    private func someMethod() {}
}
internal class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}
*/


/**********************************常量、变量、属性、下标**********************************/
// 常量、变量、属性不能拥有比它们的类型更高的访问级别。下标也不能拥有比索引类型或返回值更高的访问级别。
private var privateInstance = SomePrivateClass()
// getter 和 setter 的访问级别 --> p294


/**********************************构造器**********************************/
// 自定义构造器的访问级别可以低于或等于其所属类型的访问级别。唯一例外是必要构造器，它的访问级别必须和所属类型的访问级别相同。
// 默认构造器：默认构造器的访问级别与所属类型的访问级别相同，除非类型的访问级别是 public。
// 结构体默认的成员逐一构造器：如果结构体中任意存储型属性的访问级别为 private，那么该结构体默认的成员逐一构造器的访问级别就是 private。否则依然是 internal。


/**********************************协议**********************************/
// 协议中的每一个要求都具有和该协议相同的访问级别。你不能将协议中的要求设置为其他访问级别。这样才能确保该协议的所有要求对于任意采纳者都将可用。
// 注：如果你定义了一个 public 访问级别的协议,那么该协议的所有实现也会是 public 访问级别。这一点不同于其他类型,例如,当类型是 public 访问级别时,其成员的访问级别却只是 internal。
// 协议继承：子类继承父类协议，子类访问级别不能高于父类的访问级别。

/**********************************扩展**********************************/

















