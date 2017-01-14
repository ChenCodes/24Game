//: Playground - noun: a place where people can play

import Darwin
import Foundation

func expression24(mode: String) -> [String] {
    
    // This is just a constant 
    let result = 24
    var expressionLength = -1
    var numbersLength = -1
    if mode == "easy" {
        expressionLength = 3
        numbersLength = 4
    } else if mode == "hard" {
        expressionLength = 4
        numbersLength = 5
    }
    var foundNumber = false
    
    
    // Gets list of all possible expressions so you have like [+, -, *], [+, -, /] etc 
    var expressions = permute(list: ["+", "-", "/", "*"], minStringLen: expressionLength)
    
    // step 2 is to generate 4 random numbers from 1 - 9 -> output is gonna be [1, 2, 3, 4] or [3, 6, 2, 5]
    var numbers = Set<Int>()
    while numbers.count < numbersLength {
        let randomNum = Int(arc4random_uniform(8) + 1)
        numbers.insert(randomNum)
    }
    
    // FOR TESTING PURPOSES
    var startingNumberArray = Array(numbers)
    var number_permutations = [String]()
    for number in startingNumberArray {
        number_permutations.append(String(number))
    }
    // Iterate through each possible permutation of our chosen numbers
    for number_permutation in permute(list: number_permutations, minStringLen: numbersLength) {
        
        // Put it into an array 
        var permutation_array = number_permutation.characters.map({ String($0) })
        
        // Initialize the finalResult to be the first element in the permutation_array
        for expression in expressions {
            var finalResult = Int(permutation_array[0])
            var operand_index = 1
            
            // We go through and see what our order of operations is, so if the first element in the array is +, we want to add the second number to the first number using the switch statement 
            for specific_operand in expression.characters.map({ String($0) }) {
                switch(specific_operand) {
                case "+":
                    finalResult = finalResult! + Int(permutation_array[operand_index])!
                case "-":
                    finalResult = finalResult! - Int(permutation_array[operand_index])!
                case "*":
                    finalResult = finalResult! * Int(permutation_array[operand_index])!
                case "/":
                    finalResult = finalResult! / Int(permutation_array[operand_index])!
                default:
                    break
                }
                operand_index += 1
                
                // If the number is getting too big/too small then we can just skip the rest of the looping for the outer loop (this is used to keep runtime fast)
                if finalResult! > 24 || finalResult! < 1 {
                    break
                } else {
                    // Tweak this to modify difficulty
                    if finalResult == 24 && operand_index > expressionLength {
                        print("Expression is ", expression)
                        print("Numbers are: ", permutation_array)
                        foundNumber = true
                        return permutation_array
                        
                    }
                }
            }
        }
    }
    if foundNumber == false {
        return expression24(mode: mode)
    }
}



// Helper to come up with all of the possible expressions
func permute(list: [String], minStringLen: Int = 2) -> Set<String> {
    func permute(fromList: [String], toList: [String], minStringLen: Int, set: inout Set<String>) {
        if toList.count == minStringLen {
            set.insert(toList.joined(separator: ""))
        }
        if !fromList.isEmpty {
            for (index, item) in fromList.enumerated() {
                var newFrom = fromList
                newFrom.remove(at: index)
                permute(fromList: newFrom, toList: toList + [item], minStringLen: minStringLen, set: &set)
            }
        }
    }
    
    var set = Set<String>()
    permute(fromList: list, toList:[], minStringLen: minStringLen, set: &set)
    return set
}


//print(expression24(mode: "hard"))
