# frozen_string_literal: true

unless Object.method_defined? "numeric?"
  class Object
    # returns true if this object is a numeric or a kind of numeric
    # @return [Boolean] numeric
    def numeric?
      return true if self.is_a?(Numeric)
      return true if self.to_s =~ /\A\d+\Z/
      return true if Float(self) rescue false

      false
    end
  end
end

unless Object.method_defined? "boolean?"
  class Object
    # return true if object is a boolean class (TrueClass or FalseClass)
    # @return [Boolean] boolean
    def boolean?
      self.is_a?(TrueClass) || self.is_a?(FalseClass)
    end
  end
end

unless Object.method_defined? "missing_method?"
  class Object
    # returns true if method is missing.
    # the second optional parameter <tt>check_ancestors</tt> prevents to check it's ancestors by providing a *false* value
    # @param [Symbol] name - the method's name to check
    # @param [Boolean] check_ancestors - check class ancestors (default: true)
    # @return [Boolean] missing_method
    def missing_method?(name, check_ancestors = true)
      !self.instance_methods(check_ancestors).include?(name)
    end
  end
end

unless Object.method_defined? "alias_missing_method"
  class Object
    # creates an alias for provided method if it's missing.
    # the third optional parameter <tt>check_ancestors</tt> prevents to check it's ancestors by providing a *false* value
    # @param [Symbol] new - new method name
    # @param [Symbol] old - old method name
    # @param [Boolean] check_ancestors - check class ancestors (default: true)
    def alias_missing_method(new, old, check_ancestors = true)
      alias_method(new, old) if missing_method?(new, check_ancestors)
    end
  end
end