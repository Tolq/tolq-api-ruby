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

      create_fake_data(method, path, data)
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
    case [method, path]
    when [:get, '/translations/requests']
      [{ id: 1, status: 'in_translation' }]
    when [:post, '/translations/requests/1/order']
      { id: 1, status: 'in_translation' }
    when [:delete, '/translations/requests/1']
      { errors: [] }
    else
      data.merge(id: 1, status: 'pending')
    end
  end
end
