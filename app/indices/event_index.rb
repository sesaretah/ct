ThinkingSphinx::Index.define :event,  :with => :active_record, :delta => true do
  indexes name
  indexes description
end
