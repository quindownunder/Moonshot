//
//  AstronautView.swift
//  Moonshot
//
//  Created by Matthew Richardson on 24/8/20.
//  Copyright © 2020 Matthew Richardson. All rights reserved.
//

import SwiftUI


struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission]
    //var flownMissions = [Mission]()
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var matches = [Mission]()
        
        for mission in missions {
            for crew in mission.crew {
                if self.astronaut.id == crew.name {
                    matches.append(mission)
                }
            }
        }
        
        self.missions = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Missions Flown")
                        .padding()
                    ForEach(self.missions, id: \.id) { mission in
                        Text("\(mission.displayName) \(mission.formattedLaunchDate)")
                    }
                }
            }
        }
        .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
         AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
