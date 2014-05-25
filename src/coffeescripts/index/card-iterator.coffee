define(['api/prototypes', 'api/jquery', 'adt/iterator', 'adt/obj'], ([],               $,            Iterator,       Obj) ->

  class CardIterator extends Iterator

    iterateFunc = (p) =>

      iterateHelper = (pool) ->

        num  = Math.floor(Math.random() * pool.size())
        card = pool.fetchKeyByIndex(num)

        if not card?
          [card, pool]
        else
          cardObj = pool.get(card)
          newPool = pool.without(card)
          if cardObj.enabled
            [card, newPool]
          else
            iterateHelper(newPool)

      iterateHelper(p)

    # state: Object[T]
    constructor: (state) ->
      super(new Obj(state), iterateFunc)

  CardIterator

)
