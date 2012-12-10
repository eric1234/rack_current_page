Bundler.require :default, :development

require 'rack/builder'
require 'rack/mock'

require 'minitest/unit'
require 'minitest/autorun'

class MiddlewareTest < MiniTest::Unit::TestCase

  def test_call
    app = Rack::Builder.new do
      use Rack::CurrentPage
      run proc {|env| [200, {}, [%q{
Some text
<a href="/foo.html?baz=boo">Current link</a>
<a href="/foo.html">Close</a>
<a href="/bar.html">Different link</a>
More text
      }]]}
    end.to_app
    mock = Rack::MockRequest.new app
    assert_equal %q{
Some text
<a class="current" href="/foo.html?baz=boo">Current link</a>
<a href="/foo.html">Close</a>
<a href="/bar.html">Different link</a>
More text
    }.strip, mock.get('/foo.html?baz=boo').body.strip    
  end
end
