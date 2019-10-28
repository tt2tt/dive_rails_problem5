require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end
  scenario 'タスク一覧のテスト' do
    visit tasks_path

    expect(page).to have_content 'test1'
    expect(page).to have_content 'sample2'
    expect(page).to have_content 'mof3'
  end

  scenario 'タスク作成のテスト' do
    visit new_task_path

    fill_in 'タスク名', with: '買い物に行く'
    fill_in 'タスク詳細', with: '午後7時にスーパーでカレーの材料を買う'

    click_button 'task_save'

    visit tasks_path

    expect(page).to have_content '買い物に行く'
    expect(page).to have_content '午後7時にスーパーでカレーの材料を買う'
  end

  scenario 'タスク詳細のテスト' do
    visit tasks_path(id: 1)

    expect(page).to have_content 'test1'
  end

  scenario 'タスクが作成日時の降順に並んでいるかのテスト' do
    visit tasks_path
    first_task = all('.tasks .task')[0]
    third_task = all('.tasks .task')[2]
    save_and_open_page
    expect(first_task).to have_content 'mof3'
    expect(third_task).to have_content 'test1'
  end
end
