import ExpoLiveActivityModule from "./ExpoLiveActivityModule";
import { Platform } from "react-native";

const isMacCatalyst =
  Platform.OS === "ios" && (Platform as any)?.constants?.interfaceIdiom === "mac";

function assertSupported() {
  if (Platform.OS !== "ios" || isMacCatalyst) {
    throw new Error("Live Activities are not supported on this platform");
  }
}


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
  assertSupported();
  if (!ExpoLiveActivityModule?.startActivity) {
    throw new Error("Live Activities module not available on this device");
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
  assertSupported();
  if (!ExpoLiveActivityModule?.stopActivity) {
    throw new Error("Live Activities module not available on this device");
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
  assertSupported();
  if (!ExpoLiveActivityModule?.updateActivity) {
    throw new Error("Live Activities module not available on this device");
  }
  return ExpoLiveActivityModule.updateActivity(id, state);
}

/**
 * @param {string} eventName The name of the event to listen to.
 * @param {Function} listener The function to call when the event is triggered.
 * @returns {object} A subscription object with a remove method.
 * @throws {Error} When function is called on platform different than iOS.
 */
export function addListener(eventName: string, listener: (...args: any[]) => void) {
  assertSupported();
  if (!ExpoLiveActivityModule?.addListener) {
    throw new Error("Live Activities module not available on this device");
  }
  return ExpoLiveActivityModule.addListener(eventName, listener);
}
