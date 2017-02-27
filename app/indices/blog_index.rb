ThinkingSphinx::Index.define :blog,  :with => :active_record do
  indexes title
  indexes description
end
