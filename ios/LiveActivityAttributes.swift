//
//  LiveActivityAttributes.swift
//  ExpoLiveActivity
//
//  Created by Anna Olak on 03/06/2025.
//

import Foundation
import ActivityKit

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
