class Jd

  def initialize
    @client_id = '89E48C4D5041C7BD089EC9A56F612CAA'
    @client_secret = '18f1515f9cc14833b8609c8806b87497'
    @redirect_uri = 'https://serene-thicket-8391.herokuapp.com/'

  end

  def build_url
    host = 'https://auth.360buy.com/oauth/authorize'
    host + '?' + options = {
      :response_type => 'code',
      :client_id => @client_id,
      :redirect_uri => @redirect_uri,
      :state => 'test'
    }.to_query
  end



  def get_access_token(code)
    url = "https://auth.360buy.com/oauth/token"

    url_params = {
      :grant_type => 'authorization_code',
      :client_id => @client_id,
      :redirect_uri => @redirect_uri,
      :code => code,
      :state => 'test',
      :client_secret => @client_secret
    }


    rx = Net::HTTP.post_form(URI.parse(url), url_params)

    body = rx.body
    JSON.parse(body)
  end


end