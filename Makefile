GENERATOR=Ninja

all: build/system

build/system:
	mkdir -p build/system
	cmake -Bbuild/system -H. -DCMAKE_BUILD_TYPE=Debug -DBUILD_SHARED_LIBS=ON -G$(GENERATOR)
	ninja -Cbuild/system

.PHONY: clean purge
clean:
	ninja -Cbuild/system clean

purge:
	rm -rf build/
