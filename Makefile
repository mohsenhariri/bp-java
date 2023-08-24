# https://www.gnu.org/software/make/manual/make.html
SHELL := /bin/bash
ENV ?= env  # default, other options: test, prod

-include .env.$(ENV)
export

-include *.make

WORKDIR := $(shell pwd)
VERSION := $(shell cat VERSION)
# PROJECT := $(shell basename $(CURDIR))
COMPANY ?= com
PROJECT ?= pokeverse
PACKAGE ?= pokemon

FPN := $(COMPANY).$(PROJECT).$(PACKAGE)

JAVA := /usr/bin/java
JAR := /usr/bin/jar
JC := /usr/bin/javac

DOCKER := /usr/bin/docker

PATH := ./bin:$(PATH)

SRC := src
DIST := target
LIB := lib

JFLAGS := -g -d $(DIST)


.PHONY: env test all dev clean deps $(SRC) $(DIST) $(BUILD)

.DEFAULT_GOAL := test

.ONESHELL:

%:
		@:

test:
		@$(JAVA) --version
		@$(JAR) --version
		@$(JC) --version

switch-env:
		sed -i 's/ENV ?= env/ENV ?= $(filter-out $@,$(MAKECMDGOALS))/' Makefile

deps: dirs
		@while read -r line; do \
			if [[ ! $$line =~ ^# ]]; then \
				wget $$line -nc -P $(LIB); \
				# Add your command to process the URL here \
			fi; \
		done < deps

source:
		find $(SRC) -name "*.java" > sources.txt

compile: dirs
		$(JC) $(JFLAGS) -cp "$(DIST):$(LIB)/*" @sources.txt

run:
		$(JAVA) -cp "$(DIST):./lib/*" $(FPN).App

all: source compile run

build: dirs
		@find $(DIST) -name "*.class" > classes.txt
		$(JAR) cvfm App.jar Manifest.txt -C $(DIST) . -C $(LIB) .

exec:
		$(JAVA) -cp "$(DIST):$(LIB)/*:./App.jar" $(FPN).App

clean:
		@rm -r ./$(DIST)
		@rm sources.txt classes.txt App.jar

test-main:
		$(JAVA) -cp "$(DIST):$(LIB)/*" org.junit.runner.JUnitCore $(FPN).AppTest

dirs:
		@mkdir -p $(DIST) $(LIB)