module DeviseHelper

  def devise_error_messages!
    return "" if resource.errors.empty?

    html = ""
    messages = resource.errors.full_messages.each do |msg|
      html += <<-EOF
      <div class="alert alert-danger alert-dismissible" role="alert">
        <p class="devise_error_msg">#{msg}</p>
      </div>
      EOF
    end
    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end
