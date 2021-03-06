# module for validating array and integers
module Cumulus
  # module for utils
  module Utils
    # helps set parameter type to integer`
    def munge_integer(value)
      Integer(value)
    rescue ArgumentError
      raise('munge_integer only takes integers')
    end

    def munge_array(value)
      return_value = value
      msg = 'should be array not comma separated string'
      if value.class == String
        fail ArgumentError msg if value.include?(',')
        return_value = [value]
      end
      fail ArgumentError 'should be array' if return_value.class != Array
      return_value
    end

    def validate_on_off(value)
      ok_values = ['on', 'off']
      if not ok_values.include? value
        raise("value must be one of #{ok_values}")
      end
    end

    def validate_no(value)
      if value != 'no'
        raise("value must be 'no'")
      end
    end
  end
end
