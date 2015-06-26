class AddKarmaPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :karma_points, :integer
  end
end
