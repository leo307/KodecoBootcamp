//
//  vtmapp_iosApp.swift
//  vtmapp-ios
//
//  Created by Leo DelPrete on 7/8/24.
//
import SwiftUI
import AVKit

struct AssetDetailView: View {
    @StateObject private var viewModel: AssetDetailViewModel
    @Binding var isAuthenticated: Bool

    init(assetID: Int, isAuthenticated: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: AssetDetailViewModel(assetID: assetID, isAuthenticated: isAuthenticated))
        _isAuthenticated = isAuthenticated
    }

    var body: some View {
        VStack {
            if let asset = viewModel.asset {
                TabView {
                    VideoView(player: viewModel.player, asset: asset)
                        .tabItem {
                            Label("Video", systemImage: "play.circle")
                        }

                    AssetDetailsView(asset: asset)
                        .tabItem {
                            Label("Information", systemImage: "info.circle")
                        }
                }

                Button(action: {
                    Task {
                        await viewModel.toggleDownload()
                    }
                }) {
                    HStack {
                        if viewModel.isDownloaded {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .scaleEffect(viewModel.isDownloaded ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 1.0), value: viewModel.isDownloaded)
                            Text("Downloaded")
                                .foregroundColor(.green)
                                .opacity(viewModel.isDownloaded ? 1.0 : 0.0)
                                .animation(.easeInOut(duration: 1.0), value: viewModel.isDownloaded)
                        } else {
                            Image(systemName: "arrow.down.circle")
                                .foregroundColor(.primary)
                                .scaleEffect(viewModel.isDownloaded ? 1.0 : 1.2)
                                .animation(.easeInOut(duration: 1.0), value: viewModel.isDownloaded)
                            Text("Download")
                                .foregroundColor(.primary)
                                .opacity(viewModel.isDownloaded ? 0.0 : 1.0)
                                .animation(.easeInOut(duration: 1.0), value: viewModel.isDownloaded)
                        }
                    }
                }
                .padding()
                .disabled(viewModel.isDownloaded)
                .opacity(viewModel.isDownloaded ? 0.5 : 1.0)
            } else {
                ProgressView("Loading...")
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchAssetDetail()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: viewModel.signOut) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.primary)
                        Text("Sign Out")
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showDownloadSheet) {
            VStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                Text("Download Complete")
                    .font(.title2)
                    .foregroundColor(.green)
            }
            .padding()
        }
    }
}
