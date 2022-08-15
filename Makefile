
THIS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
CI_COMMIT_REF_NAME?=$(shell git rev-parse --abbrev-ref HEAD)

.PHONY: serve pages

serve: venv
	. venv/bin/activate ; nikola auto --browser

pages: venv
	. venv/bin/activate ; nikola build

venv: venv/setup_by_make

# this way we only re-run install if requirements change
venv/setup_by_make: requirements.txt
	test -d $(THIS_DIR)/venv || python3 -m venv $(THIS_DIR)/venv
	. $(THIS_DIR)/venv/bin/activate ; python3 -m pip install -q -r $(THIS_DIR)/requirements.txt
	touch $(THIS_DIR)/venv/setup_by_make
