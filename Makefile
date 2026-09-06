SHELL := /bin/bash

.PHONY: format build generate gen_i18n find_unused_files find_unused_code flavor_generate gen_app_icon fix_appicon_name

format:
	fvm dart format lib

build:
	fvm flutter build apk --release --flavor dev --target lib/main_dev.dart

generate:
	fvm flutter pub run build_runner build --delete-conflicting-outputs

gen_i18n:
	fvm dart run intl_utils:generate

find_unused_files:
	fvm flutter pub run dart_code_metrics:metrics check-unused-files lib

find_unused_code:
	fvm flutter pub run dart_code_metrics:metrics check-unused-code lib

flavor_generate:
	fvm flutter pub run flutter_flavorizr

gen_app_icon:
	fvm flutter pub run flutter_launcher_icons

fix_appicon_name:
	@echo "Changing \$$(ASSET_PREFIX)AppIcon to AppIcon-\$$(ASSET_PREFIX)..."
	sed -i '' 's/ASSETCATALOG_COMPILER_APPICON_NAME = "\$$(ASSET_PREFIX)AppIcon"/ASSETCATALOG_COMPILER_APPICON_NAME = "AppIcon-\$$(ASSET_PREFIX)"/g' ios/Runner.xcodeproj/project.pbxproj
	@echo "AppIcon names updated successfully."
