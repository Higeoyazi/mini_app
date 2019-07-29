require 'rails_helper'

describe User do
  describe '#create' do
  # 1.nameとemail、passwordとpassword_confirmationが存在すれば登録できること
    it "is valid with a name, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end
  
  # 2.nameが空では登録できないこと
    it "is invalid without a name" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

  # 3.emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

  # 4.passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

  # 5.passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

  # 6.重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

  # 7.nameが15文字以上であれば、登録できないこと
    it "is invalid with a name that has more than 15 characters " do
      user = build(:user, name: "abcdefghijklmnop")
      user.valid?
      expect(user.errors[:name][0]).to include("is too long")
    end

  # 8.nameが15文字以下では、登録できること
    it "is valid with a name that has less than 6 characters " do
      user = build(:user, name: "abcdefghijklmno")
      expect(user).to be_valid
    end

  # 9.passwordが5文字以下であれば登録できないこと
    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end
  end

end
