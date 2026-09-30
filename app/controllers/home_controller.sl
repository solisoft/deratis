# Home controller — the landing page and the health check.
class HomeController < PublicController
  # GET /
  def index
    @title = "Dératisation et désinsectisation dans le Gard, la Lozère et l'Ardèche"
    @description = "Dératis : rats, souris, guêpes, frelons, punaises de lit, cafards. Devis gratuit, "
    + "intervention rapide et discrète près d'Alès depuis 2006. Techniciens certifiés Certibiocide."
    @pests = @_plates(Site.pests)
    @steps = Site.steps
    @articles = Site.articles
    @communes = Site.communes
    @_new_contact_form
  end

  # GET /health
  def health
    {
      "status": 200,
      "headers": {"Content-Type": "application/json"},
      "body": "{\"status\":\"ok\"}"
    }
  end
end
