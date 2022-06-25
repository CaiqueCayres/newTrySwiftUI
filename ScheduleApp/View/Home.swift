//
//  Home.swift
//  ScheduleApp
//
//  Created by Carlos Cayres on 12/05/22.
// 6:00

import SwiftUI

struct Home: View {
    
    @StateObject var taskModel: TaskViewModel = .init()
    
    @Namespace var animation
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome")
                        .font(.callout)
                    Text("Here`s Update Today.")
                        .font(.title2.bold())
                }
                .frame(width: .infinity, alignment: .leading)
                .padding(.vertical)
                
            CustomSegmentedBar()
                    .padding(.top, 5)
            }
            .padding()
        }
        .overlay(alignment: .bottom) {
            Button {
                taskModel.openEditTask.toggle()
            } label: {
                Label {
                    Text("Adicionar")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: "plus.app.fill")
                        .foregroundColor(.white)
                }
                .foregroundColor(.black)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(.black, in: Capsule())
            }
            .padding(.top, 20)
            .frame(maxWidth: .infinity)
            .background {
                LinearGradient(colors: [.white.opacity(0.85),
                                        .white.opacity(0.4),
                                        .white.opacity(0.7)],
                               startPoint: .top,
                               endPoint: .bottom)
            }
        }
        .fullScreenCover(isPresented: $taskModel.openEditTask) {
            taskModel.resetTaskData()
        } content: {
            AddNewTask()
                .environmentObject(taskModel)
        }
    }
    
    @ViewBuilder
    func CustomSegmentedBar() -> some View {
        let tabs = ["Hoje", "Em Breve", "Concluidas"]
        HStack(spacing: 10) {
            ForEach(tabs, id: \.self) { tab in
                Text(tab)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(taskModel.currentTab == tab ? .white : .black)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .background {
                        if taskModel.currentTab == tab {
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation { taskModel.currentTab = tab }
                    }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
