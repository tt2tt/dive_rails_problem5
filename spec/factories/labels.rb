FactoryBot.define do
  factory :label,  class: Label do
    name { "プログラミング" }
  end

  factory :second_label,  class: Label do
    name { "トレーニング" }
  end
end
