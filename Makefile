#############################################################################
##  v      #                   The Coq Proof Assistant                     ##
## <O___,, #  CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud   ##
##   \VV/  #                                                               ##
##    //   #  Makefile automagically generated by coq_makefile V8.3-bugfix ##
#############################################################################

# WARNING
#
# This Makefile has been automagically generated
# Edit at your own risks !
#
# END OF WARNING

#
# This Makefile was generated by the command line :
# coq_makefile -no-install -opt MLIFILES = $(MLFILES:.ml=.mli) matcher.ml coq.ml theory.ml aac_rewrite.ml AAC.v Instances.v Tutorial.v -f magic.txt 
#

# 
# This Makefile may take 3 arguments passed as environment variables:
#   - COQBIN to specify the directory where Coq binaries resides;
#   - CAMLBIN and CAMLP4BIN to give the path for the OCaml and Camlp4/5 binaries.
COQLIB:=$(shell $(COQBIN)coqtop -where | sed -e 's/\\/\\\\/g')
CAMLP4:="$(shell $(COQBIN)coqtop -config | awk -F = '/CAMLP4=/{print $$2}')"
ifndef CAMLP4BIN
  CAMLP4BIN:=$(CAMLBIN)
endif

CAMLP4LIB:=$(shell $(CAMLP4BIN)$(CAMLP4) -where)

##########################
#                        #
# Libraries definitions. #
#                        #
##########################

OCAMLLIBS:=-I .
COQSRCLIBS:=-I $(COQLIB)/kernel -I $(COQLIB)/lib \
  -I $(COQLIB)/library -I $(COQLIB)/parsing \
  -I $(COQLIB)/pretyping -I $(COQLIB)/interp \
  -I $(COQLIB)/proofs -I $(COQLIB)/tactics \
  -I $(COQLIB)/toplevel \



















COQLIBS:=-I . 
COQDOCLIBS:=

##########################
#                        #
# Variables definitions. #
#                        #
##########################

ZFLAGS=$(OCAMLLIBS) $(COQSRCLIBS) -I $(CAMLP4LIB)
OPT:=
COQFLAGS:=-q $(OPT) $(COQLIBS) $(OTHERFLAGS) $(COQ_XML)
ifdef CAMLBIN
  COQMKTOPFLAGS:=-camlbin $(CAMLBIN) -camlp4bin $(CAMLP4BIN)
endif
COQC:=$(COQBIN)coqc
COQDEP:=$(COQBIN)coqdep -c
GALLINA:=$(COQBIN)gallina
COQDOC:=$(COQBIN)coqdoc
COQMKTOP:=$(COQBIN)coqmktop
CAMLLIB:=$(shell $(CAMLBIN)ocamlc.opt -where)
CAMLC:=$(CAMLBIN)ocamlc.opt -c -rectypes
CAMLOPTC:=$(CAMLBIN)ocamlopt.opt -c -rectypes
CAMLLINK:=$(CAMLBIN)ocamlc.opt -rectypes
CAMLOPTLINK:=$(CAMLBIN)ocamlopt.opt -rectypes
GRAMMARS:=grammar.cma
CAMLP4EXTEND:=pa_extend.cmo pa_macro.cmo q_MLast.cmo
CAMLP4OPTIONS:=
MLIFILES=$(MLFILES:.ml=.mli)
PP:=-pp "$(CAMLP4BIN)$(CAMLP4)o -I $(CAMLLIB) -I . $(COQSRCLIBS) $(CAMLP4EXTEND) $(GRAMMARS) $(CAMLP4OPTIONS) -impl"

###################################
#                                 #
# Definition of the "all" target. #
#                                 #
###################################

VFILES:=AAC.v\
  Instances.v\
  Tutorial.v
VOFILES:=$(VFILES:.v=.vo)
VOFILES0:=$(filter-out ,$(VOFILES))
GLOBFILES:=$(VFILES:.v=.glob)
VIFILES:=$(VFILES:.v=.vi)
GFILES:=$(VFILES:.v=.g)
HTMLFILES:=$(VFILES:.v=.html)
GHTMLFILES:=$(VFILES:.v=.g.html)
MLFILES:=matcher.ml\
  coq.ml\
  theory.ml\
  aac_rewrite.ml
CMOFILES:=$(MLFILES:.ml=.cmo)
CMOFILES0:=$(filter-out ,$(CMOFILES))
CMIFILES:=$(MLFILES:.ml=.cmi)
CMIFILES0:=$(filter-out ,$(CMIFILES))
CMXFILES:=$(MLFILES:.ml=.cmx)
CMXSFILES:=$(MLFILES:.ml=.cmxs)
CMXSFILES0:=$(filter-out ,$(CMXSFILES))
OFILES:=$(MLFILES:.ml=.o)

all: $(VOFILES) $(CMOFILES) $(CMXSFILES) doc\
  aac_tactics.cmxs\
  aac_tactics.cma\
  .depend
spec: $(VIFILES)

gallina: $(GFILES)

html: $(GLOBFILES) $(VFILES)
	- mkdir -p html
	$(COQDOC) -toc -html $(COQDOCLIBS) -d html $(VFILES)

gallinahtml: $(GLOBFILES) $(VFILES)
	- mkdir -p html
	$(COQDOC) -toc -html -g $(COQDOCLIBS) -d html $(VFILES)

all.ps: $(VFILES)
	$(COQDOC) -toc -ps $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $(VFILES)`

all-gal.ps: $(VFILES)
	$(COQDOC) -toc -ps -g $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $(VFILES)`

all.pdf: $(VFILES)
	$(COQDOC) -toc -pdf $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $(VFILES)`

all-gal.pdf: $(VFILES)
	$(COQDOC) -toc -pdf -g $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $(VFILES)`



###################
#                 #
# Custom targets. #
#                 #
###################

doc: $(MLIFILES)
	mkdir -p doc; $(CAMLBIN)ocamldoc -html -rectypes -d doc -m A $(ZDEBUG) $(ZFLAGS) $^ && touch doc

aac_tactics.cmxs: $(CMXFILES)
	$(CAMLOPTLINK) $(ZDEBUG) $(ZFLAGS) -shared -linkall -o aac_tactics.cmxs $(CMXFILES)

aac_tactics.cma: $(CMOFILES)
	$(CAMLLINK) -g -a -o aac_tactics.cma $(CMOFILES)

.depend: $(MLIFILES)
	$(CAMLBIN)ocamldep -slash $(OCAMLLIBS) $^ > .depend

####################
#                  #
# Special targets. #
#                  #
####################

.PHONY: all opt byte archclean clean install depend html

%.cmi: %.mli
	$(CAMLC) $(ZDEBUG) $(ZFLAGS) $<

%.cmo: %.ml
	$(CAMLC) $(ZDEBUG) $(ZFLAGS) $(PP) $<

%.cmx: %.ml
	$(CAMLOPTC) $(ZDEBUG) $(ZFLAGS) $(PP) $<

%.cmxs: %.ml
	$(CAMLOPTLINK) $(ZDEBUG) $(ZFLAGS) -shared -o $@ $(PP) $<

%.cmo: %.ml4
	$(CAMLC) $(ZDEBUG) $(ZFLAGS) $(PP) -impl $<

%.cmx: %.ml4
	$(CAMLOPTC) $(ZDEBUG) $(ZFLAGS) $(PP) -impl $<

%.cmxs: %.ml4
	$(CAMLOPTLINK) $(ZDEBUG) $(ZFLAGS) -shared -o $@ $(PP) -impl $<

%.ml.d: %.ml
	$(CAMLBIN)ocamldep -slash $(OCAMLLIBS) $(PP) "$<" > "$@"

%.vo %.glob: %.v
	$(COQC) $(COQDEBUG) $(COQFLAGS) $*

%.vi: %.v
	$(COQC) -i $(COQDEBUG) $(COQFLAGS) $*

%.g: %.v
	$(GALLINA) $<

%.tex: %.v
	$(COQDOC) -latex $< -o $@

%.html: %.v %.glob
	$(COQDOC) -html $< -o $@

%.g.tex: %.v
	$(COQDOC) -latex -g $< -o $@

%.g.html: %.v %.glob
	$(COQDOC) -html -g $< -o $@

%.v.d: %.v
	$(COQDEP) -slash $(COQLIBS) "$<" > "$@" || ( RV=$$?; rm -f "$@"; exit $${RV} )

byte:
	$(MAKE) all "OPT:=-byte"

opt:
	$(MAKE) all "OPT:=-opt"

clean:
	rm -f $(CMOFILES) $(CMIFILES) $(CMXFILES) $(CMXSFILES) $(OFILES) $(VOFILES) $(VIFILES) $(GFILES) $(MLFILES:.ml=.cmo) $(MLFILES:.ml=.cmx) *~
	rm -f all.ps all-gal.ps all.pdf all-gal.pdf all.glob $(VFILES:.v=.glob) $(HTMLFILES) $(GHTMLFILES) $(VFILES:.v=.tex) $(VFILES:.v=.g.tex) $(VFILES:.v=.v.d)
	rm -f $(CMOFILES) $(MLFILES:.ml=.cmi) $(MLFILES:.ml=.ml.d) $(MLFILES:.ml=.cmx) $(MLFILES:.ml=.o)
	- rm -rf html
	- rm -rf doc
	- rm -f aac_tactics.cmxs
	- rm -f aac_tactics.cma
	- rm -f .depend

archclean:
	rm -f *.cmx *.o


printenv: 
	@echo CAMLC =	$(CAMLC)
	@echo CAMLOPTC =	$(CAMLOPTC)
	@echo CAMLP4LIB =	$(CAMLP4LIB)

.dummy: magic.txt
	mv -f Makefile Makefile.bak
	$(COQBIN)coq_makefile -f magic.txt -o Makefile


-include $(VFILES:.v=.v.d)
.SECONDARY: $(VFILES:.v=.v.d)

-include $(MLFILES:.ml=.ml.d)
.SECONDARY: $(MLFILES:.ml=.ml.d)

# WARNING
#
# This Makefile has been automagically generated
# Edit at your own risks !
#
# END OF WARNING


# sanity checks
tests: Tests.vo

# override inadequate coq_makefile auto-regeneration
Makefile: make_makefile magic.txt files.txt
	. make_makefile

# We want to keep the proofs only in the Tutorial
tutorial: Tutorial.vo Tutorial.glob
	$(COQDOC) --no-index --no-externals -html $(COQDOCLIBS) -d html Tutorial.v

world: $(VOFILES) doc gallinahtml tutorial

# additional dependencies for AAC (since aac_tactics.cmxs/cma are not
# around the first time we run make, coqdep issues a warning and
# ignores this dependency)
# (one can safely select one of theses dependencies according to 
#  coq' compilation mode--bytecode or native)
AAC.vo: aac_tactics.cmxs aac_tactics.cma


# .depend contains dependencies for .mli files
-include .depend
.SECONDARY: .depend

