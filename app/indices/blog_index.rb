ThinkingSphinx::Index.define :blog,  :with => :active_record, :delta => true do
  indexes title
  indexes description
end
