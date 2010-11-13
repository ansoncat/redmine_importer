require File.dirname(__FILE__) + '/../test_helper'

# Author: Greg Mefford (@ferggo)
# Some simple tests for the Redmine Importer plugin
class ImporterTest < ActiveSupport::TestCase
  include ActionController::TestProcess
  
  def setup
    @project      ||= Project.generate!(
                        :name => 'Test Project',
                        :identifier => 'testproject')
    @request        = ActionController::TestRequest.new
    @response       = ActionController::TestResponse.new
    @controller     = ImporterController.new
    @fixture_file ||= fixture_file_upload("/test_issues.csv", "text/csv")
    @post_options   = {
      :project_id => @project.id,
      :file => @fixture_file,
      :splitter => ",",
      :wrapper => "\"",
      :encoding => "U"
    }
  end
  
  context "#match" do
    
    should "accept file uploads" do
      post :match, @post_options
      assert_equal "200 OK", @response.status
    end

    should "not error when missing project_id" do
      options = @post_options.dup
      options.delete(:project_id)
      post :match, options
      assert_equal "200 OK", @response.status
    end

    should "not error when missing file" do
      options = @post_options.dup
      options.delete(:file)
      post :match, options
      assert_equal "200 OK", @response.status
    end

    should "not error when missing splitter" do
      options = @post_options.dup
      options.delete(:splitter)
      post :match, options
      assert_equal "200 OK", @response.status
    end

    should "not error when missing wrapper" do
      options = @post_options.dup
      options.delete(:wrapper)
      post :match, options
      assert_equal "200 OK", @response.status
    end

    should "not error when missing encoding" do
      options = @post_options.dup
      options.delete(:wrapper)
      post :match, options
      assert_equal "200 OK", @response.status
    end

  end
end
