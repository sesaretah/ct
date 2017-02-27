ThinkingSphinx::Index.define :good,  :with => :active_record do
  indexes name
  indexes description
  has sub_category_id
end
