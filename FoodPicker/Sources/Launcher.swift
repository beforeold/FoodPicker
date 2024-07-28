import Foundation

struct Launcher {
    static func setup() {
        SearchWrapper.setup()
        
        showNetworkToast()
    }
    
    private static func showNetworkToast() {
        let key = "com.launcher.showNetwork"
        if UserDefaults.standard.bool(forKey: key) {
            return
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: URL(string: "https://www.apple.com")!)
                print(data.count)
            } catch {
                print(error)
            }
        }
        
        UserDefaults.standard.set(true, forKey: key)
    }
}
