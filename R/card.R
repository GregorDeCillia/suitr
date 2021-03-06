#' decks of 52 cards
#'
#' Functions that extract information from a card
#'
#' @param card a card. A list of available cards can be found with `card_list()`
#' @inheritParams suit_color
#' @inheritParams unicode_html
#'
#' @examples
#' # show all valid cards
#' card_list()
#'
#' # determine rank and suit and color
#' card_rank("Jc")
#' card_suit("7d")
#' card_color("Ad")
#' card_color("Ad", four_color = FALSE)
#'
#' # style cards either in the console or via HTML
#' cat(card_unicode("5h"), "\n")
#' cat(card_style("5h"), "\n")
#' card_html("5h")
#'
#' # iterate over several cards for styling
#' card_list() %>% sapply(card_style) %>% cat("\n")
#' card_list() %>% lapply(card_html, 70) %>% span() %>% browsable()
#' @rdname card
#' @export
card_list <- function() {
  lapply(rank_list(), function(rank) {
    lapply(suit_list(), function(suit) {
      paste0(rank, suit)
    })
  }) %>% unlist
}

#' @rdname card
#' @export
card_suit <- function(card = card_list()) {
  card <- match.arg(card)
  suit <- substr(card, 2, 2)
  match.arg(suit, suit_list())
}

#' @rdname card
#' @export
card_rank <- function(card = card_list()) {
  card <- match.arg(card)
  rank <- substr(card, 1, 1)
  match.arg(rank, rank_list())
}

#' @rdname card
#' @export
card_style <- function(card = card_list(), four_color = TRUE) {
  requireNamespace("crayon")
  color <- card_color(card = card, four_color = four_color)
  crayon::style(card_unicode(card), color)
}

#' @rdname card
#' @export
card_color <- function(card = card_list(), four_color = TRUE) {
  suit_color(card_suit(card), four_color)
}

#' @rdname card
#' @export
card_html <- function(card = card_list(), size = 172, four_color = TRUE) {
  card %>%
    card_htmlhex %>%
    HTML %>%
    unicode_html(
      size,
      style = paste0("color:", card_color(card, four_color))
    )
}

#' @rdname card
#' @export
card_specials <- function() {
  list(
    `black joker` = "\uD83C\uDCCF",
    `white joker` = "\uD83C\uDCDF",
    back = "\uD83C\uDCA0"
  )
}

#' @rdname card
#' @export
card_htmlhex <- function(card = card_list()) {
  card <- match.arg(card)
  suit_str <- switch(card_suit(card), s = "a", h = "b",
                     d = "c", c = "d")
  rank_str <- switch(card_rank(card), A = 1, K = "e", Q = "d",
                     J = "b", T = "a", card_rank(card))
  paste0("&#x1f0", suit_str, rank_str, ";")
}
