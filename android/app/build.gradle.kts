import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use(keystoreProperties::load)
}

fun signingValue(propertyName: String, environmentName: String): String? =
    System.getenv(environmentName)?.takeIf(String::isNotBlank)
        ?: keystoreProperties.getProperty(propertyName)?.takeIf(String::isNotBlank)

fun signingSecret(
    propertyName: String,
    filePropertyName: String,
    environmentName: String,
): String? = signingValue(propertyName, environmentName)
    ?: keystoreProperties.getProperty(filePropertyName)
        ?.takeIf(String::isNotBlank)
        ?.let(rootProject::file)
        ?.takeIf { it.exists() }
        ?.readText()
        ?.trim()
        ?.takeIf(String::isNotBlank)

val releaseStorePath = signingValue("storeFile", "ANDROID_KEYSTORE_PATH")
val releaseKeyAlias = signingValue("keyAlias", "ANDROID_KEY_ALIAS")
val releaseStorePassword = signingSecret(
    "storePassword",
    "storePasswordFile",
    "ANDROID_STORE_PASSWORD",
)
val releaseKeyPassword = signingSecret(
    "keyPassword",
    "keyPasswordFile",
    "ANDROID_KEY_PASSWORD",
)
val hasReleaseSigning = listOf(
    releaseStorePath,
    releaseKeyAlias,
    releaseStorePassword,
    releaseKeyPassword,
).all { !it.isNullOrBlank() }

val releaseWasRequested = gradle.startParameter.taskNames.any {
    it.contains("release", ignoreCase = true)
}
if (releaseWasRequested && !hasReleaseSigning) {
    throw GradleException(
        "Release signing is not configured. Provide android/key.properties " +
            "or the ANDROID_KEYSTORE_PATH, ANDROID_KEY_ALIAS, " +
            "ANDROID_STORE_PASSWORD, and ANDROID_KEY_PASSWORD environment variables.",
    )
}

android {
    namespace = "com.irohasu.mconnect.chatbot"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.irohasu.mconnect.chatbot"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseSigning) {
            create("release") {
                storeFile = rootProject.file(requireNotNull(releaseStorePath))
                storePassword = requireNotNull(releaseStorePassword)
                keyAlias = requireNotNull(releaseKeyAlias)
                keyPassword = requireNotNull(releaseKeyPassword)
            }
        }
    }

    buildTypes {
        release {
            if (hasReleaseSigning) {
                signingConfig = signingConfigs.getByName("release")
            }
        }
    }
}

flutter {
    source = "../.."
}
