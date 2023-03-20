- [Creating user, database and adding access on PostgreSQL](https://medium.com/coding-blocks/creating-user-database-and-adding-access-on-postgresql-8bfcd2f4a91e)
- [Quickstart Debian or Ubuntu](https://www.chirpstack.io/project/guides/debian-ubuntu/)
- [PostgreSQL in ChirpStack](https://www.chirpstack.io/application-server/integrations/postgresql/)
- [Connecting a Gateway](https://www.chirpstack.io/project/guides/connect-gateway/)

```bash
sudo apt install mosquitto mosquitto-clients redis-server redis-tools postgresql 
```

```sql
DROP DATABASE chirpstack_as;
DROP DATABASE chirpstack_ns;
-- set up the users and the passwords
-- (note that it is important to use single quotes and a semicolon at the end!)
create role chirpstack_as with login password 'dbpassword';
create role chirpstack_ns with login password 'dbpassword';

-- create the database for the servers
create database chirpstack_as with owner chirpstack_as;
create database chirpstack_ns with owner chirpstack_ns;

-- change to the ChirpStack Application Server database
\c chirpstack_as
-- https://forum.chirpstack.io/t/release-lora-app-server-0-19-0/1089
-- enable the pq_trgm and hstore extensions
-- (this is needed to facilitate the search feature)
create extension pg_trgm;
-- (this is needed to store additional k/v meta-data)
create extension hstore;
-- exit psql
\q
```

```bash
# NO NEED. I'M DUMB
sudo -u postgres createuser chirpstack
# sudo -u postgres createdb chirpstack_as
# sudo -u postgres createdb chirpstack_ns
sudo -u postgres psql
```

```sql
-- NO NEED. I'M DUMB
-- alter password... needs semicolon.
alter user chirpstack with encrypted password '<password>';
-- or use 
\password chirpstack

grant all privileges on database chirpstack_as to chirpstack;
grant all privileges on database chirpstack_as to chirpstack_as;
grant all privileges on database chirpstack_ns to chirpstack;
grant all privileges on database chirpstack_ns to chirpstack_ns;
```

```bash
# see also init_sql.sql
# No need to import this...or I would dump a new one
psql -U chirpstack_as -d chirpstack_as -a -f ./init_sql.sql
# pg_restore -U chirpstack -d chirpstack_as --clean ./init_sql.sql
```

`/etc/chirpstack-application-server/chirpstack-application-server.toml`

```toml
[postgresql]
dsn="postgres://chirpstack_as:dbpassword@localhost/chirpstack_as?sslmode=disable"
[redis]
url="redis://localhost:6379"

# openssl rand -base64 32
# MUST BE SET
jwt_secret="A8hlyiAj4H05bAcW5WeYthnrMAOzPpLTI4YA9YGlR4s="
```

## Connect Gateway

See [Connecting a Gateway](https://www.chirpstack.io/project/guides/connect-gateway/). You have to set the gateway ID.
Pick the correct configuration file for your gateway.

See `/etc/chirpstack-application-server`, `/etc/chirpstack-network-server` and `/etc/chirpstack-gateway-bridge` for more configuration files.

## [API](https://www.chirpstack.io/application-server/api/)

`http://cross-firefly.local:8080/api`. Note without the final `/` or it would just say `not found`.
