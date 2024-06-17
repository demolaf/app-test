//
//  HomeView.swift
//  care-saas-test
//
//  Created by Ademola Fadumo on 13/06/2024.
//

import SwiftUI

enum HomeTabSection: CaseIterable {
    case medication
    case activities

    var title: String {
        switch self {
        case .medication:
            "Medication"
        case .activities:
            "Activities"
        }
    }
}

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedTab: HomeTabSection = .medication

    var body: some View {
        NavigationStack {
            VStack {
                Spacer(minLength: 24)
                VStack(spacing: 24) {
                    navigationBar
                    clockInButton
                    //takeABreakButton
                }
                .padding(.horizontal, 16)
                Spacer(minLength: 36)
                VStack(spacing: 0) {
                    HomeSectionTabView(selectedTab: $selectedTab)
                        .padding(.horizontal, 16)
                    if viewModel.isLoading {
                        VStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .appPrimary))
                                .scaleEffect(1)
                                .padding(.vertical, 8)
                            Spacer()
                        }
                    } else {
                        TabView(selection: $selectedTab) {
                            HomeTabSectionListView(tasks: viewModel.tasks)
                                .tag(HomeTabSection.medication)
                            HomeTabSectionListView(tasks: [])
                                .tag(HomeTabSection.activities)
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .task {
                viewModel.initialize()
            }
        }
    }

    var navigationBar: some View {
        HStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Text("Hi, \(viewModel.user?.name ?? "N/A")!")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(.appSecondary)
                        Text("Clocked In")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.appPrimary)
                    }
                    Text("Clock-in to begin your task")
                }
                Spacer()
            }
            ZStack {
                Image(systemName: "bell")
                    .font(.system(size: 14))
                    .foregroundStyle(.appTextFieldBorder)
                Circle()
                    .foregroundStyle(.red)
                    .frame(width: 4, height: 4)
                    .offset(x: 6, y: -10)
            }
            .padding(12)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.appTextFieldBorder, lineWidth: 1)
            }
        }
    }

    var clockInButton: some View {
        Button {
            print("Clock-in button pressed")
        } label: {
            Text("Clock-in")
                .font(.system(size: 14, weight: .bold))
                .frame(maxWidth: .infinity)
        }
        .tint(.appPrimary)
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }

    var takeABreakButton: some View {
        HStack {
            Button {
                print("Take a break button pressed")
            } label: {
                Text("Take a Break")
                    .font(.system(size: 14, weight: .bold))
                    .frame(maxWidth: .infinity)
            }
            .tint(.yellow)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            Button {
                print("Clock-out button pressed")
            } label: {
                Text("Clock-out")
                    .font(.system(size: 14, weight: .bold))
                    .frame(maxWidth: .infinity)
            }
            .tint(.red)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel(userRepository: RepositoryProvider.shared.userRepository))
}
