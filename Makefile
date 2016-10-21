REBAR := $(shell which rebar)

all: get-deps compile

clean:
	@rm -rf $(CURDIR)/_build $(CURDIR)/ebin/*.beam

clean-deps:
	@rm -rf $(CURDIR)/deps

get-deps:
	@$(REBAR) get-deps

distclean: clean-deps

dialyzer: rebar-check
	@$(REBAR) dialyzer

compile:
	@$(REBAR) compile

shell: rebar-check
	@$(REBAR) shell

test: rebar-check
	@$(REBAR) eunit

test-cover: rebar-check
	@$(REBAR) eunit --cover

test-cover-html: rebar-check
	@$(REBAR) do eunit --cover , cover

travis: clean distclean compile test-cover

.PHONY: all clean get-deps compile dialyzer test-cover test-cover-html
