# frozen_string_literal: true

RSpotify.authenticate('c0f6f8ced9bd40d5a48c02261e75084d', '318ce89a30a948d496413109b3d41bf8')

# Now you can access playlists in detail, browse featured content and more

me = RSpotify::User.find('guilhermesad')
me.playlists #=> (Playlist array)
