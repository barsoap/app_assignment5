class Book < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  validates :title,presence: true
  validates :body,presence: true, length: {maximum:200}

  def liked_by?(user) #引数で渡されたユーザidがlikesテーブル内に存在（exists?）するかどうかを調べる。
    likes.exists?(user_id: user.id)
  end

  def post_commented_by?
    post_comments.exists?(user_id: user.id)
  end

  #search_forメソッドの定義
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('name LIKE ?', '%' + content)
    else
      Book.where('name LIKE ?', '%' + content + '%')
    end
  end
  #コメントアウトがありわかりやすい

end
