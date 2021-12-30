# frozen_string_literal: true

module DeviseHelper
  def provider_name(provider)
    case provider.to_s
    when 'spotify'
      'Spotify'
    else
      'provider não encontrado'
    end
  end

  def provider_links(url, provider)
    case provider.to_s
    when 'spotify'
      spotify_link(url)
    else
      'provider não encontrado'
    end
  end

  def spotify_link(url)
    button_to url, class: 'btn btn-primary btn-block', method: :post, data: { turbo: 'false' } do
      '<i class="fab fa-twitter mr-1"></i><span>Spotify</span>'.html_safe
    end
  end
end
