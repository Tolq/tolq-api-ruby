class TestClient
  attr_reader :received

  [:get, :post, :delete, :put].each do |method|
    define_method method do |path, data = nil|
      @received = {
        path: path,
        method: method,
        data: data
      }

      errors = validate(data)
      return { errors: errors } if errors.any?

      response = create_fake_data(method, path, data)
      Tolq::Api::Response.new(status: response[:status], body: response[:body])
    end
  end

  private

  def validate(received)
    errors = []
    return errors unless received
    if received.keys.find { |k| k.to_s == 'request' }.nil?
      errors.push('Missing required parameter: request')
    end
    errors
  end

  def create_fake_data(method, path, data)
    result = case [method, path]
             when [:get, '/translations/requests']
               { status: 200, body: [{ id: 1, status: 'in_translation' }] }
             when [:get, "/translations/requests/1"]
               { status: 200, body: { id: 1, status: 'in_translation'} }
             when [:post, '/translations/requests/1/order']
               { status: 201, body: { id: 1, status: 'in_translation' } }
             when [:delete, '/translations/requests/1']
               { status: 200, body: { errors: [] } }
             else
               { status: 201, body: data.merge(id: 1, status: 'pending') }
             end

    result[:body] = result[:body].to_json
    result
  end
end
