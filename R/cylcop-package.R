#' @rawNamespace import(stats, except = c(logLik, confint, profile, coef))
#' @import copula
#' @importFrom dplyr  %>% mutate
#' @importFrom purrr  modify_if map2_dbl map_dbl map pmap_dbl
#' @importFrom methods new is
#' @importFrom ggplot2 ggplot aes geom_point ylab xlab geom_hline
#' @importFrom ggplot2 element_blank element_line element_text
#' @importFrom ggplot2 theme_bw theme coord_polar unit
#' @importFrom ggplot2 geom_label geom_segment geom_ribbon geom_raster
#' @importFrom ggplot2 coord_fixed labs scale_colour_gradient geom_vline
#' @importFrom ggplot2 geom_hline geom_path geom_line geom_density geom_rect
#' @importFrom ggplot2 scale_fill_gradientn scale_colour_gradientn scale_x_continuous
#' @importFrom ggplot2 scale_y_continuous coord_flip element_rect scale_color_manual
#' @importFrom ggplot2 scale_size_continuous guides guide_legend scale_colour_discrete
#' @importFrom rlang .data is_missing
#' @importFrom utils head tail
#' @importFrom viridis inferno scale_fill_viridis
#' @importFrom plotly plot_ly add_trace add_surface
#' @importFrom circular rvonmises pvonmises dvonmises qvonmises circular bw.cv.ml.circular
#' @importFrom circular bw.nrd.circular mle.vonmises mle.wrappedcauchy density.circular
#' @importFrom movMF movMF
#' @importFrom Rdpack reprompt
#' @importFrom transport pgrid wpp semidiscrete wasserstein
#' @keywords internal
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL
