class TestClient
  attr_reader :received

  def get(path)
    @received = {
      path: path,
      data: nil
    }
  end

  def post(path, data)
    @received = {
      path: path,
      data: data
    }

    data.merge(id: 1, status: 'pending')
  end

  def delete(path)
    @received = {
      path: path,
      data: nil
    }
  end

  def put(path, data)
    @received = {
      path: path,
      data: data
    }
  end
end
