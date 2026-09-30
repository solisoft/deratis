# Routes — the service and article URLs keep the paths of the previous site,
# which search engines already index.

get("/", "home#index", name: "root")

# Service pages
get("/fr/deratisation", "services#deratisation", name: "deratisation")
get("/fr/desinsectisation", "services#desinsectisation", name: "desinsectisation")
get("/fr/guepes-et-frelons", "services#guepes_et_frelons", name: "guepes_et_frelons")
get("/fr/rats-et-souris", "services#rats_et_souris", name: "rats_et_souris")
get("/fr/fourmis", "services#fourmis")

# Articles
get("/fr/tous-les/articles", "articles#index", name: "articles")
get("/fr/details/article/:slug", "articles#show", name: "article")

# Contact
get("/contact", "contact_requests#new", name: "contact")
post("/contact", "contact_requests#create")
get("/contact/merci", "contact_requests#thanks", name: "contact_thanks")

# Health check endpoint
get("/health", "home#health")
