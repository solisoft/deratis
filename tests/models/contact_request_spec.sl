describe("ContactRequest") do
  before_each() do
    ContactRequest.all.each do |request|
      request.delete
    end
  end

  test("stores a request and trims its fields") do
    request = ContactRequest.create({
      "name": "  Camille  ",
      "phone": " 06 12 34 56 78 ",
      "email": " Camille@Example.FR ",
      "message": "Des crottes dans la cave"
    })
    expect(request._errors.nil? || request._errors.length == 0).to_equal(true)
    expect(request.name).to_equal("Camille")
    expect(request.phone).to_equal("06 12 34 56 78")
    expect(request.email).to_equal("camille@example.fr")
  end

  test("requires a name, a phone and a message") do
    request = ContactRequest.create({})
    fields = request._errors.map do |error|
      error["field"]
    end
    expect(fields.includes?("name")).to_equal(true)
    expect(fields.includes?("phone")).to_equal(true)
    expect(fields.includes?("message")).to_equal(true)
  end

  test("rejects a pest outside the list") do
    request = ContactRequest.create({
      "name": "A",
      "phone": "0612345678",
      "message": "x",
      "pest": "loup"
    })
    expect(request._errors[0]["field"]).to_equal("pest")
  end

  test("accepts every pest of the list") do
    ContactRequest.PESTS.each do |pest|
      request = ContactRequest.create({
        "name": "A",
        "phone": "0612345678",
        "message": "x",
        "pest": pest
      })
      expect(request._key.nil?).to_equal(false)
    end
  end
end
