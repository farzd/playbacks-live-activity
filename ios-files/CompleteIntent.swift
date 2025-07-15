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
        
        // Call the static method directly in the module
        ExpoLiveActivityModule.handleCompleteIntent()
        
        print("Static method called")
        return .result()
    }
}