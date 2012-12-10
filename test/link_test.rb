Bundler.require :default, :development

require 'minitest/unit'
require 'minitest/autorun'

class LinkTest < MiniTest::Unit::TestCase

  def test_to_s
    tag = Rack::CurrentPage::Link.new %q{<a href="/foo.html">}
    assert_equal %q{<a href="/foo.html">}, tag.to_s
  end

  def test_already_tagged
    tag = Rack::CurrentPage::Link.new %q{<a href="/foo.html" class="current">}
    tag.append_class! 'current'
    assert_equal %q{<a href="/foo.html" class="current">}, tag.to_s
  end

  def test_no_class_attribute
    tag = Rack::CurrentPage::Link.new %q{<a href="/foo.html">}
    tag.append_class! 'current'
    assert_equal %q{<a class="current" href="/foo.html">}, tag.to_s
  end

  def test_existing_class_attribute
    tag = Rack::CurrentPage::Link.new %q{<a href="/foo.html" class="another">}
    tag.append_class! 'current'
    assert_equal %q{<a href="/foo.html" class="current another">}, tag.to_s
  end

  def test_points_to?
    tag = Rack::CurrentPage::Link.new %q{<a href="/foo/index.html?bar=baz">}
    assert !tag.points_to?('/index.html')
    assert !tag.points_to?('/foo/index.html')
    assert tag.points_to?('/foo/index.html?bar=baz')

    tag = Rack::CurrentPage::Link.new %q{<a href="http://example.com:3000/foo/index.html?bar=baz">}
    assert tag.points_to?('/foo/index.html?bar=baz')
  end

end
