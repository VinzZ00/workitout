//
//  YogaDetailView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 31/10/23.
//

import SwiftUI
import CoreData

struct YogaDetailView: View {
    @State var isPresentedExecution = false
    @EnvironmentObject var vm: HomeViewModel
    @Binding var sheetToggle : Bool
    @Binding var path : NavigationPath
    
    var yoga: Yoga
    @State private var state: YogaPreviewEnum = .relieveChoice
    @State var showHeader: Bool = true
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                Text(state.getTitle())
                    .font(.largeTitle)
                    .bold()
                state.getDescription(yoga: yoga)
                
                ScrollListenerViewBuilder(showContent: $showHeader) {
                    if state == .relieveChoice {
                        RelieveAssesmentView()
                    }
                    else {
                        YogaPreviewView(yoga: yoga)
                    }
                }
                
                ButtonComponent(title: state.rawValue) {
                    if state == .relieveChoice {
                        state = .yogaPreview
                    }
                    else {
                        sheetToggle = false
                        path.append("String")
                    }
                    
                }
            }
            .padding()
            .animation(.default, value: state)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    IconButtonComponent(icon: state.getIcon()) {
                        if state == .relieveChoice {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        else {
                            state = .relieveChoice
                        }
                    }
                }
            }
            
        }
    }
    
    enum YogaPreviewEnum: String {
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
        
        func getTitle() -> String {
            switch self {
            case .relieveChoice:
                return "What Are Your Current Conditions?"
            case .yogaPreview:
                return "Balancing and Grounding"
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

#Preview {
    YogaDetailView(sheetToggle: .constant(false), path: .constant(NavigationPath()), yoga: Yoga())
}
