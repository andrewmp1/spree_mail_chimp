class NewsletterSubscription < ActiveRecord::Base
  after_create :subscribe
  validates_presence_of :email
  validates_uniqueness_of :email
  # MailChimp api gem is hominid
  require 'hominid'
  
  def member_info
     @hominid ||= Hominid::API.new(api_key)
     @hominid.list_member_info(list_id, [email])
     rescue Hominid::APIError => e
       Rails.logger.warn "Could not retrieve member info for #{email}"
  end
  
  def subscribe
     @hominid ||= Hominid::API.new(api_key)
     @hominid.list_subscribe(list_id, email, merge_vars, "html", subscription_opts)
     rescue Hominid::APIError => e
       Rails.logger.warn "Could not subscribe user #{email}"
  end

  def unsubscribe
     @hominid ||= Hominid::API.new(api_key)
     @hominid.list_unsubscribe(list_id, email)
     rescue Hominid::APIError => e
       Rails.logger.warn "Could not unsubscribe user #{email}"
  end
  
  
  private

  def list_id
      Spree::Config.get(:mailchimp_list_id)
  end
  
  def api_key
      Spree::Config.get(:mailchimp_api_key)
  end
  
  def merge_vars
      merge_vars = {}
      if mailchimp_merge_user_attribs = Spree::Config.get(:mailchimp_merge_vars)
        mailchimp_merge_user_attribs.split(',').each do |meth|
          merge_vars[meth.upcase] = @user.send(meth.downcase) if @user.respond_to? meth.downcase
        end
      end
      merge_vars
  end

  def subscription_opts
      options = {}
      [:mailchimp_double_opt_in, :mailchimp_send_welcome, :mailchimp_send_notify].each do |opt|
          options[opt.to_s.gsub(/^mailchimp_/,'')] = Spree::Config.get(opt)
      end
      options
  end
    
end