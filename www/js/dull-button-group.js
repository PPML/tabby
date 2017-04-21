var barInputBinding = new Shiny.InputBinding();

$.extend(barInputBinding, {
  find: function(scope) {
    return $(scope).find('.dull-input-bar');
  },

  getValue: function(el) {
    return $('input:radio[name="' + Shiny.$escape(el.id) + '"]:checked').val();
  },

  setValue: function(el, value) {
    $('input:radio[name="' + Shiny.$escape(el.id) + '"][value="' + Shiny.$escape(value) + '"]').prop('checked', true);
  },

  getState: function(el) {
    var $objs = $('input:radio[name="' + Shiny.$escape(el.id) + '"]');

    var options = new Array($objs.length);
    for (var i = 0; i < options.length; i++) {
      options[i] = {
        value: $objs[i].value,
        label: this._getLabel($objs[i])
      };
    }

    return {
      label: $(el).parent().find('label[for="' + Shiny.$escape(el.id) + '"]').text(),
      value: this.getValue(el),
      options: options
    };
  },

  receiveMessage: function(el, data) {
    var $el = $(el);

    if (data.hasOwnProperty('options')) {
      $el.find('.dull-options-group').remove();
      $el.append(data.options);
    }

    if (data.hasOwnProperty('value')) {
      this.setValue(el, data.value);
    }

    if (data.hasOwnProperty('label')) {
      $(el).parent().find('label[for="' + Shiny.$escape(el.id) + '"]').text(data.label);
    }

    $(el).trigger('change');
  },

  subscribe: function(el, callback) {
    $(el).on('change.barInputBinding', function(event) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off('.barInputBinding');
  },

  _getLabel: function(obj) {
    if (obj.parentNode.tagName === "LABEL") {
      return $.trim($(obj.parentNode).find('span').text());
    }

    return null;
  },

  _setLabel: function(obj, value) {
    if (obj.parentNode.tagName === "LABEL") {
      $(obj.parentNode).find('span').text(value);
    }

    return null;
  }

});

Shiny.inputBindings.register(barInputBinding, 'dull.barInput');
