class AddPriceToEvents < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:events, :price)
      add_column :events, :price, :integer
    end
  end
end
