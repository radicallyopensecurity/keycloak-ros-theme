# keycloak-ros-theme

[Radically Open Security](https://radicallyopensecurity.com) flavored [Keycloak](https://keycloak.org) theme.

![ROS Themed Keycloak Login Page](https://private-user-images.githubusercontent.com/115169506/450628211-18218976-c439-47ab-9f97-cd2b192c76fe.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDk2MzUxOTQsIm5iZiI6MTc0OTYzNDg5NCwicGF0aCI6Ii8xMTUxNjk1MDYvNDUwNjI4MjExLTE4MjE4OTc2LWM0MzktNDdhYi05Zjk3LWNkMmIxOTJjNzZmZS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNjExJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDYxMVQwOTQxMzRaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT00Y2IwYmFhYTA1MGIzZGNiMDY3NGFiZTEzY2M0ZmU1NzEwYWViZDA3ZWQ4OTY4MTgwZmFkZmNkNzFiYjJmOTM4JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.xnCWyVKWUn_rvrxPPbtV5V5VbJ91lY78yH-9WgDRHfo)

See [the wiki](https://github.com/radicallyopensecurity/keycloak-ros-theme/wiki/Screenshots) for more screenshots.

## Dependencies

- [keycloak-app-passwords](https://github.com/radicallyopensecurity/keycloak-app-passwords)
- Linux (not tested on Mac or Windows)
- Bash
- Make
- (optional) docker/podman
- (optional) inotify
- (optional) zip

## Quick Start

Build the distribution files:

```sh
make
```

Choose one, replacing `/opt/keycloak` with your `Keycloak` installation directory.

- Copy the `dist/keycloak-ros-theme` directory to `/opt/keycloak/themes/ros`.
- Copy the `dist/keycloak-ros-theme.jar` file to `/opt/keycloak/providers`.

To build just the `dist` files:

```sh
make build
```

Make sure your `Keycloak` installation has both the theme and extension installed from [keycloak-app-passwords](https://github.com/radicallyopensecurity/keycloak-app-passwords).

The theme should be visible under `themes` in the `realm settings`. A restart may be required.

To redirect users to the `applications` account settings, use the `welcome` theme by setting the environment variable: `KC_SPI_THEME_WELCOME_THEME` to `keycloak-ros-theme`.

> Note: You should do this after bootstrapping `keycloak`, because the bootstrap page is configured in the default `welcome` theme, which is what we're overriding here.

## Development

A development environment is provided using `docker/podman`.

When running for the first time, we have to initialize `OpenLDAP`:

```sh
docker compose up openldap
docker exec -it openldap /bin/sh
cd /tmp/ldapscripts
sh add-schema.sh
```

Then we have import the `realm` into `Keycloak`, while keeping `OpenLDAP` running:

```sh
docker compose up -d openldap
make import
```

Create a `.env`, pointing to your `keycloak-app-passwords` installation.

```sh
cp .env.sample .env
```

For example

```sh
KC_ROS_APP_PASSWORDS_EXTENSION_PATH=/home/user/git/keycloak-app-passwords/extension/target/keycloak-app-passwords-DEV.jar
KC_ROS_APP_PASSWORDS_THEME_PATH=/home/user/git/keycloak-app-passwords/theme/dist_keycloak/keycloak-theme-for-kc-all-other-versions.jar
```

Now we can run the development build.

```sh
docker compose up
```

Visit <http://localhost:8080> to see the `Keycloak` installation.

Make changes to `assets/*` or `theme/*`. Then run:

```sh
make
```

Or watch for changes and automatically rebuild when a file is changed:

```sh
make watch
```

See the `.env.*` files for login credentials. It goes without saying, but don't use these `docker` containers or `env` files in production. They are highly insecure and only meant to be ran locally for development.

## LICENSE

[MIT](./LICENSE.md)
