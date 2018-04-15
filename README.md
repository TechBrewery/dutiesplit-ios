# DutieSplit - iOS

## Tools & Services

* Tools:
* Xcode 9.3
* [Carthage](https://github.com/Carthage/Carthage) 0.26 or higher
* [CocoaPods](https://github.com/CocoaPods/CocoaPods) 1.2 or higher
* Services:
* [Trelo](https://trello.com/b/TWsynwg3/dutiesplit-ios)
* [Bitrise](https://www.bitrise.io/app/f4df44375524278a)
* [HockeyApp - staging](https://rink.hockeyapp.net/manage/apps/748112)
* [HockeyApp - Beta](https://rink.hockeyapp.net/manage/apps/748113)

## Configuration

### Prerequisites

- [Bundler](http://bundler.io) (`gem install bundler`)
- [Homebrew](https://brew.sh)
- [Carthage](https://github.com/Carthage/Carthage) (`brew install carthage`)
- [CocoaPods](https://cocoapods.org) (`brew install cocoapods`)

### Instalation

1. Clone repository:

```bash
# over https:
https://MichalTKwiecien@bitbucket.org/techbrewery/ios-dutiesplit.git
# or over SSH:
git@bitbucket.org:techbrewery/ios-dutiesplit.git
```

2. Install required Gems:

```bash
bundle install
```

3. Run Carthage:

```bash
carthage bootstrap --platform iOS --cache-builds
```

4. Download or create project `.env` file and paste it into the root project's directory.

5. Install pods through Bundler:

```bash
bundle exec pod install
```

6. Open `DutieSplit.xcworkspace` file and build the project.
