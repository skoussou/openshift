echo "tar xvf /tmp/apache-maven-3.3.9-bin.tar.gz"
tar xvf /tmp/apache-maven-3.3.9-bin.tar.gz
echo "mv apache-maven-3.3.9  /usr/local/apache-maven"
mv apache-maven-3.3.9  /usr/local/apache-maven
# Add the env variables to your ~/.bashrc file
echo "vi ~/.bashrc"
vi ~/.bashrc
echo "export M2_HOME=/usr/local/apache-maven"
export M2_HOME=/usr/local/apache-maven
echo "export M2=$M2_HOME/bin"
export M2=$M2_HOME/bin 
echo "export PATH=$M2:$PATH"
export PATH=$M2:$PATH
# Execute these commands
echo 'source ~/.bashrc'
source ~/.bashrc
