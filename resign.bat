set arg1=%1
echo Copying files from Jenkins archives
copy "\\jenkins_path\workspace\keystore\keystore_name.keystore" %cd%
echo Resign application with keystore
calabash-android resign app-release.apk keystore_name.keystore
