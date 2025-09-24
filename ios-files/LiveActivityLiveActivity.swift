//
//  LiveActivityLiveActivity.swift
//  LiveActivity
//
//  Created by Anna Olak on 02/06/2025.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct LiveActivityAttributes: ActivityAttributes {
  public struct ContentState: Codable, Hashable {
    var title: String
    var subtitle: String?
    var date: Date?
    var imageName: String?
    var dynamicIslandImageName: String?
    var pausedAt: Date?
    var totalPausedDuration: TimeInterval?
    var limitText: String?
  }

  var name: String
  var backgroundColor: String?
  var titleColor: String?
  var subtitleColor: String?
}

struct LiveActivityLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: LiveActivityAttributes.self) { context in
      LiveActivityView(contentState: context.state, attributes: context.attributes)
        .activityBackgroundTint(context.attributes.backgroundColor != nil ? Color(hex: context.attributes.backgroundColor!) : nil)
        .activitySystemActionForegroundColor(Color.black)

    } dynamicIsland: { context in
      DynamicIsland {
        DynamicIslandExpandedRegion(.center) {
          VStack(alignment: .leading, spacing: 1) {
            HStack(alignment: .top, spacing: 12) {
            // Column 1: Logo
            if let imageName = context.state.imageName {  
              VStack {
                Spacer()
                Image(imageName)
                  .resizable()
                  .scaledToFit()
                  .frame(maxHeight: 40)
                  .padding(.trailing, 4)
                Spacer()
              }
            }
            
            // Column 2: Title and Timer
            VStack(alignment: .leading, spacing: 2) {
              Spacer()
              Text(context.state.title)
                .font(.system(size: 20))
                .foregroundStyle(.white)
                .fontWeight(.semibold)
              
              if let date = context.state.date {
                let totalPaused = context.state.totalPausedDuration ?? 0
                let adjustedStartDate = date.addingTimeInterval(totalPaused)
                // Keep the timeline running until the activity explicitly pauses or stops
                let endDate = Date.distantFuture
                Text(timerInterval: adjustedStartDate...endDate, pauseTime: context.state.pausedAt, countsDown: false)
                  .font(.system(size: 18, design: .monospaced))
                  .fontWeight(.semibold)
                  .foregroundStyle(.white)
              }
              Spacer()
            }
            
            Spacer()
            
      // Column 3: Subtitle
      VStack(alignment: .trailing, spacing: 2) {
          Spacer()
        if let subtitle = context.state.subtitle {
            Link(destination: URL(string: "playbacks://")!) {
              Text(subtitle)
                 .font(.system(size: 16))
                 .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color(hex: "fe5b25"))
                .cornerRadius(8)
            }
            .buttonStyle(.plain)
        }
          Spacer()
      }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            if let limitText = context.state.limitText {
              Text(limitText)
                .font(.system(size: 14))
                .foregroundStyle(Color(hex: "757575"))
                .padding(.leading, 50)
            }
          }
        }
      } compactLeading: {
        if let dynamicIslandImageName = context.state.dynamicIslandImageName {
          resizableImage(imageName: dynamicIslandImageName)
            .frame(maxWidth: 23, maxHeight: 23)
        }
      } compactTrailing: {
        if let date = context.state.date {
          compactTimer(endDate: date, pausedAt: context.state.pausedAt, totalPausedDuration: context.state.totalPausedDuration)
        }
      } minimal: {
        if let date = context.state.date {
          compactTimer(endDate: date, pausedAt: context.state.pausedAt, totalPausedDuration: context.state.totalPausedDuration)
        }
      }
    }
  }
  
  @ViewBuilder
  private func compactTimer(endDate: Date, pausedAt: Date?, totalPausedDuration: TimeInterval?) -> some View {
    let totalPaused = totalPausedDuration ?? 0
    let adjustedStartDate = endDate.addingTimeInterval(totalPaused)
    // Keep the compact timer ticking until the activity is paused or stopped
    let timelineEndDate = Date.distantFuture
    Text(timerInterval: adjustedStartDate...timelineEndDate, pauseTime: pausedAt, countsDown: false)
      .font(.system(size: 15, design: .monospaced))
      .minimumScaleFactor(0.8)
      .fontWeight(.semibold)
      .frame(maxWidth: 60)
      .multilineTextAlignment(.trailing)
  }

  private func dynamicIslandExpandedLeading(title: String, subtitle: String?) -> some View {
    VStack(alignment: .leading) {
      Spacer()
      Text(title)
        .font(.title2)
        .foregroundStyle(.white)
        .fontWeight(.semibold)
      if let subtitle {
        Text(subtitle)
          .font(.title3)
          .minimumScaleFactor(0.8)
          .foregroundStyle(.white.opacity(0.75))
      }
      Spacer()
    }
  }
  
  private func dynamicIslandExpandedTrailing(imageName: String) -> some View {
    VStack {
      Spacer()
      resizableImage(imageName: imageName)
        .frame(maxHeight: 64)
      Spacer()
    }
  }
  
  private func dynamicIslandExpandedBottom(endDate: Date) -> some View {
    ProgressView(timerInterval: Date.now...max(Date.now, endDate))
      .foregroundStyle(.white)
      .padding(.top, 5)
  }
  
  private func circularTimer(endDate: Date) -> some View {
    ProgressView(
      timerInterval: Date.now...max(Date.now, endDate),
      countsDown: false,
      label: { EmptyView() },
      currentValueLabel: {
        EmptyView()
      }
    )
    .progressViewStyle(.circular)
  }
  private func resizableImage(imageName: String) -> some View {
    Image(imageName)
      .resizable()
      .scaledToFit()
  }
}
