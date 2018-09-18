ERSHD_PATH=_build/default/rel/ershd/bin/ershd
ERSH_PATH=_build/default/bin/ersh

ersh:
	rebar3 escriptize
	$(ERSH_PATH)

ershd:
	rebar3 release
	$(ERSHD_PATH) start
	$(ERSHD_PATH) attach