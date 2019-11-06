FactoryBot.define do
  factory :user, class: User do
    name {"AAA"}
    email {"aaa@aaa.com"}
    password {'AAAAAA'}
    password_confirmation {'AAAAAA'}
  end

  factory :second_user, class: User do
    name {"BBB"}
    email  {"bbb@bbb.com"}
    password {'BBBBBB'}
    password_confirmation {'BBBBBB'}
  end

  factory :admin_user, class: User do
    name {"admin"}
    email {"admin@admin.com"}
    password {'adminadmin'}
    password_confirmation {'adminadmin'}
    admin {true}
  end

end
