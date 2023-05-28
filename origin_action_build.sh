#!/bin/sh
source $GITHUB_WORKSPACE/action_util.sh
#开始构建
function app_build()
{
    debug "build with gradle"
    cd $APP_WORKSPACE
    cat gradle.properties
    chmod a+x gradlew   
    ./gradlew assembGoogleRelease --build-cache --parallel --daemon --warning-mode all
    
    APP_BUILD_APK=$(find $APP_WORKSPACE/*/build -regex .*/*/release/.*.apk)
    debug "build apk $APP_BUILD_APK"
    if [ -f $APP_BUILD_APK ]; then
        set_env APP_BUILD_APK $APP_BUILD_APK
        set_env APP_UPLOAD ${APP_BUILD_APK%/*}
        debug "upload apk dir ${APP_BUILD_APK%/*}"
    fi

}
