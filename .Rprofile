# ============================================================
# .Rprofile — Metabo-Immune Niches Project
# Purpose: Enable reproducibility, auditing, and R↔Python bridge logging
# ============================================================

# Silence startup diagnostics (optional)
options(warn = -1)

# Create results/logs directory if missing
dir.create("results/logs", showWarnings = FALSE, recursive = TRUE)

# Log initialization
cat(format(Sys.time(), "%F %T"), ": INIT :: .Rprofile loaded\n",
    file = "results/logs/R_command_history.log", append = TRUE)

# ---- R audit logger ----
.add_log_callback <- function(expr, value, ok, visible) {
  # Capture and log top-level commands or errors
  try({
    ts <- format(Sys.time(), "%F_%T")
    cmd <- paste(deparse(expr)[1], collapse = " ")
    if (!ok) {
      msg <- geterrmessage()
      cat(ts, ": ERROR ::", msg, "\n",
          file = "results/logs/R_command_history.log", append = TRUE)
    } else {
      cat(ts, ":", cmd, "\n",
          file = "results/logs/R_command_history.log", append = TRUE)
    }
  }, silent = TRUE)
  return(TRUE)
}

# Register callback safely
try({
  addTaskCallback(.add_log_callback, name = "R_audit_logger")
  cat(format(Sys.time(), "%F %T"), ": INIT :: R audit logger active\n",
      file = "results/logs/R_command_history.log", append = TRUE)
}, silent = TRUE)

# ---- Reticulate bridge configuration ----
suppressPackageStartupMessages({
  if (requireNamespace("reticulate", quietly = TRUE)) {
    try({
      # Prefer Conda Python (used in Segment 2 verification)
      reticulate::use_condaenv("metabo-immune-niches", required = FALSE)
      # Fallback to system python
      if (!reticulate::py_available(initialize = FALSE)) {
        reticulate::use_python(Sys.which("python3"), required = FALSE)
      }
      # Verify bridge
      suppressPackageStartupMessages(library(reticulate))
      cat(format(Sys.time(), "%F_%T"),
          ": suppressPackageStartupMessages(library(reticulate))\n",
          file = "results/logs/R_command_history.log", append = TRUE)
      cat(format(Sys.time(), "%F_%T"),
          ": cat(\"Python from R:\", py_config()$python, \"\\n\")\n",
          file = "results/logs/R_command_history.log", append = TRUE)
    }, silent = TRUE)
  }
})

# ---- Final message ----
cat(format(Sys.time(), "%F %T"), ": INIT COMPLETE :: R audit ready\n",
    file = "results/logs/R_command_history.log", append = TRUE)
# ============================================================
