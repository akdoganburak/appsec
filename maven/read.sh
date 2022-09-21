#realease
https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.5.0/

#default repo folder
C:\Users\Administrator\.m2\repository

#fortify plugin src
C:\Program Files\Fortify\Fortify_SCA_and_Apps_22.1.1\plugins\maven\maven-plugin-src
mvn clean install

#fortify plugin location
C:\Users\Administrator\.m2\repository\com\fortify\sca\plugins\maven\sca-maven-plugin

#fortify scan /w mvn
mvn com.fortify.sca.plugins.maven:sca-maven-plugin:<ver>:clean
mvn com.fortify.sca.plugins.maven:sca-maven-plugin:<ver>:translate
mvn com.fortify.sca.plugins.maven:sca-maven-plugin:<ver>:scan

#fortify scan /w sourceanalyzer
sourceanalyzer -b MyProject -clean
sourceanalyzer -b MyProject [<sca_options>] [<mvn_command_with_options>] (sourceanalyzer -b MyProject mvn package)
sourceanalyzer -b MyProject [<sca_scan_options>] -scan -f MyResults.fpr

