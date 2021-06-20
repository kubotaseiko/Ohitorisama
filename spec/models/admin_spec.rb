require 'rails_helper'

RSpec.describe 'Adminモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { admin.valid? }

    let!(:order_admin) { create(:admin) }
    let(:admin) { build(:admin) }


    context 'emailカラム' do
      it '空白でないこと' do
        admin.email = ''
        is_expected.to eq false
      end
    end
  end
end