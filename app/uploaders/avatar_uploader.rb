# frozen_string_literal: true

# This is a subclass of Shrine base that will be further configured for it's requirements.
# This will be included in the model to manage the file.
class AvatarUploader < Shrine
  ALLOWED_TYPES  = %w[image/jpeg image/png image/webp].freeze
  MAX_SIZE       = 10 * 1024 * 1024 # 10 MB
  MAX_DIMENSIONS = [2000, 2000].freeze # 5000x5000

  THUMBNAILS = {
    small: [40, 40],
    medium: [200, 200],
    large: [800, 800]
  }.freeze

  plugin :remove_attachment
  plugin :pretty_location
  plugin :validation_helpers
  plugin :store_dimensions, log_subscriber: nil
  plugin :derivation_endpoint, prefix: 'derivations/avatar'

  # File validations (requires `validation_helpers` plugin)
  Attacher.validate do
    validate_size 0..MAX_SIZE

    validate_max_dimensions MAX_DIMENSIONS if validate_mime_type ALLOWED_TYPES
  end

  # Thumbnails processor (requires `derivatives` plugin)
  Attacher.derivatives do |original|
    THUMBNAILS.transform_values do |(width, height)|
      ::ImgProcessing::GenerateThumbnail.call(original, width, height) # lib/generate_thumbnail.rb
    end
  end

  # Default to dynamic thumbnail URL (requires `default_url` plugin)
  Attacher.default_url do |derivative: nil, **|
    file&.derivation_url(:thumbnail, *THUMBNAILS.fetch(derivative)) if derivative
  end

  # Dynamic thumbnail definition (requires `derivation_endpoint` plugin)
  derivation :thumbnail do |file, width, height|
    ::ImgProcessing::GenerateThumbnail.call(file, width.to_i, height.to_i) # lib/generate_thumbnail.rb
  end
end
