ThinkingSphinx::Index.define :good,  :with => :active_record, :delta => true do
  indexes name
  indexes description
  has sub_category_id
end
