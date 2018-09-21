class Pessoa < ActiveRecord::Base
  self.table_name = 'PESSOA'
  self.primary_key = 'codpes'
end
