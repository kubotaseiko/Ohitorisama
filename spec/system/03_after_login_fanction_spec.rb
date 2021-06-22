require 'rails_helper'

describe '[STEP3] ユーザログイン後のテスト' do
  let!(:user) { create(:user) }
  let!(:shop) { create(:shop2, user: user) }

  describe '検索のテスト' do
      context 'ログイン前の検索のテスト' do
      before do
        visit root_path
      end
      it '空白で検索すると0件と表示される' do
        fill_in 'keyword', with: ' '
        find('.btn-outline-success').click
        expect(page).to have_content '検索結果 0件'
      end
      it '該当がないとと0件と表示される' do
        fill_in 'keyword', with: 'スポーツ'
        find('.btn-outline-success').click
        expect(page).to have_content '検索結果 0件'
      end
      it '店名での検索がうまく行える' do
        fill_in 'keyword', with: '居酒屋'
        find('.btn-outline-success').click
        expect(page).to have_content '居酒屋鹿児島店'
      end
      it '住所での検索がうまく行える' do
        fill_in 'keyword', with: '鹿児島県鹿児島市'
        find('.btn-outline-success').click
        expect(page).to have_content '居酒屋鹿児島店'
      end
      it 'タグでの検索がうまく行える' do
        fill_in 'keyword', with: '焼き鳥'
        find('.btn-outline-success').click
        expect(page).to have_content '居酒屋鹿児島店'
      end
    end

    context 'ログイン後の検索のテスト' do
      before do
        visit new_user_session_path
        fill_in 'user[name]', with: user.name
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        visit shops_path
      end

      it '空白で検索すると0件と表示される' do
        fill_in 'keyword', with: '　'
        find('.fa-search').click
        expect(page).to have_content '検索結果 0件'
      end
      it '該当がないと0件と表示される' do
        fill_in 'keyword', with: 'スポーツ'
        find('.fa-search').click
        expect(page).to have_content '検索結果 0件'
      end
      it '店名での検索がうまく行える' do
        fill_in 'keyword', with: '居酒屋'
        find('.fa-search').click
        expect(page).to have_content '居酒屋鹿児島店'
      end
      it '住所での検索がうまく行える' do
        fill_in 'keyword', with: '鹿児島県鹿児島市'
        find('.fa-search').click
        expect(page).to have_content '居酒屋鹿児島店'
      end
      it 'タグでの検索がうまく行える' do
        fill_in 'keyword', with: '焼き鳥'
        find('.fa-search').click
        expect(page).to have_content '居酒屋鹿児島店'
      end
    end
  end
end