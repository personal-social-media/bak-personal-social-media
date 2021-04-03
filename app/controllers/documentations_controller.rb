# frozen_string_literal: true

class DocumentationsController < ActionController::Base
  layout "documentation"
  before_action :set_navbar
  before_action :require_current_documentation, only: :show

  def index
    @title = "Documentation"
  end

  def show
    @doc = current_documentation.deep_symbolize_keys
  end

  def files_tree
    files = Dir.glob("spec/documentation/**/*").map do |f|
      {
        name: f.sub("spec/documentation/", ""),
        content: File.file?(f) ? JSON.parse(File.read(f)) : ""
      }
    end

    files.group_by do |f|
      f[:name].split("/").first
    end
  end

  def set_navbar
    f = files_tree
    @internal_usage_files_tree = f.select do |_, files|
      files[1].dig(:content, "parent", "usage") == "internal"
    end

    @external_usage_files_tree = f.select do |_, files|
      files[1].dig(:content, "parent", "usage") == "external"
    end
  end

  def current_documentation
    return @current_documentation if defined? @current_documentation

    path = "spec/documentation/#{params[:id]}/#{params[:file_name]}.json"
    return @current_documentation = nil unless File.exist?(path)
    JSON.parse(File.read(path))
  end

  def require_current_documentation
    render "documentations/not_found" if current_documentation.blank?
  end
end
