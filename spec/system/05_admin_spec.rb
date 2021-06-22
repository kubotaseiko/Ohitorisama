require 'rails_helper'

describe '[STEP5] 管理者画面のテスト' do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  context 'ログイン時のテスト' do
    it 'ログイン成功し、サクセスメッセージが表示される' do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'Log in'
      expect(page).to have_content 'ログインしました。'
    end
  end

  context '各種情報更新のサクセスメッセージ' do
    before do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'Log in'
    end

    it 'ユーザの情報を無効に変更すると、メッセージが表示される' do
      visit edit_admin_user_path(user)
      choose 'user_is_valid_false'
      find('.btn').click
      expect(page).to have_content 'ステータスを無効に変更しました。'
    end

    it 'ユーザの情報を有効に変更すると、メッセージが表示される' do
      visit edit_admin_user_path(user)
      choose 'user_is_valid_true'
      find('.btn').click
      expect(page).to have_content 'ステータスを有効に変更しました。'
    end
  end
end