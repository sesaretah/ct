class AddValueToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :rank_value, :integer
  end
end
