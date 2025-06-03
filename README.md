# keycloak-ros-theme

This repository contains the ROS theme for Keycloak.

See [the wiki](https://github.com/radicallyopensecurity/keycloak-ros-theme/wiki/Screenshots) for screenshots.

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

Copy the `dist/ros` directory to `/opt/keycloak/themes/ros`.

If you want a `jar` file instead:

```sh
make
make package
```

Copy the `dist/ros.jar` file to `/opt/keycloak/providers`.

Make sure your `Keycloak` installation has both the theme and extension installed from [keycloak-app-passwords](https://github.com/radicallyopensecurity/keycloak-app-passwords).

The theme should be visible under `themes` in the `realm settings`. A restart may be required.

To redirect users to the `applications` account settings, use the `welcome` theme by setting the environment variable: `KC_SPI_THEME_WELCOME_THEME` to `ros`.

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
