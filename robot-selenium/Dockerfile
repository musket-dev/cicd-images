ARG ROBOTFRAMEWORK=3.0
ARG SELENIUM2LIBRARY=1.7.4
ARG ROBOT_FAKER=3.0.0
ARG DATABASELIBRARY=0.8.1
ARG PABOT=0.44
ARG PDFMERGE=0.0.7
ARG FAKER=0.8.11
ARG CHROMEDRIVER_VERSION=2.33
FROM debian:jessie-slim

RUN apt-get update
RUN apt-get install -y python python-pip gcc wget curl unzip libfreetype6 libfontconfig1 libxrender1 libXext6 libXdamage1 libXfixes-dev libXcomposite-dev libasound-dev libdbus-glib-1-dev libgtk2.0-0 libxt6

ENV CHROMEDRIVER_VERSION ${CHROMEDRIVER_VERSION}

WORKDIR /robot

ADD utils/headless-chrome /usr/bin/headless-chrome
RUN chmod a+x /usr/bin/headless-chrome

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
  && apt-get update \
  && apt-get -y install google-chrome-stable

RUN mv /opt/google/chrome/google-chrome /opt/google/chrome/google-chrome-browser \
   && rm /usr/bin/google-chrome-stable \
   && rm /usr/bin/google-chrome \
   && ln -s /opt/google/chrome/google-chrome-browser /usr/bin/chrome \
   && ln -s /usr/bin/headless-chrome /usr/bin/google-chrome

RUN curl -SLO "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" \
  && unzip "chromedriver_linux64.zip" -d /usr/local/bin \
  && rm "chromedriver_linux64.zip"

RUN pip install robotframework==${ROBOTFRAMEWORK}
RUN pip install robotframework-selenium2library==${SELENIUM2LIBRARY}
RUN pip install robotframework-faker==${ROBOT_FAKER}
RUN pip install robotframework-pabot==${PABOT}
RUN pip install robotframework-databaselibrary==${DATABASELIBRARY}
RUN pip install pdfmerge==${PDFMERGE}
RUN pip install faker==${FAKER}

RUN pip list
RUN chrome --version
