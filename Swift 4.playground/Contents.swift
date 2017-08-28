//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// MARK: NSAttributedStringKey.font
#if swift(>=4.0)
let attStr = NSAttributedString(string: "",
                                attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
#else
    let attStr = NSAttributedString(string: "",
    attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)])
#endif

// MARK: String
#if swift(>=4.0)
let strArr = str.split(separator: ",")
print("strArr: \(strArr)")
let str1 : String = String(strArr.first!)
print("str1: \(str1)")
#else
let strArr1 = str.components(separatedBy: ",")
var str2 = strArr1.first!
#endif

#if swift(>=4.0)
let str3 = """
        test1
        test2
        """
print(str3)
#endif

// MARK: Key-Path
#if swift(>=4.0)
    @objcMembers
    class FooClass: NSObject {
        dynamic var age : Int
        var name : String
        init(age: Int, name: String) {
            self.age = age
            self.name = name
        }
    }
    let fooc = FooClass(age: 10, name: "foo")
fooc.observe(\FooClass.age, options: .new, changeHandler: { (root, keyValueChange) in
    
})
fooc.observe(\FooClass.age, changeHandler: { (foo, keyValueChange) in
    
})
    let classKeyPath : ReferenceWritableKeyPath<FooClass, Int> = \FooClass.age
    fooc[keyPath: classKeyPath] = 25

    print(fooc.age)
//    let key : ReferenceWritableKeyPath<FooClass, Int> = \FooClass.age
//    foo[keyPath: key] = 40
//    print(foo[keyPath: \ FooClass.name])
#else
    class FooClass: NSObject {
        @objc var age : Int
        var name : String
        init(age: Int, name: String) {
            self.age = age
            self.name = name
        }
    }
    let foo = FooClass(age: 10, name: "foo")
    let key = #keyPath(FooClass.age)
    foo.setValue(20, forKey: key)
#endif

#if swift(>=4.0)
    struct FooStruct {
        var age : Int
        var name : String
    }
    let foos = FooStruct(age: 10, name: "foo")
    let structKeyPath : WritableKeyPath<FooStruct, Int> = \FooStruct.age
    
    print(foos[keyPath: structKeyPath])
    
//    foos[keyPath: structKeyPath] = 30
//    print(foos[keyPath: \.name])
#endif

@objcMembers
class Kid : NSObject {
    dynamic var nickname: String = ""
    dynamic var age: Double = 0.0
    dynamic var bestFriend: Kid? = nil
    dynamic var friends: [Kid] = []
    init(nickname: String, age: Double) {
        super.init()
        self.nickname = nickname
        self.age = age
    }
}

struct BirthdayParty {
    let celebrant: Kid
    var theme: String
    var attending: [Kid]
}
let ben = Kid(nickname: "Benji", age: 5.5)
let bensParty = BirthdayParty(celebrant: ben, theme: "Construction", attending: [])
let birthdayKid = bensParty[keyPath: \BirthdayParty.celebrant]
/* 👇👇👇
 下面这一步，利用 \BirthdayParty.theme 给 bensParty 赋值时，一直报错。
 error: cannot assign to immutable expression of type 'String'。
 跪求大神解答。虽然感觉像是beta版 Xcode 的 锅。。😂😂😂
 */
//bensParty[keyPath: \BirthdayParty.theme] = "Pirate"

// MARK: Codable
struct User: Codable {
    var id : Int
    var nickname : String
    var isMale: Bool
    var birthday : Date
    var personalURL : URL
}

// decode
let jsonStr = """
{
    "id": 123455,
    "nickname": "Ben",
    "isMale": true,
    "birthday": "2000年3月24日",
    "personalURL": "https://addicechan.github.io"
}
"""

let jsonData = jsonStr.data(using: .utf8)!
let decoder = JSONDecoder()
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "YYYY年MM月dd日"
decoder.dateDecodingStrategy = .formatted(dateFormatter)
do {
    let user = try decoder.decode(User.self, from: jsonData)
    print(user)
    print(user.personalURL.scheme ?? "http?https?")
} catch let error {
    print(error.localizedDescription)
}

// encode
let user1 = User(id: 1000,
                 nickname: "ADDICE",
                 isMale: true,
                 birthday: Date(),
                 personalURL: URL(string: "https://addicechan.github.io")!)
let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .formatted(dateFormatter)
do {
    let data = try encoder.encode(user1)
    let str = String.init(data: data, encoding: .utf8)!
    print(str)
} catch let encodeError {
    print(encodeError.localizedDescription)
}






