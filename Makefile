NAME:=modern_pascal_introduction
ALL_OUTPUT:=$(NAME).html $(NAME).pdf $(NAME).xml
#TEST_BROWSER:=firefox
TEST_BROWSER:=x-www-browser

all: $(ALL_OUTPUT)

$(NAME).html: $(NAME).adoc
	asciidoctor $< -o $@
	LINE="`cat patreon-link.css | tr '\n' ' ' `" && sed -e "s|</head>|<style>$$LINE</style></head>|" --in-place $@
	LINE="`cat patreon-link.html | tr '\n' ' ' `" && sed -e "s|<div id=\"toc\" class=\"toc2\">|$$LINE<div id=\"toc\" class=\"toc2\">|" --in-place $@
	$(TEST_BROWSER) $@ &

$(NAME).xml: $(NAME).adoc
	asciidoctor -b docbook5 $< -o $@
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
	$(MAKE) -C code-samples/ clean all

#SSH_TARGET:=michalis@michalis.ii.uni.wroc.pl
SSH_TARGET:=michalis@castle-engine.io
#SCP_TARGET:=$(SSH_TARGET):/home/michalis/public_html/modern_pascal_introduction/
SCP_TARGET:=$(SSH_TARGET):/home/michalis/cge-html/
#HTML_BASE:=http://michalis.ii.uni.wroc.pl/~michalis/modern_pascal_introduction/
HTML_BASE:=http://castle-engine.io/

.PHONY: upload
upload: test clean all
	scp modern_pascal_introduction.html modern_pascal_introduction.pdf patreon-link.png $(SCP_TARGET)
	$(TEST_BROWSER) $(HTML_BASE)modern_pascal_introduction.html &
	$(TEST_BROWSER) $(HTML_BASE)modern_pascal_introduction.pdf &
	ssh $(SSH_TARGET) www_permissions.sh
