require 'rails_helper'

RSpec.feature '管理画面機能', type: :feature do
  background do
    user = FactoryBot.create(:user)
    second_user = FactoryBot.create(:second_user)

    FactoryBot.create(:task, user: user)
    FactoryBot.create(:second_task, user: user)
    FactoryBot.create(:third_task, user: user)
    FactoryBot.create(:forth_task, user: user)
    FactoryBot.create(:fifth_task, user: user)
    FactoryBot.create(:second_task, user: second_user)
  end

  scenario '一覧画面' do
    visit admin_users_path

    expect(page).to have_content 'AAA'
    expect(page).to have_content 'BBB'
  end

  scenario 'ユーザー作成' do
    visit new_admin_user_path

    fill_in '名前', with: '仮名前'
    fill_in 'メールアドレス', with: 'exam@exam.com'
    fill_in 'パスワード', with: 'a' * 6
    fill_in 'パスワード(確認)', with: 'a' * 6

    click_button 'ユーザーを作成する'

    expect(page).to have_content '仮名前'
  end

  scenario 'ユーザー詳細画面' do
    visit admin_users_path

    click_link 'AAA'

    expect(page).to have_content 'aaa@aaa.com'
    expect(page).to have_content 'test_task_01'
  end

  scenario 'ユーザー更新' do
    visit admin_users_path

    click_link 'AAA'
    click_link '編集'

    fill_in '名前', with: '仮名前'
    fill_in 'メールアドレス', with: 'exam@exam.com'
    fill_in 'パスワード', with: 'a' * 6
    fill_in 'パスワード(確認)', with: 'a' * 6

    click_button 'ユーザーを編集する'

    expect(page).to have_content '仮名前'
    expect(page).to have_content 'exam@exam.com'
  end

  scenario 'ユーザー削除' do
    visit admin_users_path

    click_link 'AAA'
    click_link '削除'

    expect(page).not_to have_content 'AAA'
    expect(page).to have_content 'BBB'
  end

end
# save_and_open_page
