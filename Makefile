NAME:=modern_pascal_introduction
ALL_OUTPUT:=$(NAME).html $(NAME).pdf $(NAME).xml
TEST_BROWSER:=firefox

all: $(ALL_OUTPUT)

$(NAME).html: $(NAME).adoc
	asciidoctor $< -o $@
#	$(TEST_BROWSER) $@ &

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

.PHONY: upload
upload: test clean all
	scp modern_pascal_introduction.html modern_pascal_introduction.pdf michalis@michalis.ii.uni.wroc.pl:/home/michalis/public_html/modern_pascal_introduction/
	$(TEST_BROWSER) http://michalis.ii.uni.wroc.pl/~michalis/modern_pascal_introduction/modern_pascal_introduction.html &
	$(TEST_BROWSER) http://michalis.ii.uni.wroc.pl/~michalis/modern_pascal_introduction/modern_pascal_introduction.pdf &
