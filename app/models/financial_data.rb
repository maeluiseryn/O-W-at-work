class FinancialData < ActiveRecord::Base
TVA_RATES=['21%','6%']
TVA_RATES_FLOAT=[0.21,0.06]
belongs_to :client
end
