class FinancialData < ActiveRecord::Base
TVA_RATES=['21%','6%','0%']
TVA_RATES_FLOAT=[0.21,0.06,0]
belongs_to :client
end
