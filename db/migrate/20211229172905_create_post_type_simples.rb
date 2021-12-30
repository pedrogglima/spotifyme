# frozen_string_literal: true

class CreatePostTypeSimples < ActiveRecord::Migration[7.0]
  def change
    create_table :post_type_simples do |t|
      t.text :content, null: false

      t.timestamps
    end
  end
end
