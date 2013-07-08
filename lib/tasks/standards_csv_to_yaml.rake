require 'csv'

namespace :admin  do
  desc "Update the types of all the Resources."
  task :standards_csv_to_yaml, [:csv_file, :yaml_file] => [:environment] do |t, args|

  end
end