import Dispatch
import Foundation


func getExecutionTime(_ function: () -> ()) -> Double {
    let start = DispatchTime.now()
    function()
    let end = DispatchTime.now()
    return Double(end.uptimeNanoseconds - start.uptimeNanoseconds)
}


func getTimeString(_ nanoseconds: Double) -> String {
    if nanoseconds < 1e3 {
        return "\(nanoseconds) ns"
    } else if nanoseconds < 1e6 {
        return "\(nanoseconds/1e3) µs"
    } else if nanoseconds < 1e9 {
        return "\(nanoseconds/1e6) ms"
    } else {
        return "\(nanoseconds/1e9) seconds"
    }
}


func timeMagic(_ function: () -> ()) {
    let nanoseconds = getExecutionTime(function)
    print("\(getTimeString(nanoseconds))")
}


func timeitMagic(_ n_times: Int = 10, _ function: () -> ()) {
    assert(n_times > 0)
    let nsArray: [Double] = (0..<n_times).map({_ in getExecutionTime(function)})
    print("Max: \(getTimeString(nsArray.max()!))")
    print("Min: \(getTimeString(nsArray.min()!))")
    let mean = (nsArray.reduce(0, +)) / Double(n_times)
    print("Mean: \(getTimeString(mean))")
    let variance = nsArray.map({pow(($0 - mean), 2)}).reduce(0, +) / Double(n_times)
    print("Std Dev: \( getTimeString(sqrt(variance)))")
}
