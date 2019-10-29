FactoryBot.define do

  factory :task, class: Task  do
    name { 'test_task_01' }
    detail { 'test1' }
    deadline {'2014-10-28 07:24:00'}
  end

  factory :second_task, class: Task do
    name { 'test_task_02' }
    detail { 'sample2' }
    deadline {'2015-10-28 07:24:00'}
  end

  factory :third_task, class: Task do
    name { 'test_task_03' }
    detail { 'mof3' }
    deadline { '2016-10-28 07:24:00' }
  end

  factory :forth_task, class: Task  do
    name { 'test_task_04' }
    detail { 'manyou4' }
    deadline {'2014-10-28 07:22:00'}
  end
end
