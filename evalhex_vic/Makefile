evalhex.d64: evalhex_poker.p00 evalhex.bin evalhex.seq
	@c1541 -format "evalhex vic20,ex" d64 $@
	@c1541 -attach $@ -write evalhex_poker.p00 'evalhex poker'
	@c1541 -attach $@ -write evalhex.bin 
	@c1541 -attach $@ -write evalhex.seq evalhex.s,s

evalhex_poker.bas: evalhex.bin
	@bash makepoker.sh $< >$@

evalhex.seq: evalhex.s
	bash -c "tr \$$'a-zA-Z\n' \$$'A-Za-z\r' <$< >$@"

evalhex.bin: evalhex.s
	cl65 -t none -o $@ $<
