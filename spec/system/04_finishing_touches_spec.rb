require 'rails_helper'

describe '[STEP4] 仕上げのテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:shop) { create(:shop, user: user) }
  let!(:other_shop) { create(:shop, user: other_user) }


  describe '処理失敗時のテスト' do
    context 'ユーザ新規登録失敗: nameを1文字にする' do
      before do
        visit new_user_registration_path
        @name = Faker::Lorem.characters(number: 1)
        @email = 'a' + user.email
        fill_in 'user[name]', with: @name
        fill_in 'user[email]', with: @email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '新規登録されない' do
        expect { click_button '登録' }.not_to change(User.all, :count)
      end
      it '新規登録画面を表示しており、フォームの内容が正しい' do
        click_button '登録'
        expect(page).to have_content '登録'
        expect(page).to have_field 'user[name]', with: @name
        expect(page).to have_field 'user[email]', with: @email
      end
      it 'バリデーションエラーが表示される' do
        click_button '登録'
        expect(page).to have_content "アカウント名は2文字以上で入力してください"
      end
    end
    
    context 'ユーザのプロフィール情報編集失敗: nameを1文字にする' do
      before do
        @user_old_name = user.name
        @name = Faker::Lorem.characters(number: 1)
        visit new_user_session_path
        fill_in 'user[name]', with: @user_old_name
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        visit edit_user_path(user)
        fill_in 'user[name]', with: @name
        click_button '更新'
      end

      it '更新されない' do
        expect(user.reload.name).to eq @user_old_name
      end
      it 'ユーザ編集画面を表示しており、フォームの内容が正しい' do
        expect(page).to have_field 'user[name]', with: @name
      end
      it 'バリデーションエラーが表示される' do
        expect(page).to have_content "アカウント名は2文字以上で入力してください"
      end
    end

    # context '投稿データの新規投稿失敗: 投稿一覧画面から行い、お店の名前を空にする' do
    #   before do
    #     visit new_user_session_path
    #     fill_in 'user[name]', with: user.name
    #     fill_in 'user[password]', with: user.password
    #     click_button 'ログイン'
    #     visit shops_path
    #     @introdact = Faker::Lorem.characters(number: 19)
    #     fill_in 'book[body]', with: @body
    #   end

    #   it '投稿が保存されない' do
    #     expect { click_button 'Create Book' }.not_to change(Book.all, :count)
    #   end
    #   it '投稿一覧画面を表示している' do
    #     click_button 'Create Book'
    #     expect(current_path).to eq '/books'
    #     expect(page).to have_content book.body
    #     expect(page).to have_content other_book.body
    #   end
    #   it '新規投稿フォームの内容が正しい' do
    #     expect(find_field('book[title]').text).to be_blank
    #     expect(page).to have_field 'book[body]', with: @body
    #   end
    #   it 'バリデーションエラーが表示される' do
    #     click_button 'Create Book'
    #     expect(page).to have_content "can't be blank"
    #   end
    # end
    context '投稿データの更新失敗: shop_nameを空にする' do
      before do
        visit new_user_session_path
        fill_in 'user[name]', with: user.name
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        visit edit_shop_path(shop)
        @shop_old_shop_name = shop.shop_name
        fill_in 'shop[shop_name]', with: ''
        click_button '保存する'
      end

      it '投稿が更新されない' do
        expect(shop.reload.shop_name).to eq @shop_old_shop_name
      end
      it '投稿編集画面を表示しており、フォームの内容が正しい' do
        expect(current_path).to eq '/shops/' + shop.id.to_s
        expect(find_field('shop[shop_name]').text).to be_blank
        expect(page).to have_field 'shop[introduction]', with: shop.introduction
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_content 'エラー'
      end
    end
  end

  describe 'ログインしていない場合のアクセス制限のテスト: アクセスできず、ログイン画面に遷移する' do
    subject { current_path }
    it 'ユーザ情報編集画面' do
      visit edit_user_path(user)
      is_expected.to eq '/users/sign_in'
    end
    it '投稿編集画面' do
      visit edit_shop_path(shop)
      is_expected.to eq '/users/sign_in'
    end
  end

  describe '他人の画面のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    describe '他人の投稿詳細画面のテスト' do
      before do
        visit shop_path(other_shop)
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/shops/' + other_shop.id.to_s
        end
        it '投稿の編集リンクが表示されない' do
          expect(page).not_to have_link '編集'
        end
        it '投稿の削除リンクが表示されない' do
          expect(page).not_to have_link '削除'
        end
      end

      context '他人の投稿編集画面' do
        it '遷移できず、投稿一覧画面にリダイレクトされる' do
          visit edit_shop_path(other_shop)
          expect(current_path).to eq '/shops'
        end
      end
    end

    describe '他人のユーザ詳細画面のテスト' do
      before do
        visit user_path(other_user)
      end
  
      context '表示の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/users/' + other_user.id.to_s
        end
        it '自分の投稿は表示されない' do
          expect(page).not_to have_content shop.shop_name
        end
      end
  
      context '他人のユーザ情報編集画面' do
        it '遷移できず、自分のユーザ詳細画面にリダイレクトされる' do
          visit edit_user_path(other_user)
          expect(current_path).to eq '/users/' + user.id.to_s
        end
      end
    end 
  end
end
