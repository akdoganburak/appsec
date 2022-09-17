FROM registry.suse.com/suse/sles12sp4
COPY fortify.license ./
COPY Fortify_SCA_and_Apps_22.1.0_linux_x64.run ./
COPY installerSettings ./
RUN zypper -n install rpm-build
RUN ./Fortify_SCA_and_Apps_22.1.0_linux_x64.run --mode unattended \
  --optionfile ./installerSettings && \
  /opt/Fortify/Fortify_SCA_and_Apps_22.1.0/bin/fortifyupdate && \
  rm Fortify_SCA_and_Apps_22.1.0_linux_x64.run fortify.license installerSettings
 
ENTRYPOINT [ "/opt/Fortify/Fortify_SCA_and_Apps_22.1.0/bin/sourceanalyzer" ]