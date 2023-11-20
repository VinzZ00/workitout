//
//  YogaDetailView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import SwiftUI
import CoreData

struct YogaDetailView: View {
    @StateObject var yvm: YogaDetailViewModel
    
    @EnvironmentObject var dm: DataManager
    
    @State var isPresentedExecution = false
    @EnvironmentObject var vm: HomeViewModel
    @Binding var sheetToggle : Bool
    @Binding var path : NavigationPath
    
    @State private var state: YogaPreviewEnum = .relieveChoice
    @State var showHeader: Bool = true
    
    var yogaTitle: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                if state == .relieveChoice {
                    if showHeader {
                        Text(state.getTitle(yoga: yvm.newYoga, yogaTitle: yogaTitle))
                            .font(.largeTitle)
                            .bold()
                        state.getDescription(yoga: yvm.oldYoga)
                    }
                    VStack {
                        ScrollListenerViewBuilder(showContent: $showHeader) {
                            RelieveAssesmentView()
                                .environmentObject(yvm)
                                .padding(.vertical)
                        }
                        if showHeader {
                            HStack{
                                Image(systemName: "info.circle.fill")
                                Text("You can skip this part if you feel no pain")
                            }
                            .foregroundStyle(Color.neutral3)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.ultraThinMaterial)
                            .borderedCorner()
                        }
                    }
                    
                }
                else {
                    if showHeader {
                        Text(state.getTitle(yoga: yvm.newYoga, yogaTitle: yogaTitle))
                            .font(.largeTitle)
                            .bold()
                        state.getDescription(yoga: yvm.newYoga)
                    }
                    ScrollListenerViewBuilder(showContent: $showHeader){
                        YogaPreviewView(oldYoga: yvm.oldYoga, newYoga: yvm.newYoga)
                    }
                }
                
                ButtonComponent(title: state.rawValue) {
                    if state == .relieveChoice {
                        withAnimation {
                            dm.pm.addPosetoPoses()
                            yvm.relievesPoses = dm.posesByRelieves(relieves: yvm.selectedRelieves)
                            yvm.newYoga = yvm.addRelieves(yoga: yvm.oldYoga)
                            state = .yogaPreview
                        }
                        
                    }
                    else {
                        sheetToggle = false
                        path.append("String")
                    }
                }
            }
            .onAppear(perform: {
                if yogaTitle != "" {
                    yvm.newYoga = yvm.oldYoga
                    state = .yogaPreview
                }
            })
            .navigationTitle(showHeader ? "" : state.getTitle(yoga: yvm.newYoga, yogaTitle: yogaTitle))
            .navigationBarTitleDisplayMode(.inline)
            .padding()
//            .animation(.default, value: state)
            .animation(.default, value: showHeader)
            .toolbarBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    IconButtonComponent(icon: state.getIcon()) {
                        if state == .relieveChoice {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        else {
                            if yogaTitle != "" {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            state = .relieveChoice
                        }
                    }
                    .contentTransition(.symbolEffect(.automatic))
                }
            }
            
        }
    }
    
    enum YogaPreviewEnum: LocalizedStringResource {
        case relieveChoice = "Next"
        case yogaPreview = "Start Now"
        
        func getIcon() -> String {
            switch self {
            case .relieveChoice:
                return "xmark"
            case .yogaPreview:
                return "chevron.left"
            }
        }
        
        func getTitle(yoga: Yoga, yogaTitle: String = "") -> String {
            switch self {
            case .relieveChoice:
                return "What Are Your Current Conditions?"
            case .yogaPreview:
                if yogaTitle != "" {
                    return yogaTitle
                }
                else {
                    return yoga.name
                }
            }
        }
        
        @ViewBuilder
        func getDescription(yoga: Yoga) -> some View {
            switch self {
            case .relieveChoice:
                Text("Select your physical conditions below, and we will help you find the perfect yoga poses to improve your conditions. ") + Text("(You can skip this part)").foregroundStyle(.purple)
            case .yogaPreview:
                Text("\(yoga.poses.count) Exercise (\(yoga.estimationDuration) Min)")
                    .foregroundStyle(Color.neutral3)
            }
        }
    }
}

//#Preview {
//    YogaDetailView(sheetToggle: .constant(false), path: .constant(NavigationPath()), yoga: Yoga())
//}
