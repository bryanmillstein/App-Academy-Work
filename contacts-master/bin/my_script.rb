require 'addressable/uri'
require 'rest-client'


def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json',
  ).to_s

  p url

  puts RestClient.post(
    url,
    { user: { name: "Gizzard" } }
  )
end


def user_index
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json',
  ).to_s

  p url

  puts RestClient.get(url)

end

def user_update
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/update.json',
  ).to_s

  p url

  puts RestClient.patch(url, {:id => 1, :user => {:name => 'Bobby'}})

end

def user_destroy
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1.json',
  ).to_s

  p url

  puts RestClient.delete(url)

end

# begin
# # user_index
#   create_user
# rescue RestClient::UnprocessableEntity
# end

# user_destroy
user_index
