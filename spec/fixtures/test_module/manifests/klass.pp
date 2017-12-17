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
# @param param3
class klass (
  Variant[Integer, Array[Integer, 1]] $param1,
  $param2,
  String $param3 = 'hi',
  Integer $param4,
) inherits foo::bar {

}
