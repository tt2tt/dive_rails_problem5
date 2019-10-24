FactoryBot.define do

  factory :task, class: Task  do
    name { 'test_task_01' }
    detail { 'test1' }
  end

  factory :second_task, class: Task do
    name { 'test_task_02' }
    detail { 'sample2' }
  end

  factory :third_task, class: Task do
    name { 'test_task_03' }
    detail { 'mof3' }
  end
end
