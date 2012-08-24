module ClientsHelper
  
  def client_kind_for_client
    Client::CLIENT_KINDS.map { |n, v| [t("view.clients.client_kind.#{n}"), v] }
  end
  
  def bill_kind_for_client
    ['A','B','C','X']
  end

  def uic_type_for_client
    ['CUIT', 'CUIL']
  end
  
  def get_client_kind_symbol_from_value(value)
    Client::CLIENT_KINDS.invert[value]
  end
end
