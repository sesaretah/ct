class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :course_type
      t.string :course_field
      t.string :course_grade
      t.integer :course_points
      t.integer :lecturer_id
      t.text :course_targets
      t.text :course_results
      t.text :course_covered
      t.string :course_softwares
      t.string :problems_period
      t.string :garding_mechanism

      t.timestamps null: false
    end
  end
end
