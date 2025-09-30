import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("development") {
            dimension = "flavor-type"
            applicationId = "com.kidboi666.moodlog.development"
            resValue(type = "string", name = "app_name", value = "무드로그 Dev")
        }
        create("staging") {
            dimension = "flavor-type"
            applicationId = "com.kidboi666.moodlog.staging"
            resValue(type = "string", name = "app_name", value = "무드로그 Staging")
        }
        create("production") {
            dimension = "flavor-type"
            applicationId = "com.kidboi666.moodlog"
            resValue(type = "string", name = "app_name", value = "무드로그")
        }
    }
}