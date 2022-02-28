#!/bin/bash
asciidoctor \
	-r ./arun-src-linker.rb \
	--failure-level WARN \
	--verbose \
	--timings \
	--safe-mode unsafe \
	-a source-highlighter=rouge \
	-a rouge-style=thankful_eyes \
	arun-src-linker-info.asciidoc
