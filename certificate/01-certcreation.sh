#Step 0 - cleanup older certificate
#rm certs/*.*
#Step 1 - Create the Root SSL Certificate (Enter passphrase)
echo "Step 1 - Create the Root SSL Certificate (Enter passphrase)"
openssl genrsa -des3 -out certs/rootCA.key 2048

#Step 2 - Create the root CA certificate using the generated key
openssl req -x509 -new -nodes -key certs/rootCA.key -sha256 -days 1460 -out certs/rootCA.pem -config server.csr.cnf

#Example values : /C=US/ST=MA/L=Hopkinton/O=Dell/OU=UDS/CN=HAProxy Root CA/emailAddress=admin@admin.local

#Step 3 - Add the Root SSL certificate to the Windows Trust store (You can allso add it through Certmgr.msc).
#certutil -addstore -f "ROOT" rootCA.pem

#Step 4 - Generate an SSL Client certificate and sign it using the Root CA
#Step 4.1 - Create the private key and CSR for thge client certificate
openssl req -new -sha256 -nodes -out certs/server.csr -newkey rsa:2048 -keyout certs/server.key -config server.csr.cnf

#Step 4.2 - Create the Client certificate usng the Root CA and CSR (enter passphrase the Root CA from Step 1)
openssl x509 -req -in certs/server.csr -CA certs/rootCA.pem -CAkey certs/rootCA.key -CAcreateserial -out certs/server.crt -days 1460 -sha256 -extfile v3.ext

#Step 5 - Combine the Client certificate and key for HAProxy
cat certs/server.key certs/server.crt > certs/combined.pem
clear
echo "Use 'certs/combined.pem' on ECS laodbalancer"
echo "Use 'certs/rootCA.pem' on windows or container with SQL Server"

