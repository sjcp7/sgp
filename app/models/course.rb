class Course < ApplicationRecord
  enum kind: { puniv: 'PUNIV', technical: 'Técnico' }
end
