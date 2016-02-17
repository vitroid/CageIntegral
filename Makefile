CXX=g++
CXXFLAGS=-O #-I../opt-3.19/src -O #-g#-static #-fopenmp
LDFLAGS=-lopt #../opt-3.19/src/libopt.a #-lopt
BIN=histogram

%: %.cpp
	$(CXX) $(CXXFLAGS) $< -o $@ $(LDFLAGS)
all: $(BIN)
test: LJME____.fvalues
%.12hedra.histo: histogram
	cat DEFR 12hedra.nx4a | time ./histogram -i $* > $@
%.14hedra.histo: histogram
	cat DEFR 14hedra.nx4a | time ./histogram -i $* > $@
%.16hedra.histo: histogram
	cat DEFR 16hedra.nx4a | time ./histogram -i $* > $@
%.fvalues: histogram
	-for cage in 12 14 16; do echo $*.$${cage}hedra.histo; done | xargs make -j -k
	./fvalue.py $* | tee $@

clean:
	-rm histogram
workclean:
	-rm *.fvalues *.histo
