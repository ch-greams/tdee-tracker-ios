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
    
    public let navbarItemSpacing: CGFloat = 2
    public let navbarItemIconSize: CGFloat = 26
    public let navbarViewBorderHeight: CGFloat = 1
    
    public let navbarItemIconTPadding: CGFloat
    public let navbarViewSpacing: CGFloat
    public let navbarViewHeight: CGFloat
    
    public let visibleScreenOffset: CGFloat
    public let visibleScreenHeight: CGFloat
    
    // MARK: - Fonts
    
    public let navbarItemLabel: Font = .custom(FontOswald.Light, size: 12)
    
    // MARK: - Init
    
    init(uiSizes: UISizes) {
        
        self.navbarItemIconTPadding = uiSizes.navbarPadding
        self.navbarViewSpacing = uiSizes.navbarSpacing
        self.navbarViewHeight = uiSizes.navbarHeight
        
        self.visibleScreenOffset = uiSizes.mvVisibleScreenOffset
        self.visibleScreenHeight = uiSizes.mvVisibleScreenHeight
    }
}


struct ContentView: View {

    private let sizes = ContentViewSizes(uiSizes: UISizes.current)
    
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
        
        return Button(action: { self.selectedTab = item.tag }) {

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
    
    var buyButtonLabel: String {
        
        if let price = StoreManager.shared.getProductPriceById(StoreManager.shared.PREMIUM_PRODUCT_ID) {
            
            return "\(Label.buyFor) \(price)"
        }
        else {

            return Label.buy
        }
    }

    var body: some View {
        
        ZStack(alignment: .top) {
            
            self.appState.uiTheme.backgroundColor.edgesIgnoringSafeArea(.all)
                
            // MARK: - Main View
            
            if self.appState.isFirstSetupDone {

                self.mainAppView
                    .padding(.top, self.sizes.visibleScreenOffset)
                
                self.navbarView
                    .padding(.top, self.sizes.visibleScreenHeight)
            }
            else {

                WelcomePage()
            }
            
            // MARK: - Payment Modal/Loader
            
            if self.appState.showBuyModal {
                
                ConfirmationModal(
                    fadeColor: self.appState.uiTheme.backgroundColor,
                    backgroundColor: self.appState.uiTheme.inputBackgroundColor,
                    accentColor: self.appState.uiTheme.secondaryTextColor,
                    textColor: self.appState.uiTheme.calendarTextDefaultColor,
                    separatorColor: self.appState.uiTheme.trendsSeparatorColor,
                    confirmLabel: self.buyButtonLabel,
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
                    .padding(.top, (
                        self.appState.isFirstSetupDone ? self.sizes.visibleScreenOffset : 0
                    ))
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
