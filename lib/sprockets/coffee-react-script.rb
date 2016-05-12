require 'sprockets'
require 'tilt'
require 'coffee-react'
require 'coffee_script'

module Sprockets
  # Preprocessor that runs CJSX source files through coffee-react-transform
  # then compiles with coffee-script
  class CoffeeReactScript < Tilt::Template
    CJSX_EXTENSION = /\.cjsx[^\/]*?$/

    def prepare
    end

    def evaluate(scope, locals, &block)
      if scope.pathname.to_s =~ /\.coffee\.cjsx/
        ::CoffeeReact.transform(data)
      elsif scope.pathname.to_s =~ CJSX_EXTENSION
        ::CoffeeScript.compile(::CoffeeReact.transform(data))
      else
        data
      end
    end

  end
end
