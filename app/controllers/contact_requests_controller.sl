# Contact requests controller — the quote / callback form.
class ContactRequestsController < PublicController
  # French wording for each field the model rejects.
  static FIELD_MESSAGES: Hash = {
    "name": "Indiquez votre nom.",
    "phone": "Indiquez un numéro de téléphone, par exemple 06 12 34 56 78.",
    "email": "Cette adresse e-mail n'est pas valide.",
    "message": "Décrivez le problème en quelques mots (4 000 caractères au plus).",
    "pest": "Choisissez un nuisible dans la liste."
  }

  # GET /contact
  def new
    @title = "Demander un devis"
    @description = "Demandez un devis gratuit à Dératis\u{a0}: nous vous rappelons au plus vite."
    @current_nav = "contact"
    @_new_contact_form(params["nuisible"])
  end

  # POST /contact — stores the request; a filled honeypot is dropped silently
  def create
    return redirect(contact_thanks_path()) unless params["website"].blank?

    @contact_request = ContactRequest.create(@_permit_params)
    return redirect(contact_thanks_path()) if @contact_request._errors.nil? ||
        @contact_request._errors.length == 0

    @title = "Demander un devis"
    @current_nav = "contact"
    @field_errors = @_field_errors(@contact_request._errors)
    render("contact_requests/new", {}, {"status": 422})
  end

  # GET /contact/merci
  def thanks
    @title = "Demande envoyée"
    @current_nav = "contact"
  end

  private

  # Blank optional fields become nil so their format rules are skipped.
  def _permit_params
    attrs = permit(
      params,
      {
        "name": true,
        "phone": true,
        "email": true,
        "commune": true,
        "pest": true,
        "message": true
      }
    );
    ["email", "commune", "pest"].each do |field|
      attrs[field] = nil if attrs[field].blank?
    end
    attrs
  end

  def _field_errors(errors)
    messages = {}
    errors.each do |error|
      messages[error["field"]] = ContactRequestsController.FIELD_MESSAGES[error["field"]] ?? error["message"]
    end
    messages
  end
end
