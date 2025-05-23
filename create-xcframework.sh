#!/bin/sh

if [ $# -ne 1 ]
then
	echo "Version is missing"
	exit
fi

ARCHIVE_DIRECTORY=build/archive
VERSION=$1

/usr/libexec/PlistBuddy Hamcrest/Info.plist -c "Set CFBundleShortVersionString $VERSION"


xcodebuild archive \
    -project Hamcrest.xcodeproj \
    -scheme Hamcrest-iOS \
    -destination "generic/platform=iOS" \
    -archivePath "$ARCHIVE_DIRECTORY/Hamcrest-iOS" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
    -project Hamcrest.xcodeproj \
    -scheme Hamcrest-iOS \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "$ARCHIVE_DIRECTORY/Hamcrest-iOS_Simulator" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
    -project Hamcrest.xcodeproj \
    -scheme Hamcrest-macOS \
    -destination "generic/platform=macOS" \
    -archivePath "$ARCHIVE_DIRECTORY/Hamcrest-macOS" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES


xcodebuild -create-xcframework \
    -archive $ARCHIVE_DIRECTORY/Hamcrest-iOS.xcarchive -framework Hamcrest.framework \
    -archive $ARCHIVE_DIRECTORY/Hamcrest-iOS_Simulator.xcarchive -framework Hamcrest.framework \
    -archive $ARCHIVE_DIRECTORY/Hamcrest-macOS.xcarchive -framework Hamcrest.framework \
    -output build/archive/Hamcrest.xcframework

cp LICENSE build/archive
cd build/archive

zip -r Hamcrest-$VERSION.xcframework.zip Hamcrest.xcframework LICENSE
