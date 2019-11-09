require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    user = FactoryBot.create(:user)

    FactoryBot.create(:task, user: user)
    FactoryBot.create(:second_task, user: user)
    task1 =FactoryBot.create(:third_task, user: user)
    task2 = FactoryBot.create(:forth_task, user: user)
    FactoryBot.create(:fifth_task, user: user)

    label1 = FactoryBot.create(:label)
    FactoryBot.create(:second_label)

    FactoryBot.create(:task_label, task: task1, label: label1)
    FactoryBot.create(:second_task_label, task: task2, label: label1)

    visit new_session_path
    fill_in 'メールアドレス', with: 'aaa@aaa.com'
    fill_in 'パスワード', with: 'A' * 6
    click_button 'ログイン'
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

  scenario 'タスク作成時にラベルを登録' do
    visit new_task_path

    fill_in 'タスク名', with: '買い物に行く'
    fill_in 'タスク詳細', with: '午後7時にスーパーでカレーの材料を買う'
    check 'プログラミング'

    click_button 'task_save'
    click_link '買い物に行く'

    expect(page).to have_content 'プログラミング'
  end

  scenario 'タスク更新' do
    visit tasks_path
    click_link 'test_task_01'
    click_link '編集'

    fill_in 'タスク名', with: '買い物に行く'
    fill_in 'タスク詳細', with: '午後7時にスーパーでカレーの材料を買う'

    click_button 'task_save'
    click_link '買い物に行く'

    expect(page).to have_content '午後7時にスーパーでカレーの材料を買う'
  end

  scenario 'タスク更新時にラベルを変更' do
    visit tasks_path
    click_link 'test_task_03'
    click_link '編集'

    fill_in 'タスク名', with: '買い物に行く'
    fill_in 'タスク詳細', with: '午後7時にスーパーでカレーの材料を買う'
    uncheck 'プログラミング'
    check 'トレーニング'

    click_button 'task_save'
    click_link '買い物に行く'

    expect(page).not_to have_content 'プログラミング'
    expect(page).to have_content 'トレーニング'
  end

  scenario 'タスク詳細' do
    visit tasks_path
    click_link 'test_task_01'

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
    check 'プログラミング'

    click_on "検索"

    expect(page).to have_content 'test_task_04'
  end

end
