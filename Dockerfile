FROM mono:5.8

RUN apt-get update \
 && apt-get install -y unzip libgomp1 \
 && rm -rf /var/lib/apt/lists/* /tmp/*

RUN curl -LO https://github.com/boogie-org/boogie/archive/master.zip \
 && curl -LO https://github.com/Z3Prover/z3/releases/download/z3-4.5.0/z3-4.5.0-x64-debian-8.5.zip \
 && unzip master.zip && mv boogie-master boogie \
 && unzip z3*.zip \
 && rm master.zip z3*.zip \
 && msbuild /p:Configuration=Release boogie/Source/Boogie.sln \
 && ln -s $PWD/z3*/bin/z3 boogie/Binaries/z3.exe

COPY boogie /usr/local/bin

WORKDIR boogie/Test

CMD ["bash"]
