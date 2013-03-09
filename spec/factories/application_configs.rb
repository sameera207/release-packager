# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :application_config do
    name "sample config"
    git_repo_path Rails.root.join('spec', 'support', 'git-repo')
    package_type "zip"
  end
  
  factory :invalid_application_config, parent: :application_config do |f|
    f.name nil
  end
  
end
