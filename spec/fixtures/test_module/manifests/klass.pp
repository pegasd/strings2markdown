# A simple class.
#
# Use it to do stuff.
#
# @example Basic klass sample
#   class { 'klass':
#     param1 => 5,
#     param2 => 'booyah',
#     param3 => 'hello',
#     param4 => 1,
#   }
#
# @param param1 First param.
# @param param2 Second param.
class klass (Integer $param1, $param2) inherits foo::bar { }
