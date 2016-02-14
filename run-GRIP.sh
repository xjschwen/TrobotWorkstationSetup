

export GRIP_HOME=/opt/GRIP


export JAVA_HOME=/opt/java/jdk1.8

export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

export PATH=$GRIP_HOME/app:$GRIP_HOME/runtime/lib:$JAVA_HOME:$JAVA_HOME/bin:$LD_LIBRARY_PATH:$PATH

printf "LD_LIBRARY_PATH=%s\n" $LD_LIBRARY_PATH
printf "JAVA_HOME=%s\n" $JAVA_HOME
printf "GRIP_HOME=%s\n" $GRIP_HOME
export java_library_path=$GRIP_HOME/app
java -version

printf "/n/n"

$JAVA_HOME/bin/java -jar -Djava.library.path=${java_library_path} $GRIP_HOME/app/ui-1.1.1.jar 2>/tmp/GRIP.log
