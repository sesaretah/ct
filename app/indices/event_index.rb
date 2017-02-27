ThinkingSphinx::Index.define :event,  :with => :active_record do
  indexes name
  indexes description
end
