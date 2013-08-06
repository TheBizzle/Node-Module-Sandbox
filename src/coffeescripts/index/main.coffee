
  require('../api/prototypes')
  require('./onload')

  [main, Obj, Opt] = [require('../main'),       require('../adt/obj'),        require('../adt/option')]
  [$, _]           = [require('../api/jquery'), require('../api/underscore')]

  [CardIterator, Cards]    = [require('./card-iterator'), require('./cards')]
  [Constants,    globals]  = [require('./constants'),     require('./globals')]
  [Element,      $globals] = [require('./element'),       require('./jglobals')]

  module.exports = class Index

    constructor: ->
      @_resetIterator()

    # (Event) => Unit
    handleRowKey: (event) ->
      switch (event.keyCode or event.which)
        when 13 then @addRow()
        else return

    # (Event) => Unit
    handleNumPickerKey: (event) ->
      switch (event.keyCode or event.which)
        when 13 then @genCards()
        else return

    # () => Unit
    clearErrorFuzz: ->
      $globals.$nameInput.removeClass('glowing-border')

    # () => Unit
    addRow: ->

      @clearErrorFuzz()

      $input = $globals.$nameInput
      name   = $input.val()

      if not _(name).isEmpty()
        if _(globals.playerNums).size() < Constants.MaxPlayerCount
          $input.val("")
          @_genRow(name)
      else
        $input.addClass('glowing-border')

    # (String) => Unit
    removeRow: (id) ->
      $.byID(id).remove()
      num = generateNumFromID(id)
      globals.playerNums = _(globals.playerNums).filter((n) -> n != num)

    # () => Unit
    genCards: ->

      @clearErrorFuzz()

      numCards   = parseInt($globals.$cardNumSpinner.val())
      maxCards   = new Obj(getCards()).filter((k, v) -> v.enabled).size() # Not really great, but... good enough, I guess --Jason (4/30/13)
      totalCards = _(globals.playerNums).size() * numCards

      if totalCards <= maxCards
        @_cleanupLastCardGen()
        _([0...numCards]).forEach((x) => @_genCardForEachPlayer())
      else
        msg = """You attempted to generate #{totalCards} cards, but there are only #{maxCards} available.
                |
                |Please reduce the number of cards or players and try again.
              """.stripMargin().trim()
        alert(msg)

    # (String) => String
    genCardImageURL: (name) ->
      _genCardImageURL(name)

    # (String) => String
    genPriorityImageURL: (name) ->
      "/assets/images/index/priority/#{name}.png"

    # (String) => Unit
    _genRow: (name) =>

      nums   = globals.playerNums
      num    = if _(nums).isEmpty() then 1 else (_(nums).last() + 1)
      id     = generatePlayerID(num)
      elemID = "#{id}-elem"

      globals.playerNums = nums.append(num)

      Element.generatePlayerRow(name, id, elemID, => @removeRow(id)).insertBefore($globals.$adderTable)

    # () => Unit
    _genCardForEachPlayer: =>
      _(globals.playerNums).map((num) -> generatePlayerID(num)).forEach((id) => @_insertCardForID(id))

    # (String) => Unit
    _insertCardForID: (id) =>

      card = @_cardIterator.next()

      if card?
        # Given how this is currently implemented, this number is irrelevant; if multiple of the same card can be drawn though,
        # this then make it so that ID collisions are unlikely. --Jason (6/8/13)
        safetyNum = 10000
        r         = Math.floor(Math.random() * safetyNum)
        cardID    = "#{card.slugify()}-#{r}"
        imgURL    = _genCardImageURL(card)
        column    = Element.generateCardEntryColumn(card, cardID, imgURL, Cards[card].faction)
        $.byID(id).find(".row-content-row").append(column)
      else
        alert("Card pool exhausted!  Pick fewer cards!")

    # () => Unit
    _cleanupLastCardGen: =>
      clearCardBuckets()
      @_resetIterator()

    # () => Unit
    _resetIterator: =>
      @_cardIterator = new CardIterator(getCards())

    # (String) => Unit
    makeImageVisible = (id) ->

      loaderID = "#{id}-loading"
      img      = $.byID(id)
      loader   = $.byID(loaderID)

      img.removeClass("hidden")
      loader.remove()

    # () => Unit
    clearCardBuckets = ->
      _(globals.playerNums).map((num) -> generatePlayerID(num)).forEach(
        (id) -> $.byID(id).find(".row-content-row").empty()
      )

    # (String) => String
    _genCardImageURL = (name) ->
      "/assets/images/index/#{name.slugify()}.png"

    # (String) => String
    generatePlayerID = (num) ->
      "player-#{num}"

    # (String) => Int
    generateNumFromID = (id) ->
      [[], num, []] = _(id).words("-")
      parseInt(num)

    # () => Obj[Object[Any]]
    getCards = ->

      cardObj = new Obj(Cards).clone().value()
      labels  = $globals.$cardHolder.children("label").map(-> $(this))

      _(labels).forEach(
        (elem) ->
          id   = elem.attr("for")
          name = elem.text()
          cardObj[name].enabled = $.byID(id)[0].checked
      )

      cardObj

