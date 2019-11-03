FactoryBot.define do

  factory :task, class: Task  do
    name { 'test_task_01' }
    detail { 'test1' }
    deadline {'2014-10-28 07:24:00'}
    status { '未着手' }
    priority { '低' }
  end

  factory :second_task, class: Task do
    name { 'test_task_02' }
    detail { 'sample2' }
    deadline {'2015-10-28 07:24:00'}
    status { '着手中' }
    priority { '中' }
  end

  factory :third_task, class: Task do
    name { 'test_task_03' }
    detail { 'mof3' }
    deadline { '2016-10-28 07:24:00' }
    status { '完了' }
    priority { '中' }
  end

  factory :forth_task, class: Task  do
    name { 'test_task_04' }
    detail { 'manyou4' }
    deadline {'2014-10-28 07:22:00'}
    status { '完了' }
    priority { '高'  }
  end

  factory :fifth_task, class: Task  do
    name { 'test_task_04' }
    detail { 'manyou4' }
    deadline {'2015-10-28 07:22:00'}
    status { '着手中' }
    priority { '高'  }
  end
end
