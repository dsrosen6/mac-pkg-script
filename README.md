### Mac Package Script
Script I use to create, sign, and notarize Mac `.pkg` files - because the terminal commands are hard to remember.

#### Usage
- fill your info in for the `version`, `pkg_name`, and `identifier` variables.
- make sure the following environmental variables are set with your Apple Developer info:
    - `APPLE_DEV_INSTALLER_CERT` (this should start with "Developer ID Installer:")
    - `APPLE_DEV_APPLE_ID`
    - `APPLE_DEV_TEAM_ID`
    - `APPLE_DEV_APP_PASSWORD`

Then, just `chmod +x` your script and run it in the directory your `Payload` and `Scripts` directory are in.