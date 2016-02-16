CXX=g++
CXXFLAGS=-O #-I../opt-3.19/src -O #-g#-static #-fopenmp
LDFLAGS=-lopt #../opt-3.19/src/libopt.a #-lopt
BIN=histogram
DATA=../data
%: %.cpp
	$(CXX) $(CXXFLAGS) $< -o $@ $(LDFLAGS)
all: $(BIN)
test.data: $(DATA)/DEFR $(DATA)/12hedra.nx4a
	cat $^ > $@
test: $(BIN)
	./histogram -i "LJME____" < test.data
clean:
	-rm histogram
