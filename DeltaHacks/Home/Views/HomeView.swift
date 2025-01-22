//
//  HomeView.swift
//  DeltaHacks
//
//  Created by Kabir Kumar on 2025-01-11.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var refreshView = false
    
    var body: some View {
        let result = viewModel.userMetaData
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text("Welcome")
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Recycling")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.blue)
                            Text("\(viewModel.recyclableP)%")
                                .bold()
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Garbage")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.gray)
                            
                            Text("\(viewModel.garbageP)%")
                                .bold()
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Organics")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.green)
                                
                            Text("\(viewModel.organicsP)%")
                                .bold()
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Glass")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.orange)
                            
                            Text("\(viewModel.glassP)%")
                                .bold()
                        }
                        .padding(.init(top: 0, leading: 0, bottom: 8, trailing: 27))
                        
                        
                    }
                    
                    Spacer()
                    
                    ZStack {
                        // MARK: the rings for progress
                        
                        // recycling
                        ProgressCircleView(progress: viewModel.userMetaData.recycling, goal: viewModel.userMetaData.recyclingGoal, color: .blue)
                        
                        // garbage
                        ProgressCircleView(progress: viewModel.userMetaData.garbage, goal: viewModel.userMetaData.garbageGoal, color: .gray)
                            .padding(.all, 20)
                        
                        // organics
                        ProgressCircleView(progress: viewModel.userMetaData.organics, goal: viewModel.userMetaData.organicsGoal, color: .green)
                            .padding(.all, 40)
                        
                        // glass
                        ProgressCircleView(progress: viewModel.userMetaData.glass, goal: viewModel.userMetaData.glassGoal, color: .orange)
                            .padding(.all, 60)
                        
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text("Waste Overview")
                    
                    Spacer()
                    
                    Button {
                        print("none linked")
                    } label: {
                        Text("Show more")
                            .padding(.all, 10)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(15)
                    }
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                    
                    WasteCardView(waste: Waste(id: 0, title: "Recycling", subtitle: "Goal \(viewModel.userMetaData.recyclingGoal)", image: "arrow.3.trianglepath", tintColor: .blue, amount: String(viewModel.userMetaData.recycling)))
                    
                    WasteCardView(waste: Waste(id: 1, title: "Garbage", subtitle: "Goal \(viewModel.userMetaData.garbageGoal)", image: "trash", tintColor: .gray, amount: "\(viewModel.userMetaData.garbage)"))
                    
                    WasteCardView(waste: Waste(id: 2, title: "Organics", subtitle: "Goal \(viewModel.userMetaData.organicsGoal)", image: "carrot", tintColor: .green, amount: "\(viewModel.userMetaData.organics)"))
                    
                    WasteCardView(waste: Waste(id: 3, title: "Glass", subtitle: "Goal \(viewModel.userMetaData.glassGoal)", image: "wineglass", tintColor: .orange, amount: "\(viewModel.userMetaData.glass)"))
                }
                .padding(.horizontal)
                
            }
        }
        .id(refreshView)
    }
}

#Preview {
    HomeView()
}
