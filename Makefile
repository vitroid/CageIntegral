CXX=g++
CXXFLAGS=-std=c++14 -O -Iopt-3.19/src #-g#-static #-fopenmp
LDFLAGS=opt-3.19/src/libopt.a #-lopt
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
%.fvalues: histogram vdwp/physconst.py vdwp/chempot.py fvalue.py %.12hedra.histo %.14hedra.histo %.16hedra.histo
	python fvalue.py $* | tee $@

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
