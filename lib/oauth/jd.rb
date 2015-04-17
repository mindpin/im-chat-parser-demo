class Jd

  def initialize
    @client_id = '27BB2A6DC83C9CAD315E4EA4878D01AF'
    @client_secret = 'ff87960bcc3b4cf093ad6696a4844bd7'
    @redirect_uri = 'http://touch-vote-demo.herokuapp.com'

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