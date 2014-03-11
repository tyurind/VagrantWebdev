# bash


JAVA_URL="https://googledrive.com/host/0B-rZL_vXzmg8SHY4Yno2VEhQamc/jdk-7u51-linux-i586.gz"
ANT_URL="http://apache-mirror.rbc.ru/pub/apache//ant/binaries/apache-ant-1.9.3-bin.tar.gz"


mkdir -p /usr/lib/java 
cd /usr/lib/java

wget -O - "$JAVA_URL" | tar -xzf -
update-alternatives --install /usr/bin/java java /usr/lib/java/jdk1.7.0_51/bin/java 1000
java -version

wget -O - "$ANT_URL" | tar -xzf -
update-alternatives --install /usr/bin/ant ant /usr/lib/java/apache-ant-1.9.3/bin/ant 1000
ant -version


unset JAVA_URL ANT_URL