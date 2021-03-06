class ArticlesController < ApplicationController
  include Paginable
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @categories = Category.sorted
    category = @categories.select { |c| c.name == params[:category] }[0] if params[:category].present?

    @highlights = Article.includes(%i[category user])
                         .filter_by_category(category)
                         .desc_order
                         .first(3)

    @articles = Article.includes(%i[category user])
                       .without_highlights(@highlights.pluck(:id))
                       .filter_by_category(category)
                       .desc_order
                       .page(current_page)
  end

  def show; end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to @article, notice: 'Article was successfully created'
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path, notice: 'Article was successfully destroyed'
  end

  private

  def set_article
    @article = Article.find(params[:id])
    authorize @article
  end

  def article_params
    params.require(:article).permit(:title, :body, :category_id)
  end
end
