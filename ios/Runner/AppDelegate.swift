// Copyright 2026 Thorsten Ludewig (t.ludewig@gmail.com)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import AVFoundation
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    guard let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "CameraZoomSteps") else {
      return
    }
    let channel = FlutterMethodChannel(
      name: "de.l9g.qr_viewer/camera", binaryMessenger: registrar.messenger())
    channel.setMethodCallHandler { call, result in
      if call.method == "zoomSteps" {
        result(CameraZoomSteps.back())
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
  }
}

/// Zoomstufen der Rückkameras, wie sie die Kamera-App anbietet.
///
/// Jeder Eintrag: lens (0 = Hauptkamera, 1 = Ultraweitwinkel, 2 = Tele, wie
/// mobile_scanner), factor (relativ zur Hauptkamera) und zoom (digitaler
/// Zoom auf diesem Objektiv, 1 = keiner).
enum CameraZoomSteps {
  static func back() -> [[String: Any]] {
    let lenses: [(AVCaptureDevice.DeviceType, Int)] = [
      (.builtInWideAngleCamera, 0), (.builtInUltraWideCamera, 1), (.builtInTelephotoCamera, 2),
    ]
    let physical = AVCaptureDevice.DiscoverySession(
      deviceTypes: lenses.map { $0.0 }, mediaType: .video, position: .back
    ).devices
    guard let main = physical.first(where: { $0.deviceType == .builtInWideAngleCamera }) else {
      return []
    }

    // Faktoren aus den Umschaltpunkten der virtuellen Mehrfachkamera:
    // Deren Zoom 1 ist das kleinste Objektiv, jeder Umschaltpunkt das nächste.
    var factors: [AVCaptureDevice.DeviceType: Double] = [.builtInWideAngleCamera: 1]
    let virtual = AVCaptureDevice.DiscoverySession(
      deviceTypes: [.builtInTripleCamera, .builtInDualWideCamera, .builtInDualCamera],
      mediaType: .video, position: .back
    ).devices.first
    if let virtual {
      let constituents = virtual.constituentDevices
      let zooms = [1.0] + virtual.virtualDeviceSwitchOverVideoZoomFactors.map { $0.doubleValue }
      if constituents.count == zooms.count,
        let mainIndex = constituents.firstIndex(where: { $0.deviceType == .builtInWideAngleCamera })
      {
        for (i, device) in constituents.enumerated() {
          factors[device.deviceType] = zooms[i] / zooms[mainIndex]
        }
      }
    }

    var steps = [[String: Any]]()
    for device in physical {
      guard let lens = lenses.first(where: { $0.0 == device.deviceType })?.1 else { continue }
      var step: [String: Any] = ["lens": lens, "zoom": 1.0]
      if let factor = factors[device.deviceType] { step["factor"] = factor }
      steps.append(step)
    }

    // Ausschnitt des hochauflösenden Hauptsensors, z. B. 2× bei 48 MP.
    if #available(iOS 16.0, *) {
      let tele = factors[.builtInTelephotoCamera] ?? .infinity
      let crops = Set(main.formats.flatMap { $0.secondaryNativeResolutionZoomFactors })
      for zoom in crops.sorted() where zoom > 1 && Double(zoom) < tele && zoom <= 5 {
        steps.append(["lens": 0, "factor": Double(zoom), "zoom": Double(zoom)])
      }
    }
    return steps
  }
}
