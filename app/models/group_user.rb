# frozen_string_literal: true
# 中間テーブル
class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
