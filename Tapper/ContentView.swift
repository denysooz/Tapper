import SwiftUI
import Combine

struct ContentView: View {
    @AppStorage("clickCount") private var coinCount: Int = 0
    @AppStorage("coinPerSecond") private var coinPerSecond: Int = 0
    @AppStorage("coinsPerClick") private var coinPerClick: Int = 1
    
    
    @State private var timer: Cancellable?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Coins: \(coinCount)")
                .font(.title)
            
            Text("Coins per second: \(coinPerSecond)")
                .font(.title)
            
            Text("Coins per click: \(coinPerClick)") // Отображение количества монет за клик
                .font(.title)
            
            Button {
                coinPerSecond += 1
            } label: {
                Text("Add Coin/s")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button {
                coinPerClick += 1 // Увеличиваем количество монет за клик
            } label: {
                Text("Increase Coins per Click")
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button {
                coinCount = 0
                coinPerSecond = 0
                coinPerClick = 1
            } label: {
                Text("Reset")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
            Spacer()
            
            Button {
                coinCount += coinPerClick // Увеличиваем количество монет за клик
                UserDefaults.standard.set(coinCount, forKey: "clickCount")
            } label: {
                Text("Click me!")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.cancel() // Остановка таймера при закрытии представления
        }
    }
    
    private func startTimer() {
        // Создание таймера, который срабатывает каждую секунду
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                coinCount += coinPerSecond
                UserDefaults.standard.set(coinCount, forKey: "clickCount")
            }
    }
}

#Preview {
    ContentView()
}
