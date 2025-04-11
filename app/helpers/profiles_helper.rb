module ProfilesHelper
  def chat_exists?
    user = User.find_by(name: params[:name]); return false unless user
    Participant.exists?(chat_key: [Current.user.id, user.id].sort.join('-'))
  end
end
