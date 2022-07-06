RELEASE         ?= $(shell cat ./release.version)

all: clean build

clean:
	rm -f witcom-traefik-*.tar.gz


release_prepare:
	@sed "s/RELEASE/${RELEASE}/g" ./galaxy.yml.in > ./galaxy.yml
	#todo: check for release in changelog

build:
	ansible-lint -x yaml
	@sed "s/RELEASE/${RELEASE}/g" ./galaxy.yml.in > ./galaxy.yml
	ansible-galaxy collection build 
