require 'uri'
require 'cgi'
require 'net/http'
require 'json'
require 'typhoeus'
require_relative 'canvas-api/api'
require_relative 'canvas-api/api_error'
require_relative 'canvas-api/pair_array'
require_relative 'canvas-api/result_set'

module Canvas
end

# TODO: this is a hack that digs into the bowels of typhoeus
module Ethon
  class Easy
    module Queryable
      def recursively_generate_pairs(h, prefix, pairs)
        case h
        when Hash
          h.each_pair do |k,v|
            key = prefix.nil? ? k : "#{prefix}[#{k}]"
            pairs_for(v, key, pairs)
          end
        when Canvas::PairArray
          h.each do |k, v|
            key = prefix.nil? ? k : "#{prefix}[#{k}]"
            pairs_for(v, key, pairs)
          end
        when Array
          h.each_with_index do |v, i|
            key = "#{prefix}[#{i}]"
            pairs_for(v, key, pairs)
          end
        end
      end
    end
  end
end
