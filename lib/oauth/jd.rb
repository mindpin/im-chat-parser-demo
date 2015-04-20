require 'net/http'

class Jd

  def initialize
    # @client_id = '89E48C4D5041C7BD089EC9A56F612CAA'
    # @client_secret = '18f1515f9cc14833b8609c8806b87497'
    # @access_token = '9b72660e-4b84-4144-ba81-ffb03bb9c522'

    @client_id = '7E2684D558A72C9AAB13E20317778614'
    @client_secret = '348fc4cb06b1418a956cffed7d864317'
    @access_token = '9024b342-b753-405b-ba6c-565db9cd7d39'

    @redirect_uri = 'https://serene-thicket-8391.herokuapp.com/'
    @method = '360buy.ware.get'
    @v = '2.0'

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


  def build_api_request(product_id)
    current_time = Time.now.to_s[0..18]
    str = "access_token#{@access_token}app_key#{@client_id}method#{@method}timestamp#{current_time}v#{@v}"
    str = 'appSecret' + str + 'appSecret'
    sign = Digest::MD5.hexdigest(str)


    host = 'http://gw.api.jd.com/routerjson'
    host + '?' + options = {
      :v => @v,
      :method => @method,
      :app_key => @client_id,
      :access_token => @access_token,
      :timestamp => current_time,
      :buy_param_json => "{'ware_id': #{product_id}}",
      :sign => sign
    }.to_query
  end


end