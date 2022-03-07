package ax.synt.giraffe_spotter

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream
import java.io.IOException
import androidx.exifinterface.media.ExifInterface


class MainActivity: FlutterActivity() {
    private val channel = "ax.synt.giraffe_spotter/coordinates"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            when (call.method) {
                "getCoordsFilePath" -> getCoords(result, call.argument("path"))
                else -> result.notImplemented()
            }
        }
    }

    private fun getCoords(result: MethodChannel.Result, path: String?) {
        var inputStream: FileInputStream? = null
        var latLng: DoubleArray? = doubleArrayOf(0.0, 0.0)
        if (path == null || path.isEmpty()) {
            result.success(latLng)
//            return
        }

        try {
            inputStream = FileInputStream(File(path))
            val exifInterface = ExifInterface(inputStream)
            latLng = exifInterface.latLong
            inputStream.close()
            Log.d("Giraffe Spotter","Lat long picked: $latLng")

//            if(latLng) {
//                result.success()
//                listOf(latLng[0], latLng[1])
//            } else {
//                listOf(1.0f, 1.0f)
//            }
        } catch (e: IOException) {
            throw e
        } finally {
            if (inputStream != null) {
                try {
                    inputStream.close()
                } catch (ignored: IOException) {
                }
            }
        }
    }
}
