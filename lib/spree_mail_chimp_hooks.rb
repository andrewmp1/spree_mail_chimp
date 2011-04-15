class SpreeMailChimpHooks < Spree::ThemeSupport::HookListener
  	insert_after :signup_below_password_fields, 'users/subscribe_to_newsletter'

    insert_after :admin_configurations_menu do
          %[
            <tr>
              <td><%= link_to t("mailchimp_settings"), admin_mail_chimp_settings_path %></td>
              <td><%= t("mailchimp_settings_description") %></td>
            </tr>
          ] 
    end

end