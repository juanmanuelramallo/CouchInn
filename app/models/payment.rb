require 'net/http'
require 'uri'

class Payment < ActiveRecord::Base

  validates :cardNumber, length: { is: 16 }
  validates :cardCVV, length: { is: 3 }
  validate :expiration_date_cannot_be_in_the_past, on: :create

  MERCHANT_ID = "0000992"
  INTEGRATION_URL = "https://gateway.cardstream.com/direct/"
  KEY = 'DontTellAnyone'

  attr_accessor :cardNumber, :cardCVV, :cardExpiryMonth, :cardExpiryYear

  def expiration_date_cannot_be_in_the_past
    if cardExpiryYear.to_i < Date.today.year && cardExpiryMonth.to_i < Date.today.month
      errors.add(:expiration_date, "- La fecha de expiración no puede estar en el pasado, duh!?")
    end
  end

  def payment_params
    params.require(:payment).permit(:responseMessage, :amount, :amountReceived, :cardNumberMask,
  :cardType, :cardTypeCode, :responseCode, :transactionID, :xref, :cardNumber,
  :cardCVV, :cardExpiryMonth, :cardExpiryYear)
  end


  def request_data
    {
      :amount => '19',
      :cardNumber => self.cardNumber,
      :cardExpiryMonth => self.cardExpiryMonth.to_i,
      :cardExpiryYear => self.cardExpiryYear.to_i,
      :cardCVV => self.cardCVV.to_i,
      :merchantID => MERCHANT_ID,
      :action => "SALE",
      :type => 1,
      :currencyCode => 826,
      :orderRef => "Test purchase",
      :countryCode => 826,
      :returnInternalData => "Y",
      :threeDSRequired => "N",
    }
  end

  def credit_card_api_access
    uri = URI.parse(INTEGRATION_URL)
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri)
    req.set_form_data(request_data)
    response = http.request(req)
    response_hash = Rack::Utils.parse_nested_query response.body
    if response_hash['responseCode'] != "0"
      errors.add(:id, "del pago erróneo #{response_hash['responseMessage']}")
    else
      self.attributes = strip_cc_response_hash(response_hash)
    end
  end

  def strip_cc_response_hash(hsh)
    hsh.each { |key,value| hsh.delete(key) unless Payment.column_names.include?(key)}
    return hsh
  end

end
