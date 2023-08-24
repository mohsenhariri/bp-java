# https://www.gnu.org/software/make/manual/make.html
SHELL := /bin/bash

include .env.dev
export

include *.make

VERSION := $(shell cat VERSION)
PROJECT := $(shell basename $(CURDIR))

# JAVA := /home/mohsen/compiler/jdk/bin/java
JAVA := /usr/bin/java
# JAR := /home/mohsen/compiler/jdk/bin/jar
JAR := /usr/bin/jar
# JC := /home/mohsen/compiler/jdk/bin/javac
JC := /usr/bin/javac

DOCKER := /usr/bin/docker

PATH := ./bin:$(PATH)

.PHONY: all dev clean

SRC = src
DIST = target
LIB = lib

COMPANY = com
PROJECT = pokeverse
PACKAGE = pokemon

FPN = $(COMPANY).$(PROJECT).$(PACKAGE)

JFLAGS = -g -d $(DIST)

.PHONY: env test all dev clean dev gen-commands $(SRC) $(DIST) $(BUILD)

.DEFAULT_GOAL := test

.ONESHELL:

%: # https://www.gnu.org/software/make/manual/make.html#Automatic-Variables 
		@:

test:
		@$(JAVA) --version
		@$(JAR) --version
		@$(JC) --version

source:
		find $(SRC) -name "*.java" > sources.txt

compile:
		$(JC) $(JFLAGS) -cp "$(DIST):$(LIB)/*" @sources.txt

run:
		$(JAVA) -cp "$(DIST):./lib/*" $(FPN).App

all: source compile run

build:
		find $(DIST) -name "*.class" > classes.txt
		$(JAR) cvfm App.jar Manifest.txt -C $(DIST) . -C $(LIB) .

exec:
		$(JAVA) -cp "$(DIST):$(LIB)/*:./App.jar" $(FPN).App

clean:
		rm -r ./$(DIST)

test-main:
		$(JAVA) -cp "$(DIST):$(LIB)/*" org.junit.runner.JUnitCore $(FPN).AppTest

deps:
		@while read -r line; do \
			if [[ ! $$line =~ ^# ]]; then \
				wget $$line -nc -P $(LIB); \
				# Add your command to process the URL here \
			fi; \
		done < deps
