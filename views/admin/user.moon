
import Users, HourlyHits from require "models"

class AdminHome extends require "widgets.page"
  @needs: {"users", "songs", "counts"}

  inner_content: =>
    h1 "User"
    h2 @user\name_for_display!

    element "table", ->
      tr ->
        td "username"
        td @user.username

      tr ->
        td "display_name"
        td @user.display_name

      tr ->
        td "email"
        td @user.email

      tr ->
        td "slug"
        td @user.slug

      tr ->
        td "last_active_at"
        td @user.last_active_at

      tr ->
        td "created_at"
        td @user.created_at

    @render_counts!

  render_counts: =>
    h2 "Recent hits"
    element "table", ->
      thead ->
        tr ->
          td "day"
          td "type"
          td "count"

      for tuple in *@counts
        tr ->
          td tuple.date
          td HourlyHits.types[tuple.type]
          td tuple.count

