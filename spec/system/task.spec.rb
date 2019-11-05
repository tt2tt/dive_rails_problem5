require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    user = FactoryBot.create(:user)

    FactoryBot.create(:task, user: user)
    FactoryBot.create(:second_task, user: user)
    FactoryBot.create(:third_task, user: user)
    FactoryBot.create(:forth_task, user: user)
    FactoryBot.create(:fifth_task, user: user)

    visit new_session_path
    fill_in 'メールアドレス', with: 'aaa@aaa.com'
    fill_in 'パスワード', with: 'A' * 6
    click_button 'user_login'
  end

  scenario 'タスク一覧' do
    visit tasks_path

    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'test_task_02'
    expect(page).to have_content 'test_task_03'
  end

  scenario 'タスク作成' do
    visit new_task_path

    fill_in 'タスク名', with: '買い物に行く'
    fill_in 'タスク詳細', with: '午後7時にスーパーでカレーの材料を買う'

    click_button 'task_save'

    visit tasks_path

    expect(page).to have_content '買い物に行く'
  end

  scenario 'タスク詳細' do
    visit tasks_path(id: 1)

    expect(page).to have_content 'test_task_01'
  end

  scenario 'タスクが作成日時の降順に並んでいる' do
    visit tasks_path

    first_task = all('.tasks .task')[0]
    fifth_task = all('.tasks .task')[4]

    expect(first_task).to have_content 'test_task_04'
    expect(fifth_task).to have_content 'test_task_01'
  end

  scenario 'タスクが終了期限によって昇順に並び変えられる' do
    visit tasks_path(sort_expired: "true")

    first_task = all('.tasks .task')[0]
    fifth_task = all('.tasks .task')[4]

    expect(first_task).to have_content 'test_task_04'
    expect(fifth_task).to have_content 'test_task_03'
  end

  scenario 'タスクが優先度によって降順に並び変えられる' do
      visit tasks_path(sort_priority: "true")

      first_task = all('.tasks .task')[0]
      fifth_task = all('.tasks .task')[4]

      expect(first_task).to have_content 'test_task_04'
      expect(fifth_task).to have_content 'test_task_01'
  end

  scenario 'タスクを検索できる' do
    visit tasks_path

    fill_in 'タスク名', with: 'test_task_04'
    select "完了", from: "task[status]"

    click_on "検索"

    expect(page).to have_content 'test_task_04'
  end

end
