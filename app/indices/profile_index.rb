ThinkingSphinx::Index.define :profile,  :with => :active_record do
  indexes name
  indexes surename
end
