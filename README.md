# ssh_remote.it
easy way from a Linux console to setup a remote.it proxy connection.

# Setup

First step is to add your username and password to a config file
command:
echo 'USERNAME="yourname@something"'>config
echo 'PASSWORD="yourpassword"'>config

You also want to get your unique Developer API Key from the https://app.remote.it/#account
command:
echo 'DEVKEY="YourUniqueDeveloperAPIKey"'>config

Next you will need to be authenticated and generate a log on token.
command:
./authentication.sh

Now let's see what is active for your devices. 
command:
./device_list.sh

So with the active(green) device get the DeviceAddress should look like an odd MAC address.
command:
./connection_setup.sh "00:00...:00"

Lastly you can connection to your device.
command:
./connect.sh
