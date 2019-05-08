//for i in 1...100 {
//    if i % 3 == 0 && i % 5 == 0 {
//        print("FizzyByzzy")
//    } else if i % 3 == 0 {
//        print("Fizzy")
//    } else if i % 5 == 0 {
//        print("Byzzy")
//    } else {
//        print(i)
//    }
//}
var points = "59"
if points.count == 1 {
    points.append("00")
    points = String(points.reversed())
    print(points)
} else if points.count == 2 {
    points = String(points.reversed())
    points.append("0")
    points = String(points.reversed())
    print(points)
} else {
    print(points)
}
