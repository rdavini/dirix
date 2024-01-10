class Order < ApplicationRecord
    belongs_to :address
    belongs_to :ride, optional: true
    belongs_to :organization

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
