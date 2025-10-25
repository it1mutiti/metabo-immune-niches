# === Reticulate Python binding fix ===
# Force R to use the system or Conda Python, not the temp cache.
# This ensures consistent R↔Python bridge in make segment2.
try({
  # Path to your main Conda python binary:
  reticulate::use_python("/home/irvine/miniconda3/bin/python3", required = FALSE)
}, silent = TRUE)
# === End reticulate fix ===

# === Project-scoped R audit logger (corrected final version) ===
options(warn = -1)  # suppress startup messages

# Always ensure we are in the project root
try(setwd(Sys.getenv("PROJECT_ROOT", unset = "~/metabo-immune-niches")), silent = TRUE)

# Ensure logs directory exists
log_dir <- "results/logs"
dir.create(log_dir, recursive = TRUE, showWarnings = FALSE)
log_file <- file.path(log_dir, "R_command_history.log")

# Write startup confirmation
cat(format(Sys.time()), ": INIT :: R audit logger active\n", file = log_file, append = TRUE)

# ---------------------------------------------------------------------------
# 1. Log every top-level R expression (interactive, -e, or scripts)
# ---------------------------------------------------------------------------
.add_log_callback <- function(expr, value, ok, visible) {
  try({
    expr_line <- tryCatch(deparse(expr, nlines = 1)[1], error = function(e) "<deparse failed>")
    timestamp <- format(Sys.time(), "%Y-%m-%d_%H:%M:%S")
    cat(sprintf("%s : %s\n", timestamp, expr_line), file = log_file, append = TRUE)
  }, silent = TRUE)
  TRUE
}
if (!"add_log_callback" %in% getTaskCallbackNames()) {
  try(addTaskCallback(.add_log_callback, name = "add_log_callback"), silent = TRUE)
}

# ---------------------------------------------------------------------------
# 2. Log runtime errors
# ---------------------------------------------------------------------------
options(error = function() {
  timestamp <- format(Sys.time(), "%Y-%m-%d_%H:%M:%S")
  msg <- sprintf("%s : ERROR :: %s\n", timestamp, geterrmessage())
  cat(msg, file = log_file, append = TRUE)
  q(status = 1)
})

# ---------------------------------------------------------------------------
# 3. Log sourced files for provenance
# ---------------------------------------------------------------------------
if (exists("trace", mode = "function")) {
  try(
    trace(base::source,
          tracer = quote({
            cat(paste0(format(Sys.time(), "%Y-%m-%d_%H:%M:%S"),
                       " : source(",
                       get("file", envir = parent.frame(), inherits = TRUE),
                       ")\n"),
                file = log_file, append = TRUE)
          }),
          print = FALSE),
    silent = TRUE
  )
}

# === End audit block ===
