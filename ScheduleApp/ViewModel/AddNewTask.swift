//
//  AddNewTask.swift
//  ScheduleApp
//
//  Created by Carlos Cayres on 12/05/22.
// 10:45

import SwiftUI

struct AddNewTask: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    @Environment(\.self) var env
    
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 12) {
            
            //MARK: - Header
            Text("Editar Tarefa")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
            
            Divider()
                .padding(.vertical, 10)
            
            //MARK: - Color selection
            VStack(alignment: .leading, spacing: 12) {
                Text("Cor do Texto")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                let colors = ["Yellow", "Green", "Blue", "Red", "Orange"]
                
                HStack(spacing: 16) {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(Color(color))
                            .frame(width: 25, height: 25)
//                            .background {
//                                if taskViewModel.textColor == color {
//                                    Circle()
//                                        .strokeBorder(.gray)
//                                        .padding(-3)
//                                }
//                            }
                            .contentShape(Circle())
                            .onTapGesture {
                                taskViewModel.taskColor = color
                            }
                    }
                }
                .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 30)
            
            Divider()
                .padding(.vertical, 10)
            
            //MARK: - Deadline Selection
            VStack(alignment: .leading, spacing: 12) {
                Text("Deadline")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(taskViewModel.taskDeadline.formatted(date: .abbreviated, time: .omitted) + ", " +
                     taskViewModel.taskDeadline.formatted(date: .omitted, time: .shortened))
                .font(.callout)
                .fontWeight(.semibold)
                .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    taskViewModel.showDatePicker.toggle()
                } label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                }
            }
            
            Divider()
                .padding(.vertical, 10)
            
            //MARK: - Title Input
            VStack(alignment: .leading, spacing: 12) {
                Text("Titulo")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("", text: $taskViewModel.tasktitle)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
            }
            
            Divider()
                .padding(.vertical, 10)
            
            
            //MARK: Type Selection
            let taskTypes = ["Basic", "Urgente", "Importante"]
            VStack(alignment: .leading, spacing: 12) {
                Text("Tipo")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack(spacing: 12) {
                    ForEach(taskTypes, id: \.self) { type in
                        Text(type)
                            .font(.callout)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(taskViewModel.taskType == type ? .white : .black)
                            .background {
                                if taskViewModel.taskType == type {
                                    Capsule()
                                        .fill(.black)
                                        .foregroundColor(.white)
                                        .matchedGeometryEffect(id: "TYPE", in: animation)
                                } else {
                                    Capsule()
                                        .strokeBorder(.black)
                                }
                            }
                            .contentShape(Capsule())
                            .onTapGesture {
                                withAnimation{ taskViewModel.taskType = type }
                            }
                    }
                }
                .padding(.top, 8)
            }
            .padding(.vertical, 12)
            
            Button {
                if taskViewModel.addTask(context: env.managedObjectContext) {
                    env.dismiss()
                }
                
            } label: {
                Text("Salvar")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .foregroundColor(.white)
                    .background {
                        Capsule()
                            .fill(.black)
                    }
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
            .padding(.bottom, 10)
            .disabled(taskViewModel.tasktitle == "")
            .opacity(taskViewModel.tasktitle == "" ? 0.6 : 1)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay {
            ZStack {
                if taskViewModel.showDatePicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            taskViewModel.showDatePicker = false
                        }
                    
                    DatePicker.init("",
                                    selection: $taskViewModel.taskDeadline,
                                    in: Date.now...Date.distantFuture)
                        .labelsHidden()
                        .padding()
                        .background(.white,
                                    in:RoundedRectangle(cornerRadius: 12,
                                                                style: .continuous))
                        .padding()
                }
            }
            .animation(.easeInOut, value: taskViewModel.showDatePicker)
        }
    }
}

struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
            .environmentObject(TaskViewModel())
    }
}
