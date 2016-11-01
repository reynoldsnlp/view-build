lingpipe    := lingpipe-4.1.0.jar
danbikel    := dbparser.jar
rft         := rft-java-beta13.jar
mallet      := mallet.jar
mallet-deps := mallet-deps.jar
stanford    := stanford-english-corenlp-2015-12-11-models.jar
# libsvm      := libsvm.jar

.PHONY: mvn
mvn: $(lingpipe) $(danbikel) $(rft) $(mallet) $(mallet-deps) $(stanford)
	mvn install:install-file -Dpackaging=jar \
	-Dfile=$(lingpipe) \
	-DartifactId=lingpipe \
	-DgroupId=com.aliasi \
	-Dversion=4.1.0
	mvn install:install-file -Dpackaging=jar \
	-Dfile=$(danbikel) \
	-DartifactId=parser \
	-DgroupId=danbikel \
	-Dversion=1.3-current
	mvn install:install-file -Dpackaging=jar \
	-Dfile=$(rft) \
	-DartifactId=rft \
	-DgroupId=de.uni-tuebingen.sfb833.a4 \
	-Dversion=beta13
	mvn install:install-file -Dpackaging=jar \
	-Dfile=$(mallet) \
	-DartifactId=mallet \
	-DgroupId=edu.umass.cs \
	-Dversion=2.0.5
	mvn install:install-file -Dpackaging=jar \
	-Dfile=$(mallet-deps) \
	-DartifactId=mallet-deps \
	-DgroupId=edu.umass.cs \
	-Dversion=2.0.5
	mvn install:install-file -Dpackaging=jar \
	-Dfile=$(stanford) \
	-DartifactId=parser-models \
	-DgroupId=edu.stanford.nlp \
	-Dversion=2015-12-11

$(lingpipe):
	curl -LO 'http://lingpipe-download.s3.amazonaws.com/lingpipe-4.1.0.tar.gz'
	tar xf lingpipe-4.1.0.tar.gz
	cp lingpipe-4.1.0/$(lingpipe) .
	rm -rf lingpipe-4.1.0.tar.gz lingpipe-4.1.0
	chmod -x $(lingpipe)

$(danbikel):
	git clone https://github.com/dbparser/dbparser
	cd dbparser && ant build && cp *jar ..
	rm -rf dbparser

$(stanford):
	curl -LO 'http://nlp.stanford.edu/software/stanford-english-corenlp-2015-12-11-models.jar'

$(rft):
	curl -LO 'http://sifnos.sfs.uni-tuebingen.de/resource/A4/rftj/data/rft-java-beta13.jar'

$(mallet):
	curl -LO 'http://mallet.cs.umass.edu/dist/mallet-2.0.5.tar.gz'
	tar xf mallet-2.0.5.tar.gz
	cd mallet-2.0.5 && ant jar && cp dist/*.jar ..
	rm -rf mallet-2.0.5*

# $(libsvm):
# 	curl -o libsvm.tar.gz -L 'http://www.csie.ntu.edu.tw/~cjlin/cgi-bin/libsvm.cgi?+http://www.csie.ntu.edu.tw/~cjlin/libsvm+tar.gz'
# 	tar xf libsvm.tar.gz
# 	cp libsvm-*/java/libsvm.jar .
# 	rm -rf libsvm-* libsvm.tar.gz

.PHONY: clean
clean:
	rm -f *.jar
