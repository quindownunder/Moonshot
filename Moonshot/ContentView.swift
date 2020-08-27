//
//  ContentView.swift
//  Moonshot
//
//  Created by Matthew Richardson on 23/8/20.
//  Copyright © 2020 Matthew Richardson. All rights reserved.
//

import SwiftUI

struct CrewList: View {
    
    var astronauts = [CrewMember]()
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(self.astronauts, id: \.role) { crewMember in
                Text(crewMember.astronaut.name)
            }
        }
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        
        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
}

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingCrew = false
    
    @State var crewNames = [String]()
        
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, missions: self.missions)) {
                    
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if self.showingCrew {
                            CrewList(mission: mission, astronauts: self.astronauts)
                            
                        } else {
                            Text(mission.formattedLaunchDate)
                        }
                    }
                    
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(leading:
                Button(action: {
                    self.showingCrew.toggle()
                }) {
                    Image(systemName: self.showingCrew ? "calendar" : "person.3")
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
