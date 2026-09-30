# Articles controller — the advice pages, at the previous site's URLs.
class ArticlesController < PublicController
  # GET /fr/tous-les/articles
  def index
    @title = "Conseils"
    @description = "Conseils de Dératis pour reconnaître les nuisibles et les tenir à distance."
    @current_nav = "articles"
    @articles = Site.articles
  end

  # GET /fr/details/article/:slug
  def show
    @article = Site.article(params["slug"])
    halt(404, "Article introuvable") if @article.nil?

    @title = @article["title"]
    @description = @article["summary"]
    @current_nav = "articles"
    @others = Site.articles.filter do |other|
      other["slug"] != @article["slug"]
    end
    @_new_contact_form
  end
end
