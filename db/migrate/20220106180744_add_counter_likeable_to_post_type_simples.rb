class AddCounterLikeableToPostTypeSimples < ActiveRecord::Migration[7.0]
  def change
    add_column :post_type_simples, :counter_likeable, :integer, default: 0
  end
end
