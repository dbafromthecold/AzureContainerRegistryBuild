
FROM microsoft/mssql-server-linux:latest


RUN mkdir /var/opt/sqlserver


COPY TestDatabase.mdf /var/opt/sqlserver
COPY TestDatabase_log.ldf /var/opt/sqlserver


ENV ACCEPT_EULA=Y


HEALTHCHECK --interval=10s  \
	CMD /opt/mssql/bin/sqlservr & \
	/opt/mssql-tools/bin/sqlcmd -S . -U sa -P $SA_PASSWORD \
		-Q "CREATE DATABASE [TestDatabase] ON (FILENAME = '/var/opt/sqlserver/TestDatabase.mdf'),(FILENAME = '/var/opt/sqlserver/TestDatabase_log.ldf') FOR ATTACH"