module TwentySix
  class Core
    require 'httparty'
    require 'deep_merge'
    include HTTParty
    base_uri 'https://api.tech26.de'

    def self.authenticate(username, password)
      response = post('/oauth/token',
                      body: {
                        'username' => username,
                        'password' => password,
                        'grant_type' => 'password'
                      },
                      headers: {
                        'Authorization' => 'Basic bXktdHJ1c3RlZC13ZHBDbGllbnQ6c2VjcmV0',
                        'User-Agent' => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36'
                      })
      if response['access_token']
        new(response['access_token'])
      else
        response
      end
    end

    def initialize(access_token)
      @access_token = access_token
    end

    def whoami
      get '/api/me'
    end

    def account_summary
      get '/api/accounts'
    end

    def addresses
      get '/api/addresses'
    end

    def contacts
      get '/api/smrt/contacts'
    end

    def categories
      get '/api/smrt/categories'
    end

    def card_with_id(id)
      get "/api/cards/#{id}"
    end

    def cards
      get '/api/cards'
    end

    def card_limits(card_id)
      get "/api/settings/limits/#{card_id}"
    end

    def update_card_limits(card_id, limits)
      post "/api/settings/limits/#{card_id}", options: { body: limits }
    end

    def statements
      get '/api/statements'
    end

    def statement(id, pdf: false)
      prefix = if pdf
                 ''
               else
                 'json/'
               end
      get "/api/statements/#{prefix}#{id}", options: { headers: { 'Content-Type' => 'application/json' } }
    end

    def transactions(count: 50,
                     include_pending: false,
                     text_filter: nil,
                     from_time: nil,
                     to_time: nil)
      query = {
        limit: count,
        pending: include_pending
      }

      if from_time && to_time
        query['from'] = from_time.to_i
        query['to'] = to_time.to_i
      end

      query['textFilter'] = text_filter if text_filter

      get '/api/smrt/transactions', options: { query: query }
    end

    def transaction(id)
      get "/api/transactions/#{id}"
    end

    def transaction_metadata(smartlink_id)
      get "/api/transactions/#{smartlink_id}/metadata"
    end

    def create_transfer(pin, name, iban, bic, amount, reference)
      post '/api/transactions', options: {
        body: {
          pin: pin,
          transaction: {
            partnerName: name,
            partnerBic: bic,
            partnerIban: iban,
            amount: amount,
            referenceText: reference,
            type: 'DT'
          }
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      }
    end

    def barzahlen_summary
      get '/api/barzahlen/check'
    end

    def block_card(card_id)
      post "/api/cards/#{card_id}/block"
    end

    def unblock_card(card_id)
      post "/api/cards/#{card_id}/unblock"
    end

    private

    def get(uri, options: {})
      opts = default_options
      opts.deep_merge!(options)
      self.class.get(uri, opts)
    end

    def post(uri, options: {})
      opts = default_options
      opts.deep_merge!(options)
      self.class.post(uri, opts)
    end

    def default_options
      { headers: default_headers }
    end

    def default_headers
      {
        'Authorization' => "Bearer #{@access_token}"
      }
    end
  end
end
