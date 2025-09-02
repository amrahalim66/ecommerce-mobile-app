plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // Firebase
}

android {
    namespace = "com.example.to_do_app"
    compileSdk = 35 // ✅ Updated from 34 to 35

    defaultConfig {
        applicationId = "com.example.to_do_app"
        minSdk = 23 // ✅ Updated from 21 to 23 to fix Firebase Auth compatibility
        targetSdk = 35 
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BOM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:32.7.2"))

    // Firebase Authentication
    implementation("com.google.firebase:firebase-auth-ktx")
}
