import SwiftUI

struct LeaderboardView: View {
    @StateObject var viewModel = LeaderboardViewModel()
    @AppStorage("username") var username: String?
    
    @State var showTerms = true
    @State private var isRefreshing = false
    
    var body: some View {
        List {
            Text("Leaderboard")
                .font(.largeTitle)
                .bold()
            HStack {
                Text("Name")
                    .bold()
                Spacer()
                Text("Score")
                    .bold()
            }
            .padding()

            ForEach(Array(viewModel.leaderResult.top10.enumerated()), id: \.element.id) { (idx, person) in
                HStack {
                    Text("\(idx + 1). ")
                    Text(person.username)
                    Spacer()
                    Text("\(person.count)")
                }
                .padding(.horizontal)
            }
            Image(systemName: "ellipsis")
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundColor(.gray.opacity(0.5))

            if let user = viewModel.leaderResult.user {
                HStack {
                    Text(user.username)
                    Spacer()
                    Text("\(user.count)")
                }
                .padding(.horizontal)
            }
        }
        .refreshable {
            Task {
                await refreshLeaderboard()
            }
        }
        .fullScreenCover(isPresented: $showTerms) {
            TermsOfLeaderboard()
        }
    }

    func refreshLeaderboard() async {
        await MainActor.run {
            isRefreshing = true
        }
        do {
            let result = try await viewModel.fetchLeaderboards()
            await MainActor.run {
                viewModel.leaderResult = result
                isRefreshing = false
            }
        } catch {
            await MainActor.run {
                print("Failed to refresh leaderboard: \(error.localizedDescription)")
                isRefreshing = false
            }
        }
    }
}

#Preview {
    LeaderboardView()
}
