ThinkingSphinx::Index.define :channel,  :with => :active_record, :delta => true do
  indexes name
  indexes description
end
