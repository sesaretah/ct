ThinkingSphinx::Index.define :group,  :with => :active_record, :delta => true do
  indexes name
  indexes description
end
