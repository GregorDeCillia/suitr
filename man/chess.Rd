% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chess.R
\name{pieces_list}
\alias{pieces_list}
\alias{chess_unicode}
\alias{chess_html}
\title{chess pieces}
\usage{
pieces_list()

chess_unicode(piece = pieces_list(), color = c("white", "black"))

chess_html(piece = pieces_list(), color = c("white", "black"),
  size = 172)
}
\arguments{
\item{piece}{a chess piece. Valid values can be found via \code{pieces_list()}}

\item{color}{the color of the chess pieces. Valid values are white and black}

\item{size}{the font-size to use}
}
\description{
Functions to create Unicode chess pieces and export them to HTML
}
\examples{
cat(chess_unicode("k"))

chess_html("r")
chess_html("n", color = "black")

white <- pieces_list() \%>\% lapply(chess_html, color = "white")
black <- pieces_list() \%>\% lapply(chess_html, color = "black")
span(div(white), div(black)) \%>\% browsable()
}
