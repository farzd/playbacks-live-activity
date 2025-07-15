import ExpoLiveActivityModule from "./ExpoLiveActivityModule";
import { Platform } from "react-native";


export type LiveActivityState = {
  title: string;
  subtitle?: string;
  date?: number;
  imageName?: string;
  dynamicIslandImageName?: string;
  pausedAt?: number;
  totalPausedDuration?: number;
  limitText?: string;
};

export type LiveActivityStyles = {
  backgroundColor?: string;
  titleColor?: string;
  subtitleColor?: string;
};

/**
 * @param {LiveActivityState} state The state for the live activity.
 * @returns {string} The identifier of the started activity.
 * @throws {Error} When function is called on platform different than iOS.
 */
export function startActivity(state: LiveActivityState, styles?: LiveActivityStyles): string {
  if (Platform.OS !== "ios") {
    throw new Error("startActivity is only available on iOS");
  }
  return ExpoLiveActivityModule.startActivity(state, styles);
}

/**
 * @param {string} id The identifier of the activity to stop.
 * @param {LiveActivityState} state The updated state for the live activity.
 * @returns {string} The identifier of the stopped activity.
 * @throws {Error} When function is called on platform different than iOS.
 */
export function stopActivity(id: string, state: LiveActivityState): string {
  if (Platform.OS !== "ios") {
    throw new Error("stopActivity is only available on iOS");
  }
  return ExpoLiveActivityModule.stopActivity(id, state);
}

/**
 * @param {string} id The identifier of the activity to update.
 * @param {LiveActivityState} state The updated state for the live activity.
 * @returns {string} The identifier of the updated activity.
 * @throws {Error} When function is called on platform different than iOS.
 */
export function updateActivity(id: string, state: LiveActivityState): string {
  if (Platform.OS !== "ios") {
    throw new Error("updateActivity is only available on iOS");
  }
  return ExpoLiveActivityModule.updateActivity(id, state);
}
