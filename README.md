# Zephyr Application Debian package Installation

## Installation

install Debian package for zephyr application

	./debian_package.sh install

*for interactive `./debian_package.sh`*

## Download Zephyr Application Projects

download zephyr application projects

	eczephyr install ${PATH_TO_DOWNLOAD}

*`PATH_TO_DOWNLOAD`: path to download zephyr app project*

## Build Zephyr Application Projects

build zephyr application project

	eczephyr build ${APP_PROJECT_PATH}

*`APP_PROJECT_PATH`: should target to **ecfw_zephyr** dir*

build with supporting board

	eczephyr build -b -c ${APP_PROJECT_PATH}

*`-b`: pop up to boards selection*
*`-c`: clear app project build dir*

more details:

	eczephyr build -h

## Uninstall

uninstall zephyr application Debian package

	./debian_package.sh uninstall
