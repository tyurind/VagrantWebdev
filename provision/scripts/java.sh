# bash


JAVA_URL_86="https://googledrive.com/host/0B-rZL_vXzmg8SHY4Yno2VEhQamc/jdk-7u51-linux-i586.gz"
JAVA_URL_64="https://googledrive.com/host/0B-rZL_vXzmg8SHY4Yno2VEhQamc/jdk-7u51-linux-x64.gz"
ANT_URL="http://apache-mirror.rbc.ru/pub/apache//ant/binaries/apache-ant-1.9.3-bin.tar.gz"

if [ "$(uname -m 2>/dev/null | grep 64)" != "" ]; then
    JAVA_URL="$JAVA_URL_64"
    echo ">>> JAVA x64"
else
    JAVA_URL="$JAVA_URL_86"
    echo ">>> JAVA x86"
fi


mkdir -p /usr/lib/java 
cd /usr/lib/java

if [ "$(java -version 2>&1 | grep 'java version')" = "" ]; then
    wget --no-check-certificate -O - "$JAVA_URL" | tar -xzf -
    update-alternatives --install /usr/bin/java java /usr/lib/java/jdk1.7.0_51/bin/java 1000
    java -version
fi

if [ "$(ant -version 2>&1 | grep 'version')" = "" ]; then
    wget --no-check-certificate -O - "$ANT_URL" | tar -xzf -
    update-alternatives --install /usr/bin/ant ant /usr/lib/java/apache-ant-1.9.3/bin/ant 1000
    ant -version
fi

unset JAVA_URL_86 JAVA_URL_64 JAVA_URL ANT_URL