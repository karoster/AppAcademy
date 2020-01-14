class AddNotNullConstraintToColumns < ActiveRecord::Migration[6.0]
  def change
    change_column_null :post_subs, :sub_id, false
    change_column_null :post_subs, :post_id, false
  end
end
