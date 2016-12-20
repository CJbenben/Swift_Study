//
//  swift
//  19类型转换
//
//  Created by Jie Chen on 16/12/12.
//  Copyright © 2016年 陈晓杰. All rights reserved.
//

import Foundation

// 类型转换 可以判断实例的类型，使用 is 和 as 操作符来实现。
/**********************************定义一个类层次作为例子**********************************/
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}
class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}
let library = [
    Movie(name: "A_name", director: "A_director"),
    Song(name: "B_name", artist: "B_atist"),
    Movie(name: "C_name", director: "C_director"),
    Song(name: "D_name", artist: "D_atist"),
    Song(name: "E_name", artist: "E_atist"),
]
// 变量 library 会被 swift 自动推断为 MediaItem 类型，但是实际上存储的仍是 Movie 和 Song 类型。为了让他们作为原来的类型工作，需要检查他们类型或者向下转换它们到其他类型。



/**********************************检查类型**********************************/
// 使用类型检查操作符(is)来检查一个实例是否属于特定子类型。返回 Bool 类型值。
var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs")



/**********************************向下转型**********************************/
// 类型转换操作符 (as? 或 as!)
for item in library {
    if let movie = item as? Movie {         //item as? Movie：尝试将 item 转为 Movie 类型。
        print("Movie: \(movie.name), dir: \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), art: \(song.artist)")
    }
}



/********************************** Any 和 AnyObject 的类型转换 **********************************/
// swift 为不确定类型提供了两种特殊的类型别名：
// 1.Any 可以表示任何类型，包括函数类型。
// 2.AnyObject 可以表示任何类类型的实例。
var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Movie.name", director: "Movie.director"))
things.append({ (name: String) -> String in "Hello, \(name)"})

for thing in things {
    switch thing {
    case 0 as Int:
        print("------zero as an Int------")
    case 0 as Double:
        print("------zero as a Double------")
    case let someInt as Int:
        print("------an integer value of \(someInt)------")
    case let someDouble as Double where someDouble > 0:
        print("------a positive double value of \(someDouble)------")
    case is Double:
        print("------some other double value that I do not want to print------")
    case let someString as String:
        print("++++++a string value of \"\(someString)\"++++++")
    case let movie as Movie:
        print("++++++a movie called \(movie.name)++++++")
    case let stringConverter as (String) -> String:
        print(stringConverter("**************Michael***********"))
    default:
        print("++++++something else++++++")
    }
}
// 注：swift 会在我们使用 Any 类型来表示一个可选值的时候，给出一个警告。
let optionalNumber: Int? = 3
things.append(optionalNumber)
things.append(optionalNumber as Any)


