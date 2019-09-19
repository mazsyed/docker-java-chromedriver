FROM openjdk:8-jdk

ENV CHROMEDRIVER_VERSION 75.0.3770.140

# Allow https sources
sudo apt-get install -y libappindicator1 fonts-liberation
sudo apt-get -y install dbus-x11 xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic xfonts-scalable
RUN apt-get update && apt-get install libxss1 lsb-release xdg-utils

# Install Chrome and xvfb
RUN apt-get update \
&& apt-get install -y libxss1 libappindicator3-1 libindicator7 fonts-liberation lsb-release xdg-utils xvfb \
&& wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
&& sudo dpkg -i google-chrome*.deb \
&& sudo apt-get install -f \
&& rm "google-chrome-stable_current_amd64.deb" \
&& rm -rf /var/lib/apt/lists/*

# Install Chromedriver 
RUN wget -N http://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip \
&& unzip chromedriver_linux64.zip \
&& chmod +x chromedriver \
&& mv -f chromedriver /usr/local/share/chromedriver \
&& ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver \
&& ln -s /usr/local/share/chromedriver /usr/bin/chromedriver \
&& rm "chromedriver_linux64.zip"
