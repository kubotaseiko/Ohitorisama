require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:shop) { create(:shop, user: user) }
  let!(:tweet) { create(:tweet, user: user) }

  let!(:other_user) { create(:user) }
  let!(:other_shop) { create(:shop, user: other_user) }
  let!(:other_tweet) { create(:tweet, user: other_user) }
  let!(:review) { create(:review, user: other_user, shop: shop) }



  before do
    visit new_user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }

      it 'MyPageを押すと、自分のユーザ詳細画面に遷移する' do
        click_on 'MyPage'
        is_expected.to eq '/users/' + user.id.to_s
      end
      it 'Shopsを押すと、ショップ一覧画面に遷移する' do
        click_on 'Shops'
        is_expected.to eq '/shops'
      end
      it 'Postを押すと、Shop投稿投稿画面に遷移する' do
        click_on 'Post'
        is_expected.to eq '/shops/new'
      end
      it 'Contactを押すと、お問い合わせ投稿画面に遷移する' do
        find('.pc-contact-link').click
        is_expected.to eq '/contacts/new'
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit shops_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/shops'
      end
      it 'hotの並べ替えリンクがある' do
        have_link '/hot'
      end
      it 'Rankの並べ替えリンクがある' do
        have_link '/rank'
      end
      it 'shop投稿の画像のリンク先が正しい' do
        expect(page).to have_link '', href: shop_path(shop)
      end
      it 'shopの店名が表示される' do
        expect(page).to have_content shop.shop_name
      end
      it 'shopの評価が表示される' do
        expect(page).to have_content '評価なし' or shop.rate_average
      end
      it 'shopのレビュー数が表示される' do
        expect(page).to have_content shop.reviews.count
      end
    end

    context '表示内容の確認(つぶやき関連)' do
      it '「つぶやき」の表示があるか' do
        expect(page).to have_content 'つぶやき'
      end
      it 'つぶやき内容が表示される' do
        expect(page).to have_content tweet.tweet
      end
      it '投稿日時が表示される' do
        expect(page).to have_content tweet.created_at.strftime("%m/%d %H:%M:%S")
      end
      it '投稿者の名前とリンク先が正しい' do
        expect(page).to have_link tweet.user.name, href: user_path(tweet.user)
      end
      it '投稿者の画像とリンク先が正しい' do
        expect(page).to have_link '', href: user_path(tweet.user)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '', href: tweet_path(tweet)
      end
    end

    context '表示内容の確認(タグ一覧)' do
      it '「tag」の表示があるか' do
        expect(page).to have_content 'tag'
      end
      it 'タグが表示され、リンク先が正しい' do
        shop.tags.each do |tag|
         expect(page).to have_link tag.tag_name, href: tag_shops_path(tag)
        end
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit shop_path(shop)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/shops/' + shop.id.to_s
      end
      it 'ユーザ画像・名前のリンク先が正しい' do
        expect(page).to have_link shop.user.name, href: user_path(shop.user)
        expect(page).to have_link shop.user.profile_image, href: user_path(shop.user)
      end
      it '投稿のtitleが表示される' do
        expect(page).to have_content shop.shop_name
      end
      it '投稿の評価が表示される' do
        expect(page).to have_content '評価なし' or shop.rate_average
      end
      it '「tag」の表示があるか' do
        shop.tags.each do |tag|
          expect(page).to have_link tag.tag_name, href: tag_shops_path(tag)
        end
      end
      it '投稿の紹介文が表示される' do
        expect(page).to have_content shop.introduction
      end
      it '投稿の住所が表示される' do
        expect(page).to have_content '住所'
        expect(page).to have_content shop.address
      end
      it '投稿の電話番号が表示される' do
        expect(page).to have_content '電話番号'
        expect(page).to have_content shop.tell
      end
      it '投稿の営業時間が表示される' do
        expect(page).to have_content '営業時間'
        expect(page).to have_content shop.business_hours
      end
      it '投稿の定休日が表示される' do
        expect(page).to have_content '定休日'
        expect(page).to have_content shop.holiday
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '編集', href: edit_shop_path(shop)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '削除', href: shop_path(shop)
      end
    end
    context '表示内容の確認(review)' do
      it 'reviewが表示されている' do
        expect(page).to have_content 'Reviews'

      end
      it 'reviewの投稿日が表示されている'do
        expect(page).to have_content review.created_at.strftime('%m/%d')
      end
      it 'review投稿者のアイコンが表示され、リンク先が正しい'do
        expect(page).to have_link review.user.profile_image, href: user_path(other_user)
      end
    end
  end
end