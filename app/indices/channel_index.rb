ThinkingSphinx::Index.define :channel,  :with => :active_record do
  indexes name
  indexes description
end
