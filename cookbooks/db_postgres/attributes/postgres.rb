#
# Cookbook Name:: db_postgres
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

# Recommended attributes
#
set_unless[:db_postgres][:server_usage] = "dedicated"  # or "shared"
set_unless[:db_postgres][:previous_master] = nil


# Optional attributes
#
set_unless[:db_postgres][:port] = "5432"

set_unless[:db_postgres][:tmpdir] = "/tmp"
set_unless[:db_postgres][:datadir] = "/var/lib/pgsql/9.1/data"
set_unless[:db_postgres][:confdir] = "/var/lib/pgsql/9.1/data"
set_unless[:db_postgres][:ident_file] = ""
set_unless[:db_postgres][:pid_file] = ""
set_unless[:db_postgres][:datadir_relocate] = "/mnt/storage"
set_unless[:db_postgres][:bind_address] = cloud[:private_ips][0]

# Platform specific attributes

case platform
when "redhat","centos","fedora","suse"
  set[:db_postgres][:socket] = "/var/run/postgresql"
  set_unless[:db_postgres][:basedir] = "/var/lib/pgsql/9.1"
  set_unless[:db_postgres][:confdir] = "/var/lib/pgsql/9.1/data"
  set_unless[:db_postgres][:packages_uninstall] = ""
  set_unless[:db_postgres][:client_packages_install] = ["postgresql91-libs", "postgresql91", "postgresql91-devel" ] 
  set_unless[:db_postgres][:server_packages_install] = ["postgresql91-libs", "postgresql91", "postgresql91-devel", "postgresql91-server", "postgresql91-contrib" ]
  set_unless[:db_postgres][:log] = ""
  set_unless[:db_postgres][:log_error] = ""
when "debian","ubuntu"
  set[:db_postgres][:socket] = "/var/run/postgresql"
  set_unless[:db_postgres][:basedir] = "/var/lib/pgsql/9.1"
  set_unless[:db_postgres][:confdir] = "/etc/postgresql/9.1/main"
  set_unless[:db_postgres][:packages_uninstall] = ""
  if(platform_version == "10.10" || platform_version == "10.04")
    set_unless[:db_postgres][:packages_install] = ["mysql-server-5.1", ""]
  else
    set_unless[:db_postgres][:packages_install] = ["mysql-server-5.0", ""]
  end
  set_unless[:db_postgres][:log] = "log = /var/log/mysql.log"
  set_unless[:db_postgres][:log_error] = "log_error = /var/log/mysql.err"
else
  set[:db_postgres][:socket] = "/var/run/postgresql"
  set_unless[:db_postgres][:basedir] = "/var/lib/pgsql/9.1"
  set_unless[:db_postgres][:packages_uninstall] = ""
  set_unless[:db_postgres][:packages_install] = ["postgresql91-server"]
  set_unless[:db_postgres][:log] = "log = /var/log/postgresql"
  set_unless[:db_postgres][:log_error] = "log_error = /var/log/postgresql"
end

