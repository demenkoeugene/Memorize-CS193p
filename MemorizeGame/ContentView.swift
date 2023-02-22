//  ContentView.swift
//  Memorize
//
//  Created by Eugene Demenko on 25.01.2023.
//
//Views
import SwiftUI

struct ContentView: View {
    
    //Array
    @State var vihicles_array = ["🚗","🚌","🚲","🚄","🚛", "🚜", "🏎", "🚓", "🚑", "🚒", "🚐", "✈️", "🛵","🚇","🚢", "🛥", "🛴", "🚕", "🚙", "🚝", "🚞", "🚤", "⛴", "🛩"]
    @State var animal_array = ["🐶","🐱","🐭","🐹","🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮","🐷","🐽", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🦆", "🦅", "🦉"]
    @State var food_array = ["🍏","🍎","🍐","🍊","🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑","🥭","🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶"]
    
    
    @State var emojiesCount = randomaizer()
    
    @State var switchArray: Int = 1//my switch variable
    
    
    var body: some View {
        
        VStack{
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(0)
            ScrollView{
                if switchArray==1{
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]){
                        ForEach(vihicles_array[0..<emojiesCount], id: \.self) { emoji in
                            CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                        }
                    }.padding(10)
                }else if switchArray==2{
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]){
                        ForEach(animal_array[0..<emojiesCount], id: \.self) { emoji in
                            CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                        }
                    }.padding(10)
                }else if switchArray==3{
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]){
                        ForEach(food_array[0..<emojiesCount], id: \.self) { emoji in
                            CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                        }
                    }.padding(10)
                }
                    
                
                
            }
            Spacer()
            HStack{
                Spacer()
                Vehicles
                Spacer()
                theme2
                Spacer()
                theme3
                Spacer()
            }.padding(.horizontal).font(.largeTitle)
        }.foregroundColor(.blue).padding(.horizontal)
    }
    
    var Vehicles: some View{
        Button{
            switchArray = 1
            vihicles_array.shuffle() //shuffle array
            emojiesCount =  randomaizer() //update value number of cards
        } label: {
            VStack{
               Image(systemName: "car")
                Text("Vehicles")
                    .font(.caption)
            }
            
        }
    }
    var theme2: some View{
        Button{
            switchArray = 2
            animal_array.shuffle() //shuffle array
            emojiesCount =  randomaizer() //update value number of cards
        } label: {
            VStack{
               Image(systemName: "pawprint")
                Text("Animals")
                    .font(.caption)
            }
            
        }
    }
    var theme3: some View{
        Button{
            switchArray = 3
            food_array.shuffle() //shuffle array
            emojiesCount = randomaizer() //update value number of cards
        } label: {
            VStack{
               Image(systemName: "fork.knife.circle")
                Text("Food")
                    .font(.caption)
            }
            
        }
    }
}


//randomaizer for cards
func randomaizer() -> Int{
    return  Int.random(in: 4...24)
}

struct CardView: View{
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack{
            
            let shape = RoundedRectangle(cornerRadius: 25)
            if isFaceUp{
                
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(content).font(.largeTitle).padding()
            }else{
                shape.fill()
            }
        }.onTapGesture{
                    isFaceUp = !isFaceUp
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
        ContentView().preferredColorScheme(.light)
    }
}
