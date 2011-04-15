UserRegistrationsController.class_eval do
    after_filter :add_newsletter_subscription, :only => [:create, :new]

    def add_newsletter_subscription
      if params["subscription"] == "1"
        subscription = NewsletterSubscription.new(:email => @user.email)
        subscription.save
        if !subscription.save
          logger.warn "Couldn't sign #{@user.email} for newsletter"
        end
      end
    end

    # TODO  need to add some sort of filter on userRegistrationsController.update to update newsletter subscription
  
  
  
end