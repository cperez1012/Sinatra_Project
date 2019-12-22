module Slugifiable
  module ClassMethods
    def self.find_by_slug(slug)
      User.all.find{|user| user.slug == slug}
    end
  end

  module InstanceMethods
    def slug
      self.username.downcase.gsub(" ","-")
    end
  end
end
