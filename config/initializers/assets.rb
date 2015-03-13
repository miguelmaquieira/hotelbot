# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( search_box.js registration_wizard.js )
Rails.application.config.controllers_with_assets = %w( hotels home profile )
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/

Rails.application.config.controllers_with_assets.each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.js", "#{controller}.css"]
end

Rails.application.config.controller_views_with_assets = %w( )

Rails.application.config.controller_views_with_assets.each do |view|
  Rails.application.config.assets.precompile += ["#{view}.js", "#{view}.css"]
end
