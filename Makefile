# Customize LANGUAGE_SUFFIX and ASCIIDOCTOR_LANGUAGE for non-English languages.
# See the "upload-all" below for examples how to use them.
#
# Suffix added to input and output filenames.
LANGUAGE_SUFFIX:=
# Language parameters to AsciiDoctor, see https://asciidoctor.org/docs/user-manual/#language-support
ASCIIDOCTOR_LANGUAGE:=

NAME:=modern_pascal_introduction$(LANGUAGE_SUFFIX)
ALL_OUTPUT:=$(NAME).html $(NAME).pdf $(NAME).xml
#TEST_BROWSER:=firefox
TEST_BROWSER:=x-www-browser

all: $(ALL_OUTPUT)

$(NAME).html: $(NAME).adoc
	asciidoctor $< -o $@
	fpc -gl -gh patreon-link-insert.lpr
	./patreon-link-insert $@
	$(TEST_BROWSER) $@ &

$(NAME).xml: $(NAME).adoc
	asciidoctor $(ASCIIDOCTOR_LANGUAGE) -b docbook5 $< -o $@
#	yelp $@

$(NAME).pdf: $(NAME).xml
	fopub $(NAME).xml

# $(NAME).pdf: $(NAME).adoc
# 	asciidoctor-pdf $(NAME).adoc

.PHONY: clean
clean:
	rm -f $(ALL_OUTPUT)

.PHONY: test
test:
	$(MAKE) -C code-samples$(LANGUAGE_SUFFIX)/ clean all

SSH_TARGET:=michalis@ssh.castle-engine.io
SCP_TARGET:=$(SSH_TARGET):/home/michalis/cge-html/
HTML_BASE:=https://castle-engine.io/

.PHONY: upload
upload: test clean all
	scp $(NAME).html $(NAME).pdf patreon-wordmark.png $(SCP_TARGET)
	$(TEST_BROWSER) $(HTML_BASE)$(NAME).html &
	$(TEST_BROWSER) $(HTML_BASE)$(NAME).pdf &
	ssh $(SSH_TARGET) www_permissions.sh
	ssh $(SSH_TARGET) purge_cache.sh

.PHONY: upload-all
upload-all:
	$(MAKE) upload
	$(MAKE) upload LANGUAGE_SUFFIX=_russian ASCIIDOCTOR_LANGUAGE='-a lang=ru'
	$(MAKE) upload LANGUAGE_SUFFIX=_bg ASCIIDOCTOR_LANGUAGE='-a lang=bg'
	$(MAKE) upload LANGUAGE_SUFFIX=_ukrainian ASCIIDOCTOR_LANGUAGE='-a lang=ua'
	scp modern_pascal_introduction_chinese.pdf $(SCP_TARGET)

# Update cge-www contents assuming they are in $CASTLE_ENGINE_PATH/../cge-www/ .
#
# The full sequence to do update:
# - make upload # updates PDF; or make upload-all, if translations changed
# - make update-cge-www
# - commit and push cge-www repo,
# - www_synchronize_noimages.sh on sever.
CGE_WWW_PATH:=$(CASTLE_ENGINE_PATH)/../cge-www/
CGE_ADOC_PATH:=$(CGE_WWW_PATH)/htdocs/doc/modern_pascal.adoc
CGE_SAMPLES_PATH:=$(CGE_WWW_PATH)/htdocs/doc/modern_pascal_code_samples/
.PHONY: update-cge-www
update-cge-www:
# Sanity check.
	if [ ! -f $(CGE_ADOC_PATH) ]; then \
	  echo "Missing $(CGE_ADOC_PATH), make sure CASTLE_ENGINE_PATH env variable is OK and cge-www is cloned alongside"; \
		exit 1; \
	fi

# Copy and adjust adoc file.
#
# We version the $(CGE_ADOC_PATH).1,2,3... to
# - allow easy debugging what script did (look at each file in succession)
# - not worry that tail would have equal stdin and stdout.
	cp -f modern_pascal_introduction.adoc $(CGE_ADOC_PATH).1
	tail --lines=+9 $(CGE_ADOC_PATH).1 > $(CGE_ADOC_PATH).2
	cat cge_www_header.adoc $(CGE_ADOC_PATH).2 > $(CGE_ADOC_PATH).3
	sed -e 's|include::code-samples/|include::modern_pascal_code_samples/|' $(CGE_ADOC_PATH).3 > $(CGE_ADOC_PATH).4
	cp -f $(CGE_ADOC_PATH).4 $(CGE_ADOC_PATH)
	rm -f $(CGE_ADOC_PATH).?

# Copy the code samples.
# Avoid deleting/overwriting .gitignore there, which is maintained by hand in cge-www.
	find $(CGE_SAMPLES_PATH) \
	  '(' -type f -name .gitignore -prune ')' -or \
		'(' -type f -execdir rm -f '{}' ';' ')'
	make -C code-samples/ clean
	cp -Rf code-samples/* $(CGE_SAMPLES_PATH)
