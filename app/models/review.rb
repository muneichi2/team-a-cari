class Review < ApplicationRecord
  enum review: { "良い": 0, "普通": 1, "悪い": 2}
end
