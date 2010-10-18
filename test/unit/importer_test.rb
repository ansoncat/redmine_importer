require File.dirname(__FILE__) + '/../test_helper'

class ImporterTest < ActiveSupport::TestCase
  include ActionController::TestProcess
  
  def setup
    @project      ||= Project.generate!(:name => 'Test Project', :identifier => 'testproject')
    @request        = ActionController::TestRequest.new
    @response       = ActionController::TestResponse.new
    @controller     = ImporterController.new
    @fixture_file ||= fixture_file_upload("/test_issues.csv", "text/csv")
  end
  
  def upload_file
    post :match,
      :project_id => @project.id,
      :file => @fixture_file,
      :splitter => ",",
      :wrapper => "\"",
      :encoding => "U"
  end
  
  context "#match" do
    
    should "accept file uploads" do
      upload_file
      assert_equal "200 OK", @response.status
    end

    should "error when missing project_id" do
      post :match,
        :file => @fixture_file,
        :splitter => ",",
        :wrapper => "\"",
        :encoding => "U"
      assert_equal "404 Not Found", @response.status
    end

    should "error when missing file" do
      post :match,
        :project_id => @project.id,
        :splitter => ",",
        :wrapper => "\"",
        :encoding => "U"
      assert_equal "200 OK", @response.status
    end

    should "not error when missing splitter" do
      post :match,
        :project_id => @project.id,
        :file => @fixture_file,
        :wrapper => "\"",
        :encoding => "U"
      assert_equal "200 OK", @response.status
    end

    should "not error when missing wrapper" do
      post :match,
        :project_id => @project.id,
        :file => @fixture_file,
        :splitter => ",",
        :encoding => "U"
      assert_equal "200 OK", @response.status
    end

    should "not error when missing encoding" do
      post :match,
        :project_id => @project.id,
        :file => @fixture_file,
        :splitter => ",",
        :wrapper => "\""
      assert_equal "200 OK", @response.status
    end

  end
end
