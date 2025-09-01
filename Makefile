.PHONY: help build clean get test run build-runner watch

# Default target
help:
	@echo "Available commands:"
	@echo "  make build      - Build the Flutter app"
	@echo "  make clean      - Clean build artifacts"
	@echo "  make get        - Get Flutter dependencies"
	@echo "  make test       - Run Flutter tests"
	@echo "  make run        - Run the Flutter app"
	@echo "  make build-runner - Run build_runner to generate code"
	@echo "  make watch      - Watch for changes and run build_runner automatically"

# Build the Flutter app
build:
	flutter build

# Clean build artifacts
clean:
	flutter clean

# Get Flutter dependencies
get:
	flutter pub get

# Run Flutter tests
test:
	flutter test

# Run the Flutter app
run:
	flutter run

# Run build_runner to generate code
gen:
	flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes and run build_runner automatically
watch:
	flutter pub run build_runner watch --delete-conflicting-outputs

# Full setup: get dependencies and generate code
setup: get build-runner

# Clean and rebuild everything
rebuild: clean get build-runner

# Generate app icons
icons:
	flutter pub run flutter_launcher_icons:main

# Setup with icons
setup-with-icons: get gen icons

# Setup with all dependencies
setup-all: get gen icons
