//
//  swift
//  04集合类型
//
//  Created by Jie Chen on 16/12/6.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import UIKit

/**********************************字典**********************************/
//1.创建一个空字典
var dict = [Int: String]()
//2.用字典字面量创建字典
var dict2: [String: String] = ["key": "value", "key2": "value2"]
//3.访问和修改字典
//通过count访问数据项数量、isEmpty检查count属性是否为0
dict2.count
if  dict2.isEmpty {
    print("dict is empty")
} else {
    print("dict is not empty")
}
dict2["key3"] = "value3"
dict2["key3"] = "值"
dict2
dict2.updateValue("chenxiaojie", forKey: "key3")    //返回值：返回原来key对应的value值(可选)、用于检测是否替换成功
dict2
if let oldVale = dict2.updateValue("chenjie", forKey: "key4") {
    print("旧的值为\(oldVale)")
} else {
    print("没有替换成功")
}
dict2
//移除键值对
dict2["key"] = nil
dict2
dict2.removeValue(forKey: "key2")
dict2
//4.字典的遍历
for (key, value) in dict2 {
    print("key = \(key), value = \(value)")
}

for keys in dict2.keys {
    print("key = \(keys)")
}
for values in dict2.values {
    print("value = \(values)")
}
//对字典的keys或values属性使用sorted方法获得特定顺序的字典的键或值
dict2.keys.sorted()

print("**********字典**********")



/**********************************集合**********************************/
//1.创建和构造一个空的集合
var letters = Set<Character>()
letters.insert("a")
print(letters)
//2.用数组字面量创建集合
var favoriteName: Set<String> = ["zhangsan", "lisi", "wangwu"]
var numberSet: Set = [3, 1, 6, 1]
//3.访问和修改一个集合
//(1)通过只读属性count访问元素的数量
let count = numberSet.count
//(2)使用布尔属性isEmpty检查count属性是否为0
if numberSet.isEmpty {
    print("numberSet is Empty")
} else {
    print("numberSet is not Empty")
}
//(3)通过调用insert(_:)方法添加一个元素
numberSet.insert(8)
print(numberSet)
//(4)通过调用remove(_:)方法删除一个元素
numberSet.remove(10)
print(numberSet)
//(5)遍历一个集合
//因为集合的无序性、按照特定顺序遍历一个Set中的值可以使用sorted()方法，将返回一个有序的数组。
for item in numberSet {
    print(item)
}

//4.基本集合操作
//(1)使用intersection(_:) 方法根据两个集合中都包含的值创建的一个新的集合。
//(2)使用symmetricDifference(_:) 方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
//(3)使用union(_:) 方法根据两个集合的值创建一个新的集合。
//(4)使用subtracting(_:) 方法根据不在该集合中的值创建一个新的集合。
var set1: Set = [1, 3, 5, 7, 9]
let set2: Set = [0, 2, 4, 6, 8]
let set3: Set = [2, 3, 5, 7]
set1.union(set2).sorted()
set1.subtracting(set3).sorted()
set1.intersection(set3).sorted()
set1.symmetricDifference(set3).sorted()

//5.集合成员关系和相等
//(1)使用“是否相等”运算符( == )来判断两个集合是否包含全部相同的值。
//(2)使用isSubset(of:) 方法来判断一个集合中的值是否也被包含在另外一个集合中。
//(3)使用isSuperset(of:) 方法来判断一个集合中包含另一个集合中所有的值。
//(4)使用isStrictSubset(of:) 或者isStrictSuperset(of:) 方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
//(5)使用isDisjoint(with:) 方法来判断两个集合是否不含有相同的值(是否没有交集)。


print("**********集合**********")



/**********************************数组**********************************/
//1.创建一个空数组
var array = Array<String>()
var array2 = [Int]()
array2.append(5)

//2.创建一个带有默认值的数组
var threeValues = Array(repeatElement(0.0, count: 4))
//threeValues = Array()
print("threeValues = \(threeValues)")

//3.通过两个数组相加创建一个新的数组
var otherArr = Array(repeatElement(2.5, count: 3))
var resultArr = threeValues + otherArr
print("resultArr = \(resultArr)")

//4.用数组字面量构造数组
var stringArr: [String] = ["A", "B", "C"]
//var sameArr = ["C", 4]        //数组中不能放置不同类型的元素

//5.访问和修改数组
//(1)使用isEmpty属性作为一个缩写的形式去检查count属性是否为0
if stringArr.isEmpty {
    print("The stringArr is empty.")
} else {
    print("The stringArr is not empty.")
}
//(2)使用append(_:)、+=等方法在数组后面添加新的数据项
stringArr.append("D")

stringArr += ["E","F"]

stringArr[0] = "H"
print(stringArr)

stringArr[3...5] = ["M","N"]
print(stringArr)

//(3)调用数组的insert(_:at:)
stringArr.insert("X", at: 0)  //直接是下标就好、注意与字符串的插入区别
//stringArr.insert("A", at: <#T##Int#>)//数组
//string.insert("A", at: <#T##String.Index#>)//字符串
stringArr.remove(at: 1)
print(stringArr)
//stringArr.removeFirst()
//stringArr.removeLast()
//print(stringArr)


//6.数组的遍历
for item in stringArr {
    print("item = \(item)")
}
//如果我们同时需要元素的索引值和元素值，可以使用enumerated()方法来进行数组遍历。
for (index, value) in stringArr.enumerated() {
    print("第 \(index + 1) 个元素的值为 \(value)")
}

// 7.其他
let testAry = [1, 2, 3, 4, 5, 6, 7]
testAry.forEach {
    print($0)
}

print("**********数组**********")


