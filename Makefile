.PHONY: all build clean copy merge pack import export dev

all: build
build: clean copy merge

dev:
	./.internal/keycloak/dev.sh

clean:
	./.internal/build/clean.sh

copy:
	./.internal/build/copy.sh

merge:
	./.internal/build/merge.sh

watch:
	./.internal/build/watch.sh

pack:
	./.internal/build/pack.sh

import:
	./.internal/keycloak/import.sh

export:
	./.internal/keycloak/export.sh
