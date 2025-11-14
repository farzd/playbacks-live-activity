//
//  LiveActivityView.swift
//  ExpoLiveActivity
//
//  Created by Anna Olak on 03/06/2025.
//

import SwiftUI
import WidgetKit

#if canImport(ActivityKit)

struct LiveActivityView: View {
  let contentState: LiveActivityAttributes.ContentState
  let attributes: LiveActivityAttributes
  

  var body: some View {
VStack(alignment: .leading, spacing: 1) {
    HStack(alignment: .top, spacing: 12) {
      // Column 1: Logo
      if let imageName = contentState.imageName {  
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
        Text(contentState.title)
          .font(.system(size: 20))
          .foregroundStyle(Color(hex: attributes.titleColor!))
          .fontWeight(.semibold)
        
        if let date = contentState.date {
          let totalPaused = contentState.totalPausedDuration ?? 0
          let adjustedStartDate = date.addingTimeInterval(totalPaused)
          // Keep the timeline running until the activity explicitly pauses or stops
          let endDate = Date.distantFuture
          Text(timerInterval: adjustedStartDate...endDate, pauseTime: contentState.pausedAt, countsDown: false)
            .font(.system(size: 18, design: .monospaced))
            .foregroundStyle(Color(hex: attributes.titleColor!))
            .fontWeight(.semibold)
        }
           Spacer()
      }
      
      Spacer()
      
      // Column 3: Subtitle
      VStack(alignment: .trailing, spacing: 2) {
          Spacer()
        if let subtitle = contentState.subtitle {
            Link(destination: URL(string: "playbacks://?liveactivity=save")!) {
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
    if let limitText = contentState.limitText {
      Text(limitText)
        .font(.system(size: 14))
        .foregroundStyle(Color(hex: "757575"))
        .padding(.leading, 50)
    }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 8)
  }
}

#endif
