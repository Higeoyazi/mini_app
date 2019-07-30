class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  validates :text, presence: true
  # エラーメッセージの表示は未実装
end
