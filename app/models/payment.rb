require 'net/http'
require 'uri'

class Payment < ActiveRecord::Base

  attr_accessor :cardNumber, :cardCVV, :cardExpiryMonth, :cardExpiryYear


end
