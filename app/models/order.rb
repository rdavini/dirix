class Order < ApplicationRecord
    belongs_to :organization
    belongs_to :address

    def get_status
        if self.end_time and self.start_time
            return "finalizado"
        elsif self.start_time
            return "em andamento"
        else
            return "não iniciado"
        end
    end
end
