import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var userMetaData = wasteMetaData(garbage: 0, garbageGoal: 50, recycling: 0, recyclingGoal: 50, glass: 0, glassGoal: 10, organics: 0, organicsGoal: 20)
    @Published var recyclableP: Int = 0
    @Published var garbageP: Int = 0
    @Published var glassP: Int = 0
    @Published var organicsP: Int = 0
    
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?  // Firestore listener for real-time updates

    init() {
        listenForUserDataUpdates(username: globalUsername)
    }
    
    // Real-time Firestore syncing using addSnapshotListener
    func listenForUserDataUpdates(username: String) {
        listener = db.collection("users")
            .whereField("username", isEqualTo: username)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self, let snapshot = snapshot else {
                    print("Error fetching snapshot: \(String(describing: error))")
                    return
                }
                
                guard let document = snapshot.documents.first else {
                    print("No data found for this user.")
                    return
                }
                
                do {
                    if let data = try? document.data(as: wasteMetaData.self) {
                        DispatchQueue.main.async {
                            self.userMetaData = data
                            self.recyclableP = Int(round((Double(data.recycling) / Double(data.recyclingGoal)) * 100))
                            self.garbageP = Int(round((Double(data.garbage) / Double(data.garbageGoal)) * 100))
                            self.glassP = Int(round((Double(data.glass) / Double(data.glassGoal)) * 100))
                            self.organicsP = Int(round((Double(data.organics) / Double(data.organicsGoal)) * 100))
                        }
                    }
                }
            }
    }
    
    deinit {
        listener?.remove()  // Clean up Firestore listener
    }
}
