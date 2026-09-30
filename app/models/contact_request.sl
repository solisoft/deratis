# ContactRequest — a quote or callback request sent from the contact form.
# The team calls back on `phone`; `email` is optional.
class ContactRequest < Model
  # Values of the "which pest?" select; the labels live in the form.
  static PESTS: Array = [
    "rats-souris",
    "guepes-frelons",
    "punaises",
    "cafards",
    "fourmis",
    "autre"
  ]

  validates(
    "name",
    {"presence": true, "max_length": 100}
  )
  validates(
    "phone",
    {"presence": true, "format": "^[0-9 +().-]{10,20}$"}
  )
  validates(
    "email",
    {"format": "email", "allow_nil": true}
  )
  validates(
    "message",
    {"presence": true, "max_length": 4000}
  )
  validates(
    "pest",
    {"inclusion": ContactRequest.PESTS, "allow_nil": true}
  )
  before_save("normalize")

  def normalize
    @name = @name.trim unless @name.nil?
    @phone = @phone.trim unless @phone.nil?
    @email = @email.trim.downcase unless @email.nil?
    # Only a tampered form sends another value; keep the request, drop the
    # value. (A validation would do, but the published soli 2.9.1 ignores
    # both `inclusion` and `custom`.)
    @pest = nil unless ContactRequest.PESTS.includes?(@pest)
    true
  end
end
