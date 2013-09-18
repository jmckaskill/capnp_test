#   Copyright 2013 Andreas Stenius <kaos@astekk.se>
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# capnp_test Makefile

# temporary for now, meant to be provided on the command line or other
# makefile...
test = ./ecapnp_test.sh


TESTS = simpleTestData-decode

all: expect $(TESTS)
	echo "All tests OK for $(test)"

expect:
	mkdir $@

expect/%.txt: test.capnp
	capnp eval $< $* > $@

expect/%.bin: test.capnp
	capnp eval --binary $< $* > $@

%-decode: expect/%.txt expect/%.bin
	cat expect/$*.bin \
	| $(test) decode $* \
	| diff expect/$*.txt -
