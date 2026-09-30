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
    return @_not_found if @article.nil?

    @title = @article["title"]
    @description = @article["summary"]
    @current_nav = "articles"
    @others = Site.articles.filter do |other|
      other["slug"] != @article["slug"]
    end
    @_new_contact_form
  end

  private

  # A 404 inside the site, pointing at the articles that do exist. Not
  # `halt(404)`: the published soli 2.9.1 answers it with a 500.
  def _not_found
    @title = "Article introuvable"
    @current_nav = "articles"
    @articles = Site.articles
    render("articles/not_found", {}, {"status": 404})
  end
end
