var checkboxInputBinding = new Shiny.InputBinding();

$.extend(checkboxInputBinding, {
  find: function(scope) {
    return $(scope).find(".dull-input-checkboxgroup");
  },

  getId: function(el){
    return el.id;
  },

  getValue: function(el) {
    var $objs = $('input:checkbox[name="' + Shiny.$escape(el.id) + '"]:checked');
    var values = new Array($objs.length);
    for (var i = 0; i < $objs.length; i++) {
      values[i] = $objs[i].value;
    }
    return values;
  },
  setValue: function(el, value) {
    // TODO
  },
  getState: function(el) {
    var $objs = $('input:checkbox[name="' + Shiny.$escape(el.id) + '"]');

    var options = new Array($objs.length);
    for (var i = 0; i < options.length; i++) {
      options[i] = {
        value: $objs[i].value,
        label: this._getLabel($objs[i])
      };
    }

    return {
      label: $(el).find('label[for="' + Shiny.$escape(el.id) + '"]').text(),
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
      $(el).parent().
        find('label[for="' + Shiny.$escape(el.id) + '"]')
        .text(data.label);
    }

    $(el).trigger('change');
  },
  subscribe: function(el, callback) {
    $(el).on('change.checkboxInputBinding', function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off('.checkboxInputBinding');
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

Shiny.inputBindings.register(checkboxInputBinding, "dull.checkboxInput");
