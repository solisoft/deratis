# Site — the company's fixed facts and the catalogue of pests, services and
# articles shared by every page. Content only: the pages hold the prose.
#
# French strings keep a plain space before : ; ? ! — views print them through
# `fr_text`, which makes it a no-break space. Not in the source: the published
# soli 2.9.1 has no \u escape, and `soli fmt` turns a raw U+00A0 into one.
class Site
  # The specimens of the "what is bothering you?" index. `service` is the
  # service page that treats it; `size` is the adult body length.
  static def pests
    [
      {
        "name": "Rats et souris",
        "latin": "Rattus, Mus musculus",
        "size": "7 à 25 cm",
        "image": "rat-souris.jpg",
        "service": "rats_et_souris"
      },
      {
        "name": "Frelon asiatique",
        "latin": "Vespa velutina",
        "size": "25 à 30 mm",
        "image": "frelon-asiatique.jpg",
        "service": "guepes_et_frelons"
      },
      {
        "name": "Guêpe commune",
        "latin": "Vespula vulgaris",
        "size": "10 à 19 mm",
        "image": "guepe.jpg",
        "service": "guepes_et_frelons"
      },
      {
        "name": "Punaise de lit",
        "latin": "Cimex lectularius",
        "size": "4 à 7 mm",
        "image": "punaise-de-lit.jpg",
        "service": "desinsectisation"
      },
      {
        "name": "Scorpion",
        "latin": "Euscorpius flavicaudis",
        "size": "35 à 45 mm",
        "image": "scorpion.jpg",
        "service": "desinsectisation"
      },
      {
        "name": "Fourmis",
        "latin": "Formicidae",
        "size": "2 à 12 mm",
        "image": "fourmi.jpg",
        "service": "desinsectisation"
      }
    ]
  end

  # How an intervention unfolds, in order — shared by the home and service pages.
  static def steps
    [
      {
        "title": "Devis gratuit",
        "text": "Vous nous décrivez le problème par téléphone ou via le formulaire. "
        + "Le devis ne vous engage à rien."
      },
      {
        "title": "Diagnostic sur place",
        "text": "Un agent agréé analyse les nuisibles et leur environnement : espèce, "
        + "points d'entrée, étendue de l'infestation."
      },
      {
        "title": "Traitement adapté",
        "text": "Produits professionnels choisis pour l'espèce, vapeur sèche pour la literie, "
        + "à l'horaire qui vous arrange et en toute discrétion."
      },
      {
        "title": "Prévention des récidives",
        "text": "Colmatage des accès, conseils sur les sources de nourriture "
        + "et, si besoin, un suivi régulier."
      }
    ]
  end

  # Articles, newest first. `slug` keeps the URLs of the previous site.
  static def articles
    [
      {
        "slug": "2100316856-comment-detecter-la-presence-de-rongeurs",
        "title": "Comment détecter la présence de rongeurs ?",
        "summary": "Huit signes qui trahissent des rats ou des souris, "
        + "des fils rongés aux traces grasses le long des murs.",
        "body": "rongeurs",
        "image": "rat-cave.jpg"
      },
      {
        "slug": "89681912-la-saison-des-guepes-et-frelons",
        "title": "La saison des guêpes et frelons",
        "summary": "Reconnaître un frelon européen, un frelon asiatique et une guêpe, "
        + "et savoir quand un nid devient dangereux.",
        "body": "guepes",
        "image": "nid-frelons-porche.jpg"
      },
      {
        "slug": "89679890-a-propos-de-deratis",
        "title": "À propos de Dératis",
        "summary": "Une entreprise du Gard fondée en 2006, des techniciens certifiés Certibiocide, "
        + "des clients particuliers et professionnels.",
        "body": "a_propos",
        "image": "technicien-traitement.jpg"
      }
    ]
  end

  # The article with this slug, or nil.
  static def article(slug)
    Site.articles.find do |article|
      article["slug"] == slug
    end
  end

  # Towns served, as listed by the company.
  static def communes
    [
      "Alès",
      "Anduze",
      "Aujac",
      "Bagard",
      "Bannes",
      "Bessèges",
      "Boisset-et-Gaujac",
      "Bonnevaux",
      "Boucoiran-et-Nozières",
      "Branoux-les-Taillades",
      "Brignon",
      "Brouzet-lès-Alès",
      "Castelnau-Valence",
      "Cendras",
      "Chamborigaud",
      "Concoules",
      "Corbès",
      "Cruviers-Lascours",
      "Deaux",
      "Euzet",
      "Générargues",
      "Génolhac",
      "La Grand-Combe",
      "Lamelouze",
      "Laval-Pradel",
      "Le Chambon",
      "Le Collet-de-Dèze",
      "Le Martinet",
      "Les Mages",
      "Les Plans",
      "Les Salles-du-Gardon",
      "Les Vans",
      "Lézan",
      "Martignargues",
      "Massanes",
      "Massillargues-Attuech",
      "Méjannes-lès-Alès",
      "Mialet",
      "Mons",
      "Monteils",
      "Ners",
      "Portes",
      "Ribaute-les-Tavernes",
      "Rousson",
      "Saint-Ambroix",
      "Saint-Bonnet-de-Salendrinque",
      "Saint-Césaire-de-Gauzignan",
      "Saint-Christol-lez-Alès",
      "Saint-Étienne-de-l'Olm",
      "Saint-Hilaire-de-Brethmas",
      "Saint-Hippolyte-de-Caton",
      "Saint-Jean-de-Ceyrargues",
      "Saint-Jean-de-Serres",
      "Saint-Jean-de-Valériscle",
      "Saint-Jean-du-Gard",
      "Saint-Jean-du-Pin",
      "Saint-Julien-de-Cassagnas",
      "Saint-Julien-les-Rosiers",
      "Saint-Just-et-Vacquières",
      "Saint-Martin-de-Valgalgues",
      "Saint-Maurice-de-Cazevieille",
      "Saint-Paul-la-Coste",
      "Saint-Privat-des-Vieux",
      "Saint-Sébastien-d'Aigrefeuille",
      "Sainte-Cécile-d'Andorge",
      "Sainte-Croix-de-Caderle",
      "Salindres",
      "Sénéchas",
      "Servas",
      "Seynes",
      "Soustelle",
      "Thoiras",
      "Tornac",
      "Vabres",
      "Vallon-Pont-d'Arc",
      "Vézénobres",
      "La Vernarède"
    ]
  end
end
