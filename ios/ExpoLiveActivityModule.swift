import ActivityKit
import ExpoModulesCore

enum ModuleErrors: Error {
    case unsupported
    case liveActivitiesNotEnabled
}

public class ExpoLiveActivityModule: Module {
    struct LiveActivityState: Record {
        @Field
        var title: String

        @Field
        var subtitle: String

        // @Field
        // var date: Date
    }
    
    public func definition() -> ModuleDefinition {
        Name("ExpoLiveActivity")

        Function("hello") { () -> String in
            return "Hello world! 👋"
        }

        Function("startActivity") { (state: LiveActivityState) -> String in
            print("Starting activity")
            if #available(iOS 16.2, *) {
                if ActivityAuthorizationInfo().areActivitiesEnabled {
                    do {
                        let counterState = LiveActivityAttributes(name: "Counter")
                        let initialState = LiveActivityAttributes.ContentState(
                            emoji: "🤩", title: state.title, subtitle: state.subtitle,
                            date: .now)
                        let activity = try Activity.request(
                            attributes: counterState,
                            content: .init(state: initialState, staleDate: nil), pushType: nil)
                        return activity.id
                    } catch (let error) {
                        print("Error with live activity: \(error)")
                    }
                }
                throw ModuleErrors.liveActivitiesNotEnabled
            } else {
                // Fallback on earlier versions
                throw ModuleErrors.unsupported
            }
            //          return ""
        }
    }
}
