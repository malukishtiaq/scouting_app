package com.wowonder.combined

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "shared_content_handler"
    private val DEEP_LINK_CHANNEL = "deep_link_handler"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Shared content handler
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getSharedContent" -> {
                    val sharedContent = getSharedContentFromIntent()
                    result.success(sharedContent)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        
        // Deep link handler
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DEEP_LINK_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getInitialLink" -> {
                    val initialLink = getInitialLink()
                    result.success(initialLink)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        println("🔗 MainActivity: onCreate() called")
        handleSharedContent()
        handleDeepLink(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        println("🔗 MainActivity: onNewIntent() called with intent: ${intent.data}")
        setIntent(intent)
        handleSharedContent()
        handleDeepLink(intent)
    }

    private fun handleSharedContent() {
        val intent = intent
        val action = intent.action
        val type = intent.type

        if (Intent.ACTION_SEND == action && type != null) {
            if (type.startsWith("video/") || type.startsWith("image/")) {
                val sharedContent = getSharedContentFromIntent()
                if (sharedContent != null) {
                    // Send to Flutter
                    flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
                        MethodChannel(messenger, CHANNEL)
                            .invokeMethod("onSharedContent", sharedContent)
                    }
                }
            }
        } else if (Intent.ACTION_SEND_MULTIPLE == action && type != null) {
            if (type.startsWith("video/") || type.startsWith("image/")) {
                val sharedContent = getSharedContentFromIntent()
                if (sharedContent != null) {
                    // Send to Flutter
                    flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
                        MethodChannel(messenger, CHANNEL)
                            .invokeMethod("onSharedContent", sharedContent)
                    }
                }
            }
        }
    }

    private fun getSharedContentFromIntent(): Map<String, Any>? {
        val intent = intent
        val action = intent.action
        val type = intent.type

        return when {
            Intent.ACTION_SEND == action && type != null -> {
                val uri = intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)
                if (uri != null) {
                    val filePath = getRealPathFromURI(uri)
                    if (filePath != null) {
                        mapOf(
                            "content" to filePath,
                            "type" to type
                        )
                    } else null
                } else null
            }
            Intent.ACTION_SEND_MULTIPLE == action && type != null -> {
                val uris = intent.getParcelableArrayListExtra<Uri>(Intent.EXTRA_STREAM)
                if (uris != null && uris.isNotEmpty()) {
                    val filePaths = uris.mapNotNull { getRealPathFromURI(it) }
                    if (filePaths.isNotEmpty()) {
                        mapOf(
                            "content" to filePaths.first(),
                            "type" to type,
                            "multiple" to true,
                            "count" to filePaths.size
                        )
                    } else null
                } else null
            }
            else -> null
        }
    }

    private fun getRealPathFromURI(uri: Uri): String? {
        return try {
            val cursor = contentResolver.query(uri, null, null, null, null)
            cursor?.use {
                if (it.moveToFirst()) {
                    val columnIndex = it.getColumnIndex(android.provider.MediaStore.Images.Media.DATA)
                    if (columnIndex >= 0) {
                        it.getString(columnIndex)
                    } else null
                } else null
            }
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }
    
    private fun getInitialLink(): String? {
        val data = intent.data?.toString()
        println("🔗 MainActivity: getInitialLink() = $data")
        return data
    }
    
    private fun handleDeepLink(intent: Intent) {
        val data = intent.data
        println("🔗 MainActivity: handleDeepLink() - data = $data")
        if (data != null) {
            val url = data.toString()
            println("🔗 MainActivity: Sending deep link to Flutter: $url")
            flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
                MethodChannel(messenger, DEEP_LINK_CHANNEL)
                    .invokeMethod("onDeepLink", url)
            }
        }
    }
}

