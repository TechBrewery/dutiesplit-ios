# DutieSplit - iOS

## Tools & Services

### Tools:
* Xcode 10.1
* [Carthage](https://github.com/Carthage/Carthage) 0.31 or higher
* [CocoaPods](https://github.com/CocoaPods/CocoaPods) 1.3 or higher

### Services:
* [Trello](https://trello.com/b/TWsynwg3/dutiesplit-ios)
* [Bitrise](https://www.bitrise.io/app/d628af113970023d)
* [HockeyApp - Staging](https://rink.hockeyapp.net/manage/apps/748112)
* [HockeyApp - Beta](https://rink.hockeyapp.net/manage/apps/748113)

## Configuration

### Prerequisites

- [Bundler](http://bundler.io) (`gem install bundler`)
- [Homebrew](https://brew.sh)
- [Carthage](https://github.com/Carthage/Carthage) (`brew install carthage`)
- [CocoaPods](https://cocoapods.org) (`brew install cocoapods`)

### Instalation

1. Clone repository:

2. Install required Gems:

```bash
bundle install
```

3. Run Carthage:

```bash
carthage bootstrap --platform iOS --cache-builds
```

4. Download or create  `.env` file and paste it into the root project's directory.

5. Install pods through Bundler:

```bash
bundle exec pod install
```

6. Open `DutieSplit.xcodeproj` file and build the project.
