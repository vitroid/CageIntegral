CXX=g++-11
CXXFLAGS=-Iopt-3.19/src -g # -fopenmp # -O
OMPFLAGS=-fopenmp
LDFLAGS=opt-3.19/src/libopt.a #-lopt
BIN=histogram

%.omp: %.cpp Makefile
	$(CXX) $(CXXFLAGS) $(OMPFLAGS) $< -o $@ $(LDFLAGS)
%.noomp: %.cpp Makefile
	$(CXX) $(CXXFLAGS) $< -o $@ $(LDFLAGS)
test: 12hedra.co2.omp.histo 12hedra.co2.noomp.histo 14hedra.thf.omp.histo 14hedra.thf.noomp.histo
# no omp       134.07 real       102.85 user         0.49 sys
# test: LJME____.fvalues
12hedra.co2.%.histo: $(BIN).%
	cat DEFR 12hedra.nx4a | time ./$< -i HTCO2___ > $@ 2> $@.log
14hedra.thf.%.histo: $(BIN).%
	cat DEFR 14hedra.nx4a | time ./$< -i TYTHF___ > $@ 2> $@.log
%.14hedra.histo: $(BIN)
	cat DEFR 14hedra.nx4a | time ./$(BIN) -i $* > $@
%.16hedra.histo: $(BIN)
	cat DEFR 16hedra.nx4a | time ./$(BIN) -i $* > $@
%.fvalues: 
	-for cage in 12 14 16; do echo $*.$${cage}hedra.histo; done | xargs make -j -k
	./fvalue.py $* | tee $@

# get opt library
opt-3.19:
	wget https://www.decompile.com/download/not_invented_here/opt-3.19.tar.gz
	tar zxvf opt-3.19.tar.gz
opt-3.19/src/libopt.a: opt-3.19
	cd opt-3.19 && ./configure && make

clean:
	-rm histogram
workclean:
	-rm *.fvalues *.histo
