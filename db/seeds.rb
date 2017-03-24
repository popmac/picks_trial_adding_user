# development と staging のテーブル群
if Rails.env.development? || Rails.env.staging?
  table_names1 = %w(
    users administrators
  )
  table_names1.each do |table_name|
    path = Rails.root.join('db', 'seeds', 'development', "#{table_name}.rb")
    if File.exist?(path)
      puts "Creating #{table_name}...."
      require(path)
    end
  end
end

# production のテーブル群
if Rails.env.production?
  table_names2 = %w(administrators)
  table_names2.each do |table_name|
    path = Rails.root.join('db', 'seeds', 'production', "#{table_name}.rb")
    if File.exist?(path)
      puts "Creating #{table_name}...."
      require(path)
    end
  end
end
