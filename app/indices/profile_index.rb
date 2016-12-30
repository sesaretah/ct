ThinkingSphinx::Index.define :profile,  :with => :active_record, :delta => true do
  indexes name
  indexes surename
end
