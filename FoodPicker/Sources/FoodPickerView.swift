import SwiftUI

struct FoodPickerView: View {
    @EnvironmentObject var pickerViewModel: PickerViewModel
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            MapView()
                .ignoresSafeArea()
                .blur(radius: locationViewModel.blurRadius,
                      opaque: true)
            stateView()
                .frame(width: UIScreen.main
                    .bounds.width, height: UIScreen.main
                    .bounds.height)
                .ignoresSafeArea()
        }
        .navigationTitle(Text("吃个啥？"))
    }
    
    @ViewBuilder
    func stateView() -> some View {
        if case .locating = pickerViewModel.state {
            LocationView()
        }
        else if case .scaning = pickerViewModel.state {
            // shows radar on map
            // no code needed
        }
        else if case .done = pickerViewModel.state {
            resultView()
        }
        else if case .failed(let error) = pickerViewModel.state {
            failedView(error)
        }
    }
    
    @ViewBuilder
    func resultView() -> some View {
        VStack(spacing: 20) {
            Text("🎉").font(.system(size: 50))
            resultTitleText()
            resultButtons()
        }
        .padding(25)
        .background(Color(UIColor(red: 253/255.0,
                                  green: 211/255.0,
                                  blue: 225/255.0,
                                  alpha: 1)))
        .cornerRadius(12)
        .sheet(isPresented: $pickerViewModel.isResulting) {
            NavigationView {
                FoodListView(isEditable: false,
                             pois: .constant(pickerViewModel.pois))
            }
        }
        .sheet(isPresented: $pickerViewModel.isRandom) {
            if let random = pickerViewModel.pois.randomElement() {
                DisplayView(poi: random)
            }
        }
    }
    
    @ViewBuilder
    func failedView(_ error: SearchWrapper.SearchError) -> some View {
        VStack(spacing: 20) {
            Text(error == .failed ? "❌" : "ℹ️").font(.system(size: 50))
            Text(error == .failed ? "啊噢，出错了" : "周边没有发现餐厅").font(.system(size: 20)).foregroundColor(.black)
            
            Button(action: {
                if let coordinate = locationViewModel.coordinate {
                    pickerViewModel.scan(coordinate: coordinate)
                }
            }) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("重试一次")
                }
                .foregroundColor(.white)
                .padding(12)
            }
            .frame(height: 44)
            .frame(minWidth: 180)
            .background(Color.accentColor)
            .cornerRadius(6)
        }
        .padding(25)
        .background(Color(UIColor(red: 253/255.0,
                                  green: 211/255.0,
                                  blue: 225/255.0,
                                  alpha: 1)))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    func resultButtons() -> some View {
        VStack {
            Button(action: {
                pickerViewModel.isResulting = true
            }) {
                HStack {
                    Image(systemName: "eye")
                    Text("冲！去看看")
                }
                .foregroundColor(.white)
                .padding(12)
            }
            .frame(height: 44)
            .frame(minWidth: 180)
            .background(Color(UIColor.systemPink))
            .cornerRadius(6)
            
            RandomButton {
                pickerViewModel.isRandom = true
            }
            .frame(height: 44)
            .frame(minWidth: 180)
        }
    }
    
    func resultTitleText() -> Text {
        let t1 = Text("在周边发现")
            .font(.system(size: 20))
            .foregroundColor(.black)
        
        let t2 = Text(" \(pickerViewModel.pois.count) ")
            .font(.system(size: 25))
            .foregroundColor(.black)
        
        let t3 = Text("家餐厅")
            .font(.system(size: 20))
            .foregroundColor(.black)
        
        return t1 + t2 + t3
    }
}

extension View {
    func centerInScreen() -> some View {
        return self.padding(.bottom, 50)
    }
}

struct FoodPickerView_Previews: PreviewProvider {
    static var previews: some View {
        FoodPickerView()
            .environmentObject(LocationViewModel())
    }
}
