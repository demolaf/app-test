//
//  HomeSectionTabView.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 17/06/2024.
//

import SwiftUI

struct HomeSectionTabView: View {
    @Binding var selectedTab: HomeTabSection
    @Namespace private var name

    var body: some View {
        HStack(spacing: 0) {
            ForEach(HomeTabSection.allCases, id: \.hashValue) { section in
                Button {
                    selectedTab = section
                } label: {
                    VStack {
                        Text(section.title.capitalized)
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundColor(selectedTab == section ? .appPrimary : Color(uiColor: .systemGray))
                        ZStack {
                            Capsule()
                                .fill(.inactiveTab)
                                .frame(height: 2)
                            if selectedTab == section {
                                Capsule()
                                    .fill(.appPrimary)
                                    .frame(height: 2)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
            }
        }
    }
}
