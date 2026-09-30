# Public pages: home, services, articles — every page answers and carries
# what its template reads.
describe("Public pages") do
  before_each() do
    as_guest()
  end

  test("home lists the six specimens, the steps, the articles and the communes") do
    result = get("/")
    expect(res_status(result)).to_equal(200)
    expect(assigns()["pests"].length).to_equal(6)
    expect(assigns()["steps"].length).to_equal(4)
    expect(assigns()["articles"].length).to_equal(3)
    expect(assigns()["communes"].length > 50).to_equal(true)
    expect(res_body(result).contains("tel:+33767561307")).to_equal(true)
  end

  test("French punctuation never starts a line") do
    body = res_body(get("/"))
    expect(body.contains("leur environnement&nbsp;: espèce")).to_equal(true)
    expect(body.contains("de rongeurs&nbsp;?")).to_equal(true)
  end

  test("each specimen links to the page that treats it") do
    get("/")
    paths = assigns()["pests"].map do |pest|
      pest["path"]
    end
    expect(paths.includes?("/fr/rats-et-souris")).to_equal(true)
    expect(paths.includes?("/fr/guepes-et-frelons")).to_equal(true)
    expect(paths.includes?("/fr/desinsectisation")).to_equal(true)
  end

  test("dératisation shows the rodents and presets the form") do
    result = get("/fr/deratisation")
    expect(res_status(result)).to_equal(200)
    expect(assigns()["pests"].length).to_equal(1)
    expect(assigns()["contact_request"].pest).to_equal("rats-souris")
  end

  test("désinsectisation shows the insects") do
    result = get("/fr/desinsectisation")
    expect(res_status(result)).to_equal(200)
    expect(assigns()["pests"].length).to_equal(3)
    expect(assigns()["contact_request"].pest).to_equal("punaises")
  end

  test("guêpes et frelons shows the wasp and the hornet") do
    result = get("/fr/guepes-et-frelons")
    expect(res_status(result)).to_equal(200)
    expect(assigns()["pests"].length).to_equal(2)
    expect(assigns()["contact_request"].pest).to_equal("guepes-frelons")
  end

  test("rats et souris answers") do
    result = get("/fr/rats-et-souris")
    expect(res_status(result)).to_equal(200)
    expect(assigns()["current_nav"]).to_equal("rats_et_souris")
  end

  test("the old ants page redirects permanently to désinsectisation") do
    result = get("/fr/fourmis")
    expect(res_status(result)).to_equal(301)
    expect(res_location(result).ends_with("/fr/desinsectisation")).to_equal(true)
  end

  test("the article list keeps the old URL") do
    result = get("/fr/tous-les/articles")
    expect(res_status(result)).to_equal(200)
    expect(assigns()["articles"].length).to_equal(3)
  end

  test("an article renders with the two others alongside") do
    result = get("/fr/details/article/89681912-la-saison-des-guepes-et-frelons")
    expect(res_status(result)).to_equal(200)
    expect(assigns()["article"]["body"]).to_equal("guepes")
    expect(assigns()["others"].length).to_equal(2)
    expect(res_body(result).contains("Vespa velutina")).to_equal(true)
  end

  test("the rodent and about articles render") do
    expect(res_status(get("/fr/details/article/2100316856-comment-detecter-la-presence-de-rongeurs"))).to_equal(200)
    expect(res_status(get("/fr/details/article/89679890-a-propos-de-deratis"))).to_equal(200)
  end

  test("an unknown article is a 404") do
    result = get("/fr/details/article/inconnu")
    expect(res_status(result)).to_equal(404)
    expect(res_body(result).contains("Article introuvable")).to_equal(true)
  end

  test("the health check answers ok") do
    result = get("/health")
    expect(res_status(result)).to_equal(200)
    expect(res_body(result).contains("ok")).to_equal(true)
  end
end
