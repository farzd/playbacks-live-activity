import AppIntents
import WidgetKit

@available(iOS 16.2, *)
struct CompleteIntent: AppIntent, LiveActivityIntent {
    static var title: LocalizedStringResource = "Complete Recording"
    static var description: IntentDescription = "Opens the app to complete the recording"
    static var openAppWhenRun: Bool = true

    init() {}
    
    func perform() async throws -> some IntentResult {
        print("CompleteIntent perform() called")
        NotificationCenter.default.post(name: Notification.Name("completeActivityFromWidget"), object: nil)
        print("Notification posted: completeActivityFromWidget")
        return .result()
    }
}