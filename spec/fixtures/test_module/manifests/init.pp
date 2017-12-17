# Manage cron on the host.
#
# @summary Main entry point.
#
# @see https://crontab.guru/
#
# @example Declaring cron class
#   include cron
#
# @param purge_cron Whether to purge unmanaged cron resources.
class cron(
  Boolean $purge_cron = true,
) { }
