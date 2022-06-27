RELEASE         ?= $(shell cat ./release.version)

all: clean build

clean:
	rm -f witcom-witcom_mrtg-*.tar.gz

build:
	@sed "s/RELEASE/${RELEASE}/g" ./galaxy.yml.in > ./galaxy.yml
	ansible-galaxy collection build 
