class RenamePostcodeToPostCode < ActiveRecord::Migration[7.0]
  def change
    rename_column :information, :postcode, :post_code
  end
end
