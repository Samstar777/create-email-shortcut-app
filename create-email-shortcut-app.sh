#!/bin/bash

####################################################################################################
#
# Script to create an email shortcut application at desktop with custom image icon
# Creator : Salim Ukani aka Samstar777
# Date	  : 12th June 2023
#
####################################################################################################
#
# HISTORY
#
#   Version 1.0.0, 12-June-2023, Salim Ukani (@samstar777)
#   - Script to create an email shortcut application at desktop with custom image icon
#       - Required 
#          - `email`
#		   - `imagepath`
#    
# 
####################################################################################################


# Get the currently logged-in user
loggedInUser=$(ls -l /dev/console | awk '{ print $3 }')

# Set the user's email address
email="test@xxx.com" # Replace with the email ID receipt

# Set the image file path
imagePath="/path/to/image" # Replace with the actual path to your image file

# Create an empty directory for the application bundle
appDir="/Users/$loggedInUser/Desktop/Newemailicon.app" # path where you need the app
mkdir -p "$appDir/Contents/MacOS"
mkdir -p "$appDir/Contents/Resources"

# Create the Info.plist file
cat > "$appDir/Contents/Info.plist" << EOL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleExecutable</key>
	<string>Newemailicon</string>
	<key>CFBundleIconFile</key>
	<string>AppIcon</string>
</dict>
</plist>
EOL

# Copy the image file as the icon
cp "$imagePath" "$appDir/Contents/Resources/AppIcon.icns"

# Create the main executable script
cat > "$appDir/Contents/MacOS/Newemailicon" << EOL
#!/bin/bash

open "mailto:$email?subject=Test"
EOL

# Set execute permissions for the executable script
chmod +x "$appDir/Contents/MacOS/Newemailicon"

# Set permissions for the application bundle
chmod -R +x "$appDir"
chown -R $loggedInUser:staff "$appDir"
