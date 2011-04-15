class CreateNewsletterSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :newsletter_subscriptions do |t|
      t.timestamps
      t.string :email
    end
  end

  def self.down
    drop_table :newsletter_subscriptions
  end
end
