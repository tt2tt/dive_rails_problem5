require 'rails_helper'

RSpec.feature 'ユーザー管理機能', type: :feature do
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

  scenario 'ユーザー作成' do
    visit new_user_path

    fill_in '名前', with: '仮名前'
    fill_in 'メールアドレス', with: 'exam@exam.com'
    fill_in 'パスワード', with: 'a' * 6
    fill_in 'パスワード(確認)', with: 'a' * 6

    click_button 'ユーザー登録'

    expect(page).to have_content '仮名前'
    expect(page).to have_content 'exam@exam.com'
  end

  scenario '未ログイン時のタスク一覧へのアクセス制限' do
    visit tasks_path

    expect(page).to have_content 'ログインしてください'
  end

  scenario '自分が作成したタスクのみ表示される' do
    visit new_session_path

    fill_in 'メールアドレス', with: 'bbb@bbb.com'
    fill_in 'パスワード', with: 'B' * 6

    click_button 'ログイン'

    visit tasks_path

    expect(page).not_to have_content 'test_task_01'
    expect(page).to have_content 'test_task_02'
  end

  scenario 'ログイン' do
    visit new_session_path

    fill_in 'メールアドレス', with: 'bbb@bbb.com'
    fill_in 'パスワード', with: 'B' * 6

    click_button 'ログイン'

    expect(page).to have_content 'ログインしました'
  end

  scenario 'ログイン時のサインアップ画面へのアクセス制限' do
    visit new_session_path

    fill_in 'メールアドレス', with: 'bbb@bbb.com'
    fill_in 'パスワード', with: 'B' * 6

    click_button 'ログイン'

    visit new_user_path

    expect(page).to have_content 'BBB'
    expect(page).to have_content 'bbb@bbb.com'
  end

  scenario 'current_user以外のマイページへのアクセス制限' do
    visit new_session_path

    fill_in 'メールアドレス', with: 'bbb@bbb.com'
    fill_in 'パスワード', with: 'B' * 6

    click_button 'ログイン'

    visit user_path(1)

    expect(page).to have_content 'BBB'
    expect(page).to have_content 'bbb@bbb.com'
  end

  scenario 'ログアウト' do
    visit new_session_path

    fill_in 'メールアドレス', with: 'bbb@bbb.com'
    fill_in 'パスワード', with: 'B' * 6

    click_button 'ログイン'

    click_link 'ログアウト'

    expect(page).to have_content 'ログアウトしました'
  end

end
