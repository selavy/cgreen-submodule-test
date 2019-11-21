GENERATOR=Ninja

all: build/system/test-mylib build/submodule/test-mylib

build/system:
	mkdir -p build/system
	cmake -Bbuild/system -H. -DCMAKE_BUILD_TYPE=Debug -DBUILD_SHARED_LIBS=ON -DUSE_SYSTEM_CGREEN=ON -G$(GENERATOR)

build/system/test-mylib: build/system
	ninja -Cbuild/system

build/submodule:
	mkdir -p build/submodule
	cmake -Bbuild/submodule -H. -DCMAKE_BUILD_TYPE=Debug -DBUILD_SHARED_LIBS=ON -DUSE_SYSTEM_CGREEN=OFF -G$(GENERATOR)

build/submodule/test-mylib: build/submodule
	ninja -Cbuild/submodule

.PHONY: clean purge
clean:
	ninja -Cbuild/system clean

purge:
	rm -rf build/
