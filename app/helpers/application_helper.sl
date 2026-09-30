# Application-wide view helpers

# Truncate text to a maximum length with ellipsis
def truncate_text(text: String, length: Int, suffix: String) -> String
  return text if len(text) <= length

  substring(text, 0, length - len(suffix)) + suffix
end

# Capitalize first letter of a string
def capitalize(text: String) -> String
  return text if len(text) == 0

  upcase(substring(text, 0, 1)) + substring(text, 1, len(text))
end

# SEC-012: Reject href values that would let an attacker run JS through
# `javascript:` (or similar) URL schemes. HTML-escaping the URL is *not*
# enough — the browser still parses `javascript:alert(1)` inside an
# `href` attribute. Mirror the allowlist used by the markdown sanitiser.
def _is_safe_link_url(url)
  lower = url.downcase()
  return true if lower.starts_with("http://") || lower.starts_with("https://") || lower.starts_with("mailto:")
  return true if lower.starts_with("/") || lower.starts_with("#") || lower.starts_with("?")

  # No allowed scheme prefix; treat as relative *only* if there is no
  # scheme separator (`:`) before the first /?#. Anything else is a
  # custom scheme like javascript:/data: and must be refused.
  cut = len(lower)
  s = lower.index_of("/")
  cut = s if s != -1 && s < cut
  q = lower.index_of("?")
  cut = q if q != -1 && q < cut
  h = lower.index_of("#")
  cut = h if h != -1 && h < cut
  !lower.substring(0, cut).contains(":")
end

def _safe_link_url(url)
  return url if _is_safe_link_url(url)

  "#"
end

# Generate an HTML link
def link_to(text: String, url: String) -> String
  "<a href=\"" + html_escape(_safe_link_url(url)) + "\">" + html_escape(text) + "</a>"
end

# Generate an HTML link with CSS class
def link_to_class(text: String, url: String, css_class: String) -> String
  let href = html_escape(_safe_link_url(url))
  "<a href=\"" + href + "\" class=\"" + html_escape(css_class) + "\">" + html_escape(text) + "</a>"
end

# Pluralize a word based on count
def pluralize(count: Int, singular: String, plural: String) -> String
  return str(count) + " " + singular if count == 1

  str(count) + " " + plural
end

# Simple pluralize (adds 's')
def pluralize_simple(count: Int, word: String) -> String
  return str(count) + " " + word if count == 1

  str(count) + " " + word + "s"
end

# Dératis contact facts, used by the layout and every page. Controllers do not
# need them; views cannot see app/services, hence helpers.
def deratis_phone
  "07 67 56 13 07"
end

def deratis_phone_uri
  "tel:+33767561307"
end

def deratis_email
  "contact@deratis.fr"
end

def deratis_facebook_url
  "https://www.facebook.com/deratis.fr/"
end

# The handset pictogram of every call button.
def phone_icon(css_class: String) -> String
  "<svg class=\"" + html_escape(css_class)
  + "\" viewBox=\"0 0 24 24\" fill=\"currentColor\" aria-hidden=\"true\">"
  + "<path d=\"M6.6 10.8a15.1 15.1 0 0 0 6.6 6.6l2.2-2.2a1 1 0 0 1 1-.25 11.4 11.4 0 0 0 3.6.57 1 1 0 0 1 1 1V20"
  + "a1 1 0 0 1-1 1A17 17 0 0 1 3 4a1 1 0 0 1 1-1h3.5a1 1 0 0 1 1 1c0 1.25.2 2.45.57 3.57a1 1 0 0 1-.25 1z\"/></svg>"
end

# Classes of a header link: underlined in yellow on the current section.
def nav_link_class(section: String, current) -> String
  base = "py-1 font-semibold text-ink no-underline border-b-[3px] "
  return base + "border-wasp" if section == current

  base + "border-transparent hover:border-rule"
end

# Options of the contact form's "which pest?" select, as [value, label].
# The values are ContactRequest.PESTS.
def contact_pest_choices
  [
    ["rats-souris", "Rats ou souris"],
    ["guepes-frelons", "Guêpes ou frelons"],
    ["punaises", "Punaises de lit"],
    ["cafards", "Cafards, blattes"],
    ["fourmis", "Fourmis"],
    ["autre", "Autre, je ne sais pas"]
  ]
end

# French text for HTML: escaped, with a no-break space before : ; ? ! so the
# sign never starts a line. Output it with <%- %>.
def fr_text(text) -> String
  escaped = html_escape(text.to_s);
  [" :", " ;", " ?", " !"].reduce(fn(html, sign) { html.replace(sign, "&nbsp;" + sign.trim) }, escaped)
end
