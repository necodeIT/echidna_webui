# Echidna WebUI

A fully functional software licensing server written in Dart. This is the frontend for the server. The server can be found [here](https://github.com/necodeIT/echidna_server).

# Development

Make sure you have the server running before you start the webui. You can find instructions on how to run the server [here](https://github.com/necodeIT/echidna_server?tab=readme-ov-file#debugging-the-server).

## Running the webui

1. Copy the `.env.example` file to `.env` and edit the file to your liking.

   ```bash
    cp .env.example .env
    ```

2. Use your favorite IDE to run the webui. You can also run the following command:

   ```bash
   flutter run -d chrome
   ```

# Deployment

> [!NOTE]
> Docker deployment is coming soon.

This project is supposed to be deployed together with the [echidna_server](https://github.com/necodeIT/echidna_server). The server is the backend for the webui.

# Client SDK

Currently there is only one official client SDK for the Echidna server. It is written for [Flutter Modular](https://pub.dev/packages/flutter_modular) and can be found [here](https://github.com/necodeIT/echidna_flutter).

## Writing your own client SDK

You can write your own client SDK for Echidna server. If you do, please consider opening a pull request linking to your repository so we can add it to the list of SDKs in the webui.

## Contributing a client SDK

If you want to contribute a client SDK, please follow the following steps:

1. Add the `echidna.json` file to the root of your repository. The file should look like this:

   ```json
   {
      "$schema": "https://raw.githubusercontent.com/necodeIT/echidna_webui/main/echidna.schema.json",
      "name": "Your SDK Name",
      "framework": "your-framework",
      "gettingStarted": {
         "en": "https://link-to-your-getting-started-guide"
      }
   }
   ```

   If your framework is not listed in the `echidna.schema.json` file, please open a pull request to add it.

2. In your *markdown* getting started guides make sure that each step is a level one heading. This is important for the webui to parse the guide correctly.
   1. The following variables are substituded:
      - `<domain>`: The domain of the Echidna server.
      - `<client-key>`: The client key for communicating with the Echidna server.
      - `<client-id>`: The client id on the Echidna server.
3. Open a pull request to add your SDK to the list of SDKs in the webui.

   The list can be found in [std_client_sdk_datasource.dart](lib/modules/products/infra/datasources/std_client_sdk_datasource.dart).
