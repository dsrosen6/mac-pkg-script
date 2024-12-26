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

#### Quick Download to Current Directory
You can run the following to quickly download this script into your current directory for use in your projects. I have it set as an alias in my `.zshrc`:

```
curl -O https://raw.githubusercontent.com/dsrosen6/mac-pkg-script/refs/heads/main/create_package.sh && chmod +x create_package.sh
```