CXX=g++
CXXFLAGS=-O #-I../opt-3.19/src -O #-g#-static #-fopenmp
LDFLAGS=-lopt #../opt-3.19/src/libopt.a #-lopt
BIN=histogram
DATA=.
%: %.cpp
	$(CXX) $(CXXFLAGS) $< -o $@ $(LDFLAGS)
all: $(BIN)
test.data: $(DATA)/DEFR $(DATA)/12hedra.nx4a
	cat $^ > $@
test: $(BIN)
	./histogram -i "LJME____" < test.data
test2: $(BIN)
	./histogram -i "HTCO2___" < test.data
test_pr: $(BIN)
	cat $(DATA)/DEFR $(DATA)/14hedra.nx4a | ./histogram -i "LJPR____" > LJPR.histo
test_pr2: $(BIN)
	cat $(DATA)/DEFR $(DATA)/14hedra.nx4a | ./histogram -i "LJPR2___" > LJPR2.histo
test_prx: $(BIN)
	cat $(DATA)/DEFR $(DATA)/14hedra.nx4a | ./histogram -i "LJPRX___" > LJPRX.histo

clean:
	-rm histogram
