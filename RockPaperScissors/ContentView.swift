//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Viettasc Doan on 3/18/20.
//  Copyright © 2020 Viettasc Doan. All rights reserved.
//

import SwiftUI

struct Move {
    var tyemtee: Int = 0
    var win: Bool = true
    var you: Int = 1
}

struct ContentView: View {
    @State var you: Int = 0
    let moves = ["hand.thumbsup", "hand.raised",  "hand.point.right"]
    var possible: [Move] {
        [
            .init(tyemtee: 0, win: true, you: 2),
            .init(tyemtee: 1, win: true, you: 0),
            .init(tyemtee: 2, win: true, you: 1),
            .init(tyemtee: 0, win: false, you: 1),
            .init(tyemtee: 1, win: false, you: 2),
            .init(tyemtee: 2, win: false, you: 0)
        ]
    }
    @State var boss = Int.random(in: 0...2)
    @State var move = Bool.random()
    @State var solution: Bool?
    
    var tyemtee: some View {
        ZStack {
            if boss == 0 {
                rock
            } else if boss == 1 {
                paper
            } else if boss == 2 {
                scissor
            }
        }
    }
    
    var rock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke()
            
            Image(systemName: moves[0])
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(-90))
                .padding()
        }
    }
    
    var paper: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke()
            Image(systemName: moves[1])
                .resizable()
                .scaledToFit()
                .padding()
        }
    }
    
    var scissor: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke()
            Image(systemName: moves[2])
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(-90))
                .padding()
        }
    }
    
    func choose(number: Int) {
        print("you: ", number)
        var draft = false
        for item in possible {
            if number == item.you && boss == item.tyemtee && move == item.win {
                draft = true
                print("item: ", item)
                break
            }
        }
        solution = draft
        boss = Int.random(in: 0...2)
        move = Bool.random()
        print("choose, move: ", move)
        print("choose, boss: ", boss)
    }
    
    var body: some View {
        ZStack {
            Color.pink.opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Section(header: Text("Tyemtee's move:")) {
                    HStack(spacing: 20) {
                        Image("tyemtee")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(Circle()
                                .stroke(lineWidth: 3)
                        )
                        Spacer()
                        tyemtee
                            .frame(width: 123, height: 123)
                            .onAppear {
                                print("boss: ", self.boss)
                        }
                    }
                }
                .padding()
                Section(header: Text("Tyemtee wants to:")) {
                    HStack {
                        Spacer()
                        
                        Text("\(move ? "win!" : "give you a win!")")
                            .font(.largeTitle)
                            .bold()
                        
                        
                    }
                    
                }
                .padding()
                Section(header: Text("Your choice:")) {
                    HStack(spacing: 20) {
                        rock
                            .onTapGesture {
                                self.choose(number: 0)
                        }
                        paper
                            .onTapGesture {
                                self.choose(number: 1)
                        }
                        scissor
                            .onTapGesture {
                                self.choose(number: 2)
                        }
                    }
                    .foregroundColor(.black)
                    .scaledToFit()
                }
                .padding()
                Section(header: Text("Return :")) {
                    HStack {
                        Spacer()
                        ZStack { RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.white)
                            if solution != nil {
                                Text(solution! ? "You are smart!" : "You are not so smart!")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(height: 60)
                    }
                }
                .padding()
                Spacer()
            }
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
