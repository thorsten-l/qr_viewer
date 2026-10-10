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

package de.l9g.qr_viewer

import android.hardware.camera2.CameraCharacteristics
import android.os.Build
import android.hardware.camera2.CameraManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.math.hypot

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "de.l9g.qr_viewer/camera")
            .setMethodCallHandler { call, result ->
                if (call.method == "zoomSteps") {
                    try {
                        result.success(backZoomSteps())
                    } catch (e: Exception) {
                        result.success(emptyList<Map<String, Any>>())
                    }
                } else {
                    result.notImplemented()
                }
            }
    }

    /**
     * Zoomstufen der Rückkameras: lens (0 = Hauptkamera, 1 = Ultraweitwinkel,
     * 2 = Tele, wie mobile_scanner), factor (relativ zur Hauptkamera) und zoom
     * (Zoomverhältnis auf diesem Objektiv, 1 = keins). Eingeteilt wird wie in
     * mobile_scanner über die Kleinbild-Brennweite: < 20 mm, 20–35 mm, > 35 mm.
     *
     * Viele Geräte (z. B. Pixel) melden nur eine logische Rückkamera, die
     * über das Zoomverhältnis selbst auf Ultraweitwinkel oder Tele umschaltet.
     * Deren Stufen kommen aus den physischen Kameras und dem Zoombereich.
     */
    private fun backZoomSteps(): List<Map<String, Any>> {
        val manager = getSystemService(CAMERA_SERVICE) as CameraManager
        val backIds = manager.cameraIdList.filter {
            manager.getCameraCharacteristics(it).get(CameraCharacteristics.LENS_FACING) ==
                CameraCharacteristics.LENS_FACING_BACK
        }
        val focal35 = linkedMapOf<Int, Float>()
        for (id in backIds) {
            val equivalent = focal35(manager.getCameraCharacteristics(id)) ?: continue
            focal35.putIfAbsent(lensType(equivalent), equivalent)
        }
        val main = focal35[0] ?: return emptyList()
        val steps = focal35.map { (lens, equivalent) ->
            mapOf<String, Any>("lens" to lens, "factor" to (equivalent / main).toDouble(), "zoom" to 1.0)
        }.toMutableList()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            val mainId = backIds.first { focal35(manager.getCameraCharacteristics(it))?.let(::lensType) == 0 }
            val chars = manager.getCameraCharacteristics(mainId)
            val range = chars.get(CameraCharacteristics.CONTROL_ZOOM_RATIO_RANGE)
            if (range != null) {
                val physical = chars.physicalCameraIds.mapNotNull {
                    focal35(manager.getCameraCharacteristics(it))
                }
                if (range.lower < 0.95f && physical.any { lensType(it) == 1 }) {
                    steps.add(mapOf("lens" to 0, "factor" to range.lower.toDouble(), "zoom" to range.lower.toDouble()))
                }
                for (equivalent in physical.filter { lensType(it) == 2 }) {
                    val factor = equivalent / main
                    if (factor <= range.upper) {
                        steps.add(mapOf("lens" to 0, "factor" to factor.toDouble(), "zoom" to factor.toDouble()))
                    }
                }
                // Digitales 2× wie in der Kamera-App, sofern kein Tele darunter liegt.
                val tele = steps.filter { it["lens"] == 2 || (it["factor"] as Double) > 1.5 }
                if (range.upper >= 2f && tele.none { (it["factor"] as Double) < 2.5 }) {
                    steps.add(mapOf("lens" to 0, "factor" to 2.0, "zoom" to 2.0))
                }
            }
        }
        return steps
    }

    private fun focal35(c: CameraCharacteristics): Float? {
        val focal = c.get(CameraCharacteristics.LENS_INFO_AVAILABLE_FOCAL_LENGTHS)?.firstOrNull() ?: return null
        val size = c.get(CameraCharacteristics.SENSOR_INFO_PHYSICAL_SIZE) ?: return null
        val diagonal = hypot(size.width, size.height)
        return if (diagonal > 0f) focal * 43.27f / diagonal else null
    }

    private fun lensType(equivalent: Float): Int = when {
        equivalent < 20f -> 1
        equivalent <= 35f -> 0
        else -> 2
    }
}
