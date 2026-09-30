describe("Site") do
  test("finds an article by its slug") do
    article = Site.article("89679890-a-propos-de-deratis")
    expect(article["title"]).to_equal("À propos de Dératis")
  end

  test("returns nil for an unknown slug") do
    expect(Site.article("inconnu")).to_equal(nil)
  end

  test("every specimen names a service page") do
    services = ["deratisation", "desinsectisation", "guepes_et_frelons", "rats_et_souris"]
    Site.pests.each do |pest|
      expect(services.includes?(pest["service"])).to_equal(true)
    end
  end
end
