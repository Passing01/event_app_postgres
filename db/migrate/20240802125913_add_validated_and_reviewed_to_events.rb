class AddValidatedAndReviewedToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :validated, :boolean, default: false
    add_column :events, :reviewed, :boolean, default: false
  end
end
