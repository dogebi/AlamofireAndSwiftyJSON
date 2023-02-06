//
//  ContentView.swift
//  AlamofireAndSwiftyJSON
//
//  Created by mac on 2023/2/6.
//

import SwiftUI
import SDWebImageSwiftUI
import Alamofire
import SwiftyJSON

struct ContentView: View {
    
    @ObservedObject var obs = observer()

    var body: some View {
        
        
        NavigationView{
            
            List(obs.datas){ i in
                
                card(name: i.name, url:i.url)
                
            }.navigationBarTitle("JSON Parse")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class observer : ObservableObject{

    @Published var datas = [datatype]()

    init(){
        
        AF.request("https://api.github.com/users/hadley/orgs").responseData { (data) in

            let json = try! JSON(data: data.data!)

            for i in json{

                print(i.1)
            
                self.datas.append(datatype(id: i.1["id"].intValue, name: i.1["login"].stringValue, url: i.1["avatar_url"].stringValue))

            }
        }
    }
}


struct datatype : Identifiable {
    
    var id : Int
    var name : String
    var url : String
}


struct card : View{
    
    var name = ""
    var url = ""
    
    var body : some View{
        
        HStack{
            
            AnimatedImage(url: URL(string: url)!)
                .resizable()
                .frame(width: 60,height: 60)
                .clipShape(Circle())
                .shadow(radius: 20)
            
            Text(name).fontWeight(.heavy)
            
        }
    }
}
