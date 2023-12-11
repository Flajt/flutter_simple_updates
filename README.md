A simple way to display notifications to users in your app from 3rd party services like mastodon etc.

## Features

- A simple yet highly customizable notification button
- A dialog to render your latest notifications
- Caching is implemented by default
- Easily write your own parsers to fetch data from everywhere you want

## Getting started

Run: `flutter pub add flutter_simple_updates`

- Search for your 3rd party parser (currently Mastodon is the only supported one by me)
- If not yet existing build your own

## Usage

- Add the `ǸotificationWidget` anywhere you like and you are ready to go.
- Below I'm using the `!` to filter out messages that should reach the app. So every message starting with `!` will be displayed if the user presses the button.
- Add your desired cache to the NotificationWidget and optionaly change it's parameters (e.g. storage path, max items etc.)

```dart
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final SimpleMastodonParser parser =
      SimpleMastodonParser("!", "https://mastodon.world/<your-tag-here>");// Not included in this package!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NotificationWidget(
          cache: HiveCacheWrapper(), // Included Cache
          feedProvider: parser,
        ),
      ),
    );
  }
}

```
## Parsers
- [simple_mastodon_parser](https://pub.dev/packages/simple_mastodon_parser)


## Additional information

If you want to create a new parser, simply extend `ÀFeedParsingService` and pass it to the NotificationWidget and you are good to go.<br>
Desire a custom cache? Same thing applies, just implement the `ICacheWrapper` and you are ready.
<br>

Your data is not markdown? Don't worry, just build your own adapter by implementing the `ÌConverter` interface and pass it to the `NotificationWidget`, just make sure it afterwards returns markdown data.
<br>

If you are writing a package for a provider, consider letting me know so I can link it here for others to find and use.
<br>

The trigger character, sentence (or whatever) needs to be the **first** thing in your post!
