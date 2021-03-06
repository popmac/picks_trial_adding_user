# 前回のシードの画像を削除
require 'fileutils'
Dir.chdir 'public/uploads/user/avatar'
FileUtils.rm(Dir.glob('*.*'))

image_path = File.join(Rails.root, "db/fixtures/images/sample-avatar.png")

User.create!(
  email: 'test1@example.com',
  password: 'password',
  family_name: '山田',
  given_name: '太郎',
  family_name_kana: 'ヤマダ',
  given_name_kana: 'タロウ',
  avatar: File.new(image_path),
  birthday: '2017-03-20',
  gender: 0,
  company: 'テスト会社',
  department:'テスト部',
  official_position: 'テスト長'
)

family_names = %w{
  佐藤:サトウ:sato
  鈴木:スズキ:suzuki
  高橋:タカハシ:takahashi
  田中:タナカ:tanaka
}

given_names = %w{
  二郎:ジロウ:jiro
  三郎:サブロウ:saburo
  松子:マツコ:matsuko
  竹子:タケコ:takeko
  梅子:ウメコ:umeko
}

1.times do |n|
  fn = family_names[n % 4].split(':')
  gn = given_names[n % 5].split(':')

  User.create!(
    email: "test#{n + 2}@example.com",
    password: 'password',
    family_name: fn[0],
    given_name: gn[0],
    family_name_kana: fn[1],
    given_name_kana: gn[1],
    avatar: File.new(image_path),
    birthday: '2017-03-20',
    gender: 0,
    company: 'テスト会社',
    department:'テスト部',
    official_position: 'テスト長',
    suspended: n == 0,
  )
end
