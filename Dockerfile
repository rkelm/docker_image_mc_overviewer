FROM ubuntu:18.10

ARG DEBIAN_FRONTEND=noninteractive
ENV APP_NAME Overviewer for Minecraft
ENV APP_DIR INSTALL
ENV MC_VERSION 1.13
ENV DATA = $(date -Idate)

RUN apt-get update && echo $DATE
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN echo "deb https://overviewer.org/debian ./" >> /etc/apt/sources.list
RUN apt-get -y install apt-transport-https > /dev/null
RUN apt-get -y install wget gnupg > /dev/null
RUN wget -nv -O - https://overviewer.org/debian/overviewer.gpg.asc | apt-key add -
RUN apt-get update && echo $DATE
RUN apt-get -y install minecraft-overviewer > /dev/null
RUN wget -nv https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar -P ~/.minecraft/versions/${
MC_VERSION}/

RUN echo -e ' ************************************************** \n' \
  'Docker Image to run app ${APP_NAME} ${MC_VERSION}. \n' \
  ' \n' \
  'Usage: \n' \
  '   Run overviewer:	docker run -v <host-world-dir>:/root/world \\ \n' \
  '                             -v <host-config-&-texture-dir>:/root/config \\ \n' \
  '                             -v <host-render-output-dir>:/root/render_output \\ \n' \
  '                             <image_name> overviewer.py --config=/root/config/<config file> /root/render_output\n' \
  '   Simple run without config: \n' \
  '   	  	  	docker run -v <host-world-dir>:/root/world \\ \n' \
  '                             -v <host-render-output-dir>:/root/render_output \\ \n' \
  '                             <image_name> overviewer.py /root/world /root/render_output \n' \  
  '   Configure overviewer: \n' \
  '			Put configuration file(s) in volume mounted to /root/config. \n' \
  '			Output will be rendered in /root/render_output. \n' \
'**************************************************' > /image_info.txt

RUN mkdir /root/world
RUN mkdir /root/config
RUN mkdir /root/render_output

# Path to map files. Path to config file. Path to render output.
VOLUME ["/root/world","/root/config","/root/render_output"]

CMD ["/bin/cat", "/image_info.txt"]
