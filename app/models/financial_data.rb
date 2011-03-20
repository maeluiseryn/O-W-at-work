class FinancialData < ActiveRecord::Base
TVA_RATES=['21%','6%','0%']
TVA_RATES_FLOAT=[0.21,0.06,0]
belongs_to :client
validates :tva_rate ,:presence=>true ,:inclusion => {:in =>TVA_RATES  }
def self.get_tva_rate
  TVA_RATES
end
end
