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

.PHONY: upload-all
upload-all:
	$(MAKE) upload
	$(MAKE) upload LANGUAGE_SUFFIX=_russian ASCIIDOCTOR_LANGUAGE='-a lang=ru'
	$(MAKE) upload LANGUAGE_SUFFIX=_bg ASCIIDOCTOR_LANGUAGE='-a lang=bg'
	$(MAKE) upload LANGUAGE_SUFFIX=_ukrainian ASCIIDOCTOR_LANGUAGE='-a lang=ua'
	scp modern_pascal_introduction_chinese.pdf $(SCP_TARGET)
