module ApplicationHelper
    #this is for the gravatar helper it uses a MD% hash that need to be transformed so Rails can use it.
    def gravatar_for(user, options = { size: 80})
        
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: "img-circle")
    end
end
