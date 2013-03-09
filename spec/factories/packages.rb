# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :package do
    commit_id "a82ce76a28c04c9cee3897274c0d6a248303165c11"
    name "sample package"
    package_path "/"
  end
  
  factory :package2, :parent => :package do
    commit_id "a82ce76a28c04c9cee3897274c0d6a248303112122"
    name "old package"
    created_at 10.days.ago 
  end
  
end
