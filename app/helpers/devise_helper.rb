module DeviseHelper

  def devise_error_messages!
    return "" if resource.errors.empty?

    html = ""
    messages = resource.errors.full_messages.each do |msg|
      html += <<-EOF
      <div class="devise-error__alert alert-danger alert-dismissible" role="alert">
        <li class="devise-error__msg">#{msg}</p>
      </div>
      EOF
    end
    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end
