# An example 4.x function.
Puppet::Functions.create_function(:func4x) do
  # The first overload.
  # @param param1 The first parameter.
  # @param param2 The second parameter.
  # @param param3 The third parameter.
  # @return Returns nothing.
  dispatch :foo do
    param          'Integer',       :param1
    param          'Any',           :param2
    optional_param 'Array[String]', :param3
    return_type 'Undef'
  end

  # @param param The first parameter.
  # @param block The block parameter.
  # @return Returns a string.
  dispatch :other do
    param 'Boolean', :param
    block_param
    return_type 'String'
  end
end
