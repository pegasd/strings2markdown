# Cron class
#
# @see https://crontab.guru/
#
# @api private
#
# @example Declaring cron class
#   include cron
#
# @param purge_cron Whether to purge unmanaged cron resources.
class cron(
  Boolean $purge_cron = true,
) { }
