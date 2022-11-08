# frozen_string_literal: true

require 'digest'

unless String.method_defined? "to_boolean"
  class String
    # converts a string to 'boolean'
    # @return [Boolean] bool
    def to_boolean
      ['true','1'].include? self.downcase
    end
  end
end

unless String.method_defined? "to_md5"
  class String
    # returns the md5 of this string
    # @return [String] md5
    def to_md5
      ::Digest::MD5.hexdigest(self)
    end
  end
end