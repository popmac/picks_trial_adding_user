class Admin::ArticlesController < Admin::Base
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash.notice = '記事を作成しました'
      redirect_to :admin_articles
    else
      flash.now[:alert] = '記事の作成に失敗しました'
      render action: 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.assign_attributes(article_params)
    if @article.save
      redirect_to :admin_articles
    else
      flash.now[:alert] = '記事の更新に失敗しました'
      render action: 'edit'
    end
  end

  def input_url
    @article = Article.new
  end

  def scrape_url
    @article = Article.new(article_params)
    @site_url = @article.site_url
    unless /\A#{URI::regexp(%w(http https))}\z/ === @site_url
      flash.now[:notice] = 'URLの形式が間違っています'
      render action: 'input_url' and return
    end
    unless url_exist?(@site_url)
      flash.now[:notice] = 'URLが存在しません'
      render action: 'input_url' and return
    end
    get_url_info(@site_url)
    if @article.save
      redirect_to edit_admin_article_path(@article) and return
    else
      render action: 'input_url' and return
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash.notice = '記事を削除しました'
    else
      flash.now[:alert] = '記事の削除に失敗しました'
    end
    redirect_to :admin_articles
  end

  private
  def article_params
    params.require(:article).permit(
      :site_url, :site_name, :title,
      :description, :picture, :published
    )
  end

  def url_exist?(url)
    res = ->(url) {
      begin
        uri = URI.parse(url)
        uri_path = uri.path.empty? ? "/" : uri.path
        Net::HTTP.start(uri.host, uri.port) { |http| http.get(uri_path) }
      rescue TypeError, SocketError, URI::InvalidURIError
        false
      end
    }
    !url.nil? && !url.empty? && (Net::HTTPSuccess === res.call(url) || Net::HTTPRedirection === res.call(url))
  end

  def get_url_info(url)
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 1000 })
    end
    Capybara.ignore_hidden_elements = false
    session = Capybara::Session.new(:poltergeist)
    session.visit "#{url}"
    title = session.find('head title').text
    @article.title = title
    tmp_description = session.all('meta[name="description"]')
    description = tmp_description[0]
    if description == nil
    else
      @article.description = description['content']
    end
    # 以下はfindを使うと例外のエラーが発生するため、allを使っている
    tmp_og_image = session.all('meta[property="og:image"]')
    og_image = tmp_og_image[0]
    if og_image == nil
    else
      @article.picture = og_image['content']
    end
    session.driver.quit
    Capybara.reset_sessions!
  end
end
