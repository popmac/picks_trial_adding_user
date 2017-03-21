class Customer::Authenticator
  def initialize(user)
    @user = user
  end

  def authenticate(raw_password)
    @user &&
      @user.hashed_password &&
      # 下記の==は比較演算子ではなく、BCrypt::Passwordオブジェクトのインスタンスメソッド
      # 引数に指定された平文のパスワードをハッシュ関数で計算し、自分自身の保持しているハッシュ値と同じであればtrueを返す
      BCrypt::Password.new(@user.hashed_password) == raw_password
  end
end
