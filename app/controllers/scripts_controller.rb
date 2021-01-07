class ScriptsController < ApplicationController
  protect_from_forgery :except => :show
  def show
    app = Manifest.find_by(:name => params[:app])
    dir = nil
    version = nil
    if params[:file] == 'vendors-node_modules_react_index_js'
      dir = 'react'
      version = app.react_version
    elsif params[:file] == 'vendors-node_modules_react-dom_index_js'
      dir = 'react_dom'
      version = app.react_dom_version
    elsif params[:file] == 'vendors-node_modules_fluentui_react_lib_index_js'
      dir = 'fluentui_react'
      version = app.fluent_version
    end
    file = File.join(File.dirname(__FILE__), '..', '..', 'lib', 'assets', dir, version, 'file')
    send_file file, type: 'application/javascript', disposition: 'inline'
  end
end
