# Makefile for Flutter project

# Default target
all: help

# Show the help message
help:
	@echo "Makefile for Flutter project"
	@echo "Available targets:"
	@echo "  build         Build the Flutter project"
	@echo "  run           Run the app on a connected device"
	@echo "  test          Run the tests"
	@echo "  clean         Clean the build files"
	@echo "  pub_get       Fetch the dependencies"

# Build the Flutter project
build:
	flutter build apk

# Run the app on a connected device
run:
	flutter run

# Run tests
test:
	flutter test

# Clean the build files
clean:
	flutter clean

# Fetch dependencies
pub_get:
	flutter pub get
