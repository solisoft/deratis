# Services controller — one page per treatment, at the previous site's URLs.
class ServicesController < PublicController
  # GET /fr/deratisation
  def deratisation
    @title = "Dératisation"
    @description = "Dératisation dans le Gard, la Lozère et l'Ardèche : devis gratuit, diagnostic par un agent "
    + "agréé, traitement adapté et prévention des récidives."
    @current_nav = "deratisation"
    @lead = "Rats et souris dans la maison, la cave, le grenier ou vos locaux : un agent agréé "
    + "identifie l'espèce, traite, puis bouche les accès pour qu'ils ne reviennent pas."
    @_prepare(["deratisation", "rats_et_souris"], "rats-souris")
  end

  # GET /fr/desinsectisation
  def desinsectisation
    @title = "Désinsectisation"
    @description = "Cafards, fourmis, punaises de lit, scorpions, araignées : traitements professionnels et "
    + "discrets pour particuliers et professionnels autour d'Alès."
    @current_nav = "desinsectisation"
    @lead = "Cafards, fourmis, punaises de lit, scorpions, araignées : un service rapide, soigné et "
    + "discret, pour les particuliers comme pour les professionnels."
    @_prepare(["desinsectisation"], "punaises")
  end

  # GET /fr/guepes-et-frelons
  def guepes_et_frelons
    @title = "Guêpes et frelons"
    @description = "Destruction de nids de guêpes, frelons européens et frelons asiatiques dans le Gard, "
    + "la Lozère et l'Ardèche, par des opérateurs équipés."
    @current_nav = "guepes_et_frelons"
    @lead = "Un nid sous le toit, dans un volet roulant ou au fond du jardin : nous le détruisons avec "
    + "des insecticides professionnels, équipés pour ne pas nous faire piquer, ni vous."
    @_prepare(["guepes_et_frelons"], "guepes-frelons")
  end

  # GET /fr/rats-et-souris
  def rats_et_souris
    @title = "Rats et souris"
    @description = "Surmulot, rat noir, souris : les risques qu'ils font courir et comment Dératis vous en "
    + "débarrasse durablement."
    @current_nav = "rats_et_souris"
    @lead = "Trois espèces vivent à nos côtés dans la région. Savoir laquelle est chez vous indique où "
    + "elle niche, et comment la déloger."
    @_prepare(["rats_et_souris"], "rats-souris")
  end

  # GET /fr/fourmis — the old page was never written; ants are treated under désinsectisation
  def fourmis
    {
      "status": 301,
      "headers": {"Location": desinsectisation_path()},
      "body": ""
    }
  end

  private

  # The page's specimens, the intervention steps, and a form preset to `pest`.
  def _prepare(services: Array, pest: String)
    @pests = @_plates(Site.pests.filter(&{ |specimen|
      services.includes?(specimen["service"])
    }))
    @steps = Site.steps
    @_new_contact_form(pest)
  end
end
