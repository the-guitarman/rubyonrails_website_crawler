# config/initializers/locale.rb

# Where the I18n library should search for translation files
#I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]

# Permitted locales available for the application
I18n.available_locales = [:en, :de]

# Set default locale to something other than :en
if (Rails.env.test?)
  I18n.default_locale = :en
else
  I18n.default_locale = :de
end

#I18n.load_path                 # Announce your custom translation files
#I18n.locale                    # Get and set the current locale
#I18n.default_locale            # Get and set the default locale
#I18n.available_locales         # Permitted locales available for the application
#I18n.enforce_available_locales # Enforce locale permission (true or false)
#I18n.exception_handler         # Use a different exception_handler
#I18n.backend                   # Use a different backend
