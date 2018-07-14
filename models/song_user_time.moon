db = require "lapis.db"
import Model from require "lapis.db.model"

import insert_on_conflict_update from require "helpers.models"

class SongUserTime extends Model
  @timestamp: true
  @primary_key: {"user_id", "song_id"}

  @relations: {
    {"user", belongs_to: "Users"}
    {"song", belongs_to: "songs"}
  }

  @increment: (opts={}) =>
    insert_on_conflict_update @, {
      song_id: assert opts.song_id, "missing song id"
      user_id: assert opts.user_id, "missing user id"
    }, {
      time_spent: opts.time_spent
    }, {
      time_spent: db.raw db.interpolate_query "#{db.escape_identifier @table_name!}.time_spent + excluded.time_spent"
    }


