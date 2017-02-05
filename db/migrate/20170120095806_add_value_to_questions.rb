class AddValueToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :rank_value, :integer
  end
end
