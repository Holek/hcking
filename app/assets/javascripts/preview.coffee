
$ ->
  $('.preview .show-comment').click (event)->
    event.preventDefault()

    return if ($ this).hasClass('active')

    new HckingPreview().hide_preview(($ this).parents('form'))
    ($ this).addClass('active')
    ($ this).siblings('.show-preview').removeClass('active')

  $('.preview .show-preview').click (event)->
    event.preventDefault()

    return if ($ this).hasClass('active')

    new HckingPreview().transform_to_preview(($ this).parents('form'))
    ($ this).addClass('active')
    ($ this).siblings('.show-comment').removeClass('active')

HckingPreview = ->
  hide_preview: (base_form) ->
    container = ($ base_form).find('.previewable')
    container.find('.preview-display').hide()
    container.find('.preview-base').show()

  transform_to_preview: (base_form) ->
    container = ($ base_form).find('.previewable')
    preview_base = container.find('.preview-base')
    preview_display = container.find('.preview-display')

    if preview_display.size() == 0
      preview_display = ($ document.createElement('div'))
      .addClass('preview-display')
      .height(preview_base.height())
      .width(preview_base.width())
      .appendTo(container)

    markdown = this.convert_to_markdown(preview_base.val())
    preview_base.hide()
    preview_display.html(markdown).show()

  convert_to_markdown: (html_text) ->
    converter = new Showdown.converter()
    converter.makeHtml(html_text)


