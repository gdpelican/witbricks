$('.view-brick').hide()
wrapper = $('.flex-wrapper')
wrapper.find('.briquette[data-id=<%= @brick.id %>]').css('visibility', 'hidden')
wrapper.append("<%= render_partial 'preview' %>")