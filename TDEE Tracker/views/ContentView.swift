//
//  ContentView.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 6/1/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import SwiftUI

enum NavbarTag: Int {
    case entryPage, trendsPage, progressPage, setupPage
}

struct NavbarItem {
    
    let label: String
    let icon: String
    let tag: NavbarTag
}

struct ContentViewSizes {
    
    // MARK: - Sizes
    
    public let navbarItemSpacing: CGFloat
    public let navbarItemIconSize: CGFloat
    public let navbarViewBorderHeight: CGFloat
    
    public let tutorialNoteTPadding: CGFloat
    
    public let navbarItemIconTPadding: CGFloat
    public let navbarViewSpacing: CGFloat
    public let navbarViewHeight: CGFloat
    
    // MARK: - Fonts
    
    public let navbarItemLabel: Font
    
    // MARK: - Init
    
    init(hasNotch: Bool, scale: CGFloat) {
        
        self.navbarItemSpacing = scale * 2
        self.navbarItemIconSize = scale * 22
        self.navbarViewBorderHeight = scale * 1
        
        self.tutorialNoteTPadding = scale * 40

        self.navbarItemLabel = .custom(FontOswald.Light, size: scale * 12)
        
        if hasNotch {
            self.navbarItemIconTPadding = scale * 12
            self.navbarViewSpacing = scale * 54
            self.navbarViewHeight = scale * 84
        }
        else {
            self.navbarItemIconTPadding = scale * 6
            self.navbarViewSpacing = scale * 38
            self.navbarViewHeight = scale * 56
        }
    }
}


struct ContentView: View {

    private let sizes = ContentViewSizes(hasNotch: UISizes.hasNotch, scale: UISizes.scale)
    
    @EnvironmentObject var appState: AppState
    
    @State var selectedTab = NavbarTag.entryPage
    
    let navbarItems: [ NavbarItem ] = [
        NavbarItem(label: Label.entry, icon: "create-sharp", tag: NavbarTag.entryPage),
        NavbarItem(label: Label.trends, icon: "calendar-sharp", tag: NavbarTag.trendsPage),
        NavbarItem(label: Label.progress, icon: "stats-chart-sharp", tag: NavbarTag.progressPage),
        NavbarItem(label: Label.settings, icon: "options-sharp", tag: NavbarTag.setupPage)
    ]
    
    func navbarItem(item: NavbarItem) -> some View {

        let isSelected = ( item.tag == self.selectedTab )
        
        return Button(
            action: {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                self.selectedTab = item.tag
            },
            label: {

                VStack(alignment: .center, spacing: self.sizes.navbarItemSpacing) {
                    
                    CustomImage(
                        name: item.icon,
                        colorName: (
                            isSelected
                                ? self.appState.uiTheme.mainTextColorName
                                : self.appState.uiTheme.navbarAccentColorName
                        )
                    )
                        .frame(width: self.sizes.navbarItemIconSize, height: self.sizes.navbarItemIconSize)
                        .padding(.top, self.sizes.navbarItemIconTPadding)

                    Text(item.label)
                        .font(self.sizes.navbarItemLabel)
                        .foregroundColor(
                            isSelected
                                ? self.appState.uiTheme.mainTextColor
                                : self.appState.uiTheme.navbarAccentColor
                    )
                }
            }
        )
    }
    
    var mainAppView: some View {
        
        switch self.selectedTab {

            case NavbarTag.entryPage:
                return AnyView( EntryPage() )
            case NavbarTag.trendsPage:
                return AnyView( TrendsPage() )
            case NavbarTag.progressPage:
                return AnyView( ProgressPage() )
            case NavbarTag.setupPage:
                return AnyView( SetupPage() )
        }
    }
    
    var navbarView: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            Rectangle()
                .frame(height: self.sizes.navbarViewBorderHeight)
                .foregroundColor(self.appState.uiTheme.navbarAccentColor)
                .opacity(0.5)
            
            HStack(alignment: .center, spacing: self.sizes.navbarViewSpacing) {
                
                ForEach(self.navbarItems, id: \.tag) { item in
                    self.navbarItem(item: item)
                }
            }
                .frame(maxWidth: .infinity)
                .frame(height: self.sizes.navbarViewHeight, alignment: .top)
                .background(self.appState.uiTheme.navbarBackgroundColor)
        }
    }
    
    var defaultView: some View {
        
        ZStack {
            
            if self.appState.isFirstSetupDone {

                self.mainAppView
                    .disabled(!self.appState.tutorialStep.isDoneOrEqual())
                    .frame(maxHeight: .infinity, alignment: .top)
                
                self.navbarView
                    .blur(radius: self.appState.tutorialStep.isDoneOrEqual() ? 0 : 8)
                    .disabled(!self.appState.tutorialStep.isDoneOrEqual())
                    .frame(maxHeight: .infinity, alignment: .bottom)
                
                // MARK: - Tutorial
                
                if self.appState.tutorialStep != TutorialStep.Done {
                    
                    TutorialOverlay(
                        mainColor: self.appState.uiTheme.backgroundColor,
                        accentColor: self.appState.uiTheme.mainTextColor,
                        step: self.appState.tutorialStep,
                        nextStepAction: self.appState.nextTutorialStep
                    )
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top, self.sizes.tutorialNoteTPadding)
                }
            }
            else {

                WelcomePage()
            }
        }
    }

    var currentInputVariable: Binding<String>? {
        
        switch self.appState.currentInput {
            case Optional(InputName.Weight):
                return self.$appState.weightInput
            case Optional(InputName.Food):
                return self.$appState.foodInput
            case Optional(InputName.GoalWeight):
                return self.$appState.goalWeightInput
            case Optional(InputName.GoalWeeklyWeightDelta):
                return self.$appState.goalWeeklyWeightDeltaInput
            case Optional(InputName.ReminderWeightDate):
                return self.$appState.reminderWeightDateInput
            case Optional(InputName.ReminderFoodDate):
                return self.$appState.reminderFoodDateInput
            default:
                return nil
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            self.appState.uiTheme.backgroundColor.edgesIgnoringSafeArea(.all)
                
            // MARK: - Main View
            
            self.defaultView
            
            // MARK: - Payment Modal/Loader
            
            if self.appState.showBuyModal {
                
                ConfirmationModal(
                    fadeColor: self.appState.uiTheme.backgroundColor,
                    backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                    accentColor: self.appState.uiTheme.secondaryTextColor,
                    textColor: self.appState.uiTheme.calendarTextDefaultColor,
                    separatorColor: self.appState.uiTheme.trendsSeparatorColor,
                    confirmLabel: StoreManager.shared.getProductButtonLabelById(
                        StoreManager.shared.PREMIUM_PRODUCT_ID
                    ),
                    confirmAction: {
                        self.appState.buyPremiumModal(isOpen: false)
                        self.appState.buyPremium()
                    },
                    cancelAction: { self.appState.buyPremiumModal(isOpen: false) }
                )
            }
            
            if self.appState.showLoader {
                
                LoaderSpinner(
                    mainColor: self.appState.uiTheme.backgroundColor,
                    accentColor: self.appState.uiTheme.mainTextColor,
                    text: self.appState.loaderText
                )
            }

            // MARK: - Notification
            
            if !self.appState.messageText.isEmpty {
                
                AlertMessage(
                    text: self.appState.messageText.uppercased(),
                    textColor: self.appState.uiTheme.mainTextColor,
                    backgroundColor: self.appState.uiTheme.warningBackgroundColor,
                    closeAction: self.appState.hideMessage
                )
                    .frame(maxHeight: .infinity, alignment: .top)
            }
            
            // MARK: - Keyboard
            
            if let inputVariable = self.currentInputVariable,
               let keyboardType = self.appState.currentInput?.keyboardType {
                CustomKeyboard(type: keyboardType, input: inputVariable)
            }
        }
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static let appState = AppState()
    
    static var previews: some View {
        ContentView().environmentObject(appState)
    }
}
