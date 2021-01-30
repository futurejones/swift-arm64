// Swift - Slim
// The lightweight swift runtime

import Foundation
import Dispatch

public func wait(time: Double) {
    let nanoTime = time * 1000000000  // convert to nanoseconds
    let UI64Time = UInt64(nanoTime)  // convert to UInt64
    let pauseTime = DispatchTime.now().uptimeNanoseconds
    while (DispatchTime.now().uptimeNanoseconds <= pauseTime + UI64Time) {
        // wait time
    }
}

public func printToday(){
    let date = Date()
    let dateFormatter = DateFormatter()

    dateFormatter.dateStyle = .full
    dateFormatter.timeStyle = .full

    let dateString = dateFormatter.string(from: date as Date)
    print("  Welcome to Swift version 5.3.2")
    print("Today is \(dateString)")

}

print("")
print("        \\     \\")
wait(time: 0.03)
print("         \\\\   \\\\")
wait(time: 0.03)
print("         \\\\\\\\ \\\\\\\\")
wait(time: 0.03)
print("           \\\\\\\\\\\\\\")
wait(time: 0.03)
print("             \\\\\\\\")
wait(time: 0.03)
print("               \\\\")
wait(time: 0.03)
print("                `")
wait(time: 0.03)
print("            Swift Slim")
wait(time: 0.03)
print("  The lightweight Swift runtime")
print("")
wait(time: 0.5)
print("           Testing ....")
print("")
wait(time: 0.5)
printToday()
print("")
