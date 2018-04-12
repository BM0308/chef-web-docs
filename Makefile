BUILDDIR = build
BUILD_COMMAND = sphinx-build -a -W
BUILD_COMMAND_AND_ARGS = $(BUILD_COMMAND)

# if we are in CI we need to add python's binpath:
export PATH := $(shell hab pkg path core/python2)/bin:$(PATH)
export LANG := en_US.UTF-8

prepare:
	pip install -r requirements.txt

docs:
	mkdir -p $(BUILDDIR)
	cp -r misc/robots.txt build/
	cp -r misc/sitemap.xml build/
	$(BUILD_COMMAND_AND_ARGS) chef_master/source $(BUILDDIR)
	bash doctools/rundtags.sh

clean:
	@rm -rf $(BUILDDIR)
