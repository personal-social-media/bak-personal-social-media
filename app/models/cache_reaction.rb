# frozen_string_literal: true

# == Schema Information
#
# Table name: cache_reactions
#
#  id            :bigint           not null, primary key
#  reaction_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  subject_id    :string           not null
#
# Indexes
#
#  index_cache_reactions_on_subject_id  (subject_id)
#
class CacheReaction < ApplicationRecord
  str_enum :reaction_type, Reaction.reaction_types
end
