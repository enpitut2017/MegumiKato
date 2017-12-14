class AddAccessesToSocialProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :social_profiles, :access_token, :string
    add_column :social_profiles, :access_secret, :string
  end
end
