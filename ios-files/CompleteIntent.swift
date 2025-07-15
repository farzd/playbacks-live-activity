import AppIntents
import WidgetKit

@available(iOS 16.2, *)
struct CompleteIntent: AppIntent, LiveActivityIntent {
    static var title: LocalizedStringResource = "Complete Recording"
    static var description: IntentDescription = "Opens the app to complete the recording"
    static var openAppWhenRun: Bool = true
    
    @Parameter(title: "Activity ID")
    var activityId: String?

    init() {}
    
    init(activityId: String?) {
        self.activityId = activityId
    }
    
    func perform() async throws -> some IntentResult {
        print("CompleteIntent perform() called")
        
        // Send notification to the main app
        NotificationCenter.default.post(name: NSNotification.Name("CompleteIntentTriggered"), object: nil)
        
        print("Notification sent")
        return .result()
    }
}