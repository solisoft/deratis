# The quote form: stores valid requests, re-renders invalid ones with French
# messages, drops bots silently.
describe("ContactRequestsController") do
  before_each() do
    as_guest()
    ContactRequest.all.each do |request|
      request.delete
    end
  end

  test("GET /contact presets the pest from the query") do
    result = get("/contact?nuisible=punaises")
    expect(res_status(result)).to_equal(200)
    expect(assigns()["contact_request"].pest).to_equal("punaises")
  end

  test("a valid request is stored and redirects to the thank-you page") do
    result = post(
      "/contact",
      {
        "name": "Camille Martin",
        "phone": "06 12 34 56 78",
        "email": "",
        "commune": "Alès",
        "pest": "guepes-frelons",
        "message": "Nid sous le toit"
      }
    )
    expect(res_status(result)).to_equal(302)
    expect(res_location(result).ends_with("/contact/merci")).to_equal(true)
    stored = ContactRequest.all
    expect(stored.length).to_equal(1)
    expect(stored[0].commune).to_equal("Alès")
    expect(stored[0].email).to_equal(nil)
  end

  test("an invalid request is re-rendered with a 422 and French messages") do
    result = post(
      "/contact",
      {
        "name": "",
        "phone": "abc",
        "email": "pas-un-mail",
        "message": "",
        "pest": "loup"
      }
    )
    expect(res_status(result)).to_equal(422)
    errors = assigns()["field_errors"]
    expect(errors["name"]).to_equal("Indiquez votre nom.")
    expect(errors["phone"].starts_with("Indiquez un numéro")).to_equal(true)
    expect(errors["email"]).to_equal("Cette adresse e-mail n'est pas valide.")
    expect(res_body(result).contains("aria-invalid=\"true\"")).to_equal(true)
    expect(ContactRequest.all.length).to_equal(0)
  end

  test("a filled honeypot is dropped without storing anything") do
    result = post(
      "/contact",
      {
        "name": "Bot",
        "phone": "0612345678",
        "message": "spam",
        "website": "http://spam.test"
      }
    )
    expect(res_status(result)).to_equal(302)
    expect(ContactRequest.all.length).to_equal(0)
  end

  test("the thank-you page answers") do
    result = get("/contact/merci")
    expect(res_status(result)).to_equal(200)
    expect(res_body(result).contains("Demande envoyée")).to_equal(true)
  end
end
