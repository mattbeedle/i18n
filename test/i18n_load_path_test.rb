# encoding: utf-8
$:.unshift File.expand_path(File.dirname(__FILE__) + '/')
require 'test_helper'

class I18nLoadPathTest < Test::Unit::TestCase
  # include Tests::Backend::Simple::Setup::Base
  
  def setup
    I18n.locale = :en
    I18n.backend = I18n::Backend::Simple.new
    store_translations(:en, :foo => {:bar => 'bar', :baz => 'baz'})
  end

  def test_nested_load_paths_do_not_break_locale_loading
    I18n.load_path = [[locales_dir + '/en.yml']]
    assert_equal "baz", I18n.t(:'foo.bar')
  end

  def test_load_empty_yml_raises_an_error
    assert_raise I18n::InvalidLocaleData do
      I18n.load_path = [[locales_dir + '/invalid/empty.yml']]
      I18n.t(:'foo.bar', :default => "baz")
    end
  end

  def test_adding_arrays_of_filenames_to_load_path_do_not_break_locale_loading
    I18n.load_path << Dir[locales_dir + '/*.{rb,yml}']
    assert_equal "baz", I18n.t(:'foo.bar')
  end
end
