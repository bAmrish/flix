
module UsersHelper
  def profile_image(user)
    tag.img src: user.profile_image, class: 'profile-image'
  end
end
