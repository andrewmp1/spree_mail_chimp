class NewsLetterSubscriptionsController < Spree::BaseController
  def create
    subscription = NewsletterSubscription.new(:email => params[:email])
    subscription.save
    if subscription.save
      flash[:notice] = "Thanks for signing up."
    else
      flash[:error] = "Couldn't sign you up, #{newsletter_subscription.errors.full_messages.join(', ').downcase}"
    end
    redirect_to :back
  end
end