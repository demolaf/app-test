//
//  HomeTabSectionListView.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 14/06/2024.
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

struct HomeTabSectionListView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<20) { index in
                    homeListItem
                        .padding(.bottom, 12)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
        }
    }

    var homeListItem: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("4 Medications to take")
                Spacer()
                Image(systemName: "arrow.up.right.circle")
            }
            HStack {
                Image(systemName: "person")
                Text("James")
            }
            HStack {
                HStack(spacing: 16) {
                    HStack {
                        Image(systemName: "door.right.hand.open")
                        Text("James")
                    }
                    HStack {
                        Image(systemName: "bed.double")
                        Text("Bed 45")
                    }
                }
                Spacer()
                HStack {
                    Image(systemName: "clock")
                    Text("10:00 AM")
                }
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.homeListTile)
        }
    }
}
