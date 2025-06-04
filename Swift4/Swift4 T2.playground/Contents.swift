import UIKit
//MARK: --- Task 2: Opaque and Boxed Protocol Types

protocol Shape {
    func area() -> Double
    func perimeter() -> Double
}

class Circle: Shape {
    var radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    func area() -> Double {
        return Double.pi * radius * radius
    }
    
    func perimeter() -> Double {
        return 2 * Double.pi * radius
    }
}

class Rectangle: Shape {
    var width: Double
    var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    func area() -> Double {
        return width * height
    }
    
    func perimeter() -> Double {
        return 2 * (width + height)
    }
}

func generateShape() -> some Shape {
    return Circle(radius: 5)
}

func calculateShapeDetails(for shape: Shape) -> (area: Double, perimeter: Double) {
    let area = shape.area()
    let perimeter = shape.perimeter()
    
    return (area, perimeter)
}

let shape = generateShape()
let result = calculateShapeDetails(for: shape)
print(result)

let rectangle = Rectangle(width: 20, height: 10)
print(calculateShapeDetails(for: rectangle))
