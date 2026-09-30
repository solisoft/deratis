# PublicController — what every public page shares: the layout and the
# contact form that closes most pages, the specimen plates. No actions.
class PublicController < Controller
  static {
    this.layout = "application"
  }

  private

  # An empty contact form, optionally preset to the pest the page is about.
  def _new_contact_form(pest: String = nil)
    @contact_request = ContactRequest.new({"pest": pest})
    @field_errors = {}
  end

  # Specimens for the plates, each with the path of the page that treats it.
  def _plates(pests)
    pests.map do |pest|
      pest.merge({"path": @_service_path(pest["service"])})
    end
  end

  def _service_path(service: String) -> String
    match service {
      "deratisation" => deratisation_path(),
      "desinsectisation" => desinsectisation_path(),
      "guepes_et_frelons" => guepes_et_frelons_path(),
      "rats_et_souris" => rats_et_souris_path(),
      _ => root_path(),
    }
  end
end
