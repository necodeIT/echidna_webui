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
