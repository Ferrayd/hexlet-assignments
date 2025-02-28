namespace :hexlet do
  desc "Import users from CSV file"
  task :import_users, [:file_path] => :environment do |t, args|
    require 'csv'
    
    file_path = args[:file_path]
    unless file_path && File.exist?(file_path)
      puts "File not found: #{file_path}"
      next
    end

    CSV.foreach(file_path, headers: true) do |row|
      user_attrs = row.to_h
      user = User.find_or_initialize_by(email: user_attrs["email"])
      user.assign_attributes(user_attrs)
      user.birthday ||= Date.today
      
      if user.save
        puts "User #{user.email} imported successfully."
      else
        puts "Failed to import user #{user.email}: #{user.errors.full_messages.join(", ")}"
      end
    end
    
    puts "User import completed."
  end
end