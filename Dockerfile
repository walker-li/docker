# BASE IMAGE
FROM nvidia/cuda:10.2-devel-ubuntu16.04

LABEL maintainer="17752510019@163.com"

SHELL ["/bin/bash","-c"]

# install tools
RUN apt-get update -y && \
apt-get install -y python-dev && \
apt-get install -y libffi-dev && \
apt-get install -y libssl-dev && \
apt-get install -y make && \
apt-get install -y build-essential && \
apt-get install -y libssl-dev && \
apt-get install -y zlib1g-dev && \
apt-get install -y libbz2-dev && \
apt-get install -y libreadline-dev && \
apt-get install -y libsqlite3-dev && \
apt-get install -y wget && \
apt-get install -y curl && \
apt-get install -y llvm && \
apt-get install -y libncurses5-dev && \
apt-get install -y libncursesw5-dev && \
apt-get install -y xz-utils && \
apt-get install -y tk-dev && \
apt-get install -y gcc && \
# clear
apt-get autoclean && apt-get autoremove

WORKDIR /home/

RUN wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz && \
tar -zxvf Python-3.6.5.tgz && \
mv Python-3.6.5 /usr/local

WORKDIR /usr/local/Python-3.6.5/

RUN rm -rf /home/* && \
./configure --prefix=/usr/local/python3 && \
make && \
make install &&\
ln -s /usr/local/python3/bin/python3 /usr/bin/python3 && \
ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3 && \
wget --quiet https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -O ~/anaconda.sh && \
/bin/bash ~/anaconda.sh -b -p /opt/conda && \
rm ~/anaconda.sh && \
echo "export PATH=/opt/conda/bin:$PATH" >> ~/.bashrc && \
ln -s /opt/conda/bin/conda /usr/bin/conda &&\
ln -s /opt/conda/bin/activate /usr/bin/activate &&\
ln -s /opt/conda/bin/deactivate /usr/bin/deactivate &&\
conda create -n pytorch_test python=3.6.5 &&\
source activate pytorch_test && \
conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch

WORKDIR /

EXPOSE 80

CMD /bin/bash
