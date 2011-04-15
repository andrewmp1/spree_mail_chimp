require 'spree_core'
require 'spree_mail_chimp_hooks'

module SpreeMailChimp
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      
      AppConfiguration.class_eval do
          preference :mailchimp_double_opt_in, :boolean, :default => false
          preference :mailchimp_send_welcome, :boolean, :default => false
          preference :mailchimp_send_notify, :boolean, :default => false
          preference :mailchimp_merge_vars, :string, :default => ''
          preference :mailchimp_list_id, :string
          preference :mailchimp_api_key, :string
      end
    end
    
    

    config.to_prepare &method(:activate).to_proc
  end
end
