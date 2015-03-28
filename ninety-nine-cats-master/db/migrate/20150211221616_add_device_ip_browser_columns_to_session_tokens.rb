class AddDeviceIpBrowserColumnsToSessionTokens < ActiveRecord::Migration
  def change
    add_column :session_tokens, :device, :string
    add_column :session_tokens, :ip, :string
    add_column :session_tokens, :browser, :string
  end
end
