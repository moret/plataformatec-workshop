class AddGeocodeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :location, :string
    add_column :posts, :lat, :float
    add_column :posts, :lng, :float
  end
end
