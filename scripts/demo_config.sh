#!/bin/bash

# Customer Demo Configuration Script
# Usage: ./demo_config.sh [demo_number]
# Example: ./demo_config.sh 1

DEMO_NUMBER=$1

if [ -z "$DEMO_NUMBER" ]; then
    echo "Usage: ./demo_config.sh [demo_number]"
    echo "Available demos:"
    echo "  1 - News Feed Only"
    echo "  2 - Sign Up + News Feed"
    echo "  3 - Profile + Previous Features"
    echo "  4 - Settings + Previous Features"
    echo "  5 - Chat + Previous Features"
    exit 1
fi

APP_SETTINGS_FILE="lib/app_settings.dart"

case $DEMO_NUMBER in
    1)
        echo "Configuring Demo 1: News Feed Only"
        # Update app_settings.dart for demo 1
        sed -i 's/newsfeed.*true/newsfeed: true/' $APP_SETTINGS_FILE
        sed -i 's/signup.*true/signup: false/' $APP_SETTINGS_FILE
        sed -i 's/profile.*true/profile: false/' $APP_SETTINGS_FILE
        sed -i 's/settings.*true/settings: false/' $APP_SETTINGS_FILE
        sed -i 's/chat.*true/chat: false/' $APP_SETTINGS_FILE
        ;;
    2)
        echo "Configuring Demo 2: Sign Up + News Feed"
        sed -i 's/newsfeed.*false/newsfeed: true/' $APP_SETTINGS_FILE
        sed -i 's/signup.*false/signup: true/' $APP_SETTINGS_FILE
        sed -i 's/profile.*true/profile: false/' $APP_SETTINGS_FILE
        sed -i 's/settings.*true/settings: false/' $APP_SETTINGS_FILE
        sed -i 's/chat.*true/chat: false/' $APP_SETTINGS_FILE
        ;;
    3)
        echo "Configuring Demo 3: Profile + Previous Features"
        sed -i 's/newsfeed.*false/newsfeed: true/' $APP_SETTINGS_FILE
        sed -i 's/signup.*false/signup: true/' $APP_SETTINGS_FILE
        sed -i 's/profile.*false/profile: true/' $APP_SETTINGS_FILE
        sed -i 's/settings.*true/settings: false/' $APP_SETTINGS_FILE
        sed -i 's/chat.*true/chat: false/' $APP_SETTINGS_FILE
        ;;
    4)
        echo "Configuring Demo 4: Settings + Previous Features"
        sed -i 's/newsfeed.*false/newsfeed: true/' $APP_SETTINGS_FILE
        sed -i 's/signup.*false/signup: true/' $APP_SETTINGS_FILE
        sed -i 's/profile.*false/profile: true/' $APP_SETTINGS_FILE
        sed -i 's/settings.*false/settings: true/' $APP_SETTINGS_FILE
        sed -i 's/chat.*true/chat: false/' $APP_SETTINGS_FILE
        ;;
    5)
        echo "Configuring Demo 5: Chat + Previous Features"
        sed -i 's/newsfeed.*false/newsfeed: true/' $APP_SETTINGS_FILE
        sed -i 's/signup.*false/signup: true/' $APP_SETTINGS_FILE
        sed -i 's/profile.*false/profile: true/' $APP_SETTINGS_FILE
        sed -i 's/settings.*false/settings: true/' $APP_SETTINGS_FILE
        sed -i 's/chat.*false/chat: true/' $APP_SETTINGS_FILE
        ;;
    *)
        echo "Invalid demo number. Please use 1-5."
        exit 1
        ;;
esac

echo "Demo configuration updated successfully!"
echo "Run 'flutter build apk --release' to build the demo APK."
