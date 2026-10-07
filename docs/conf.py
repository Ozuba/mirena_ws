# Sphinx configuration for the Mirena workspace documentation.

project = "Mirena Workspace"
author = "Miguel Oroz Zubasti"
copyright = "2026, Miguel Oroz Zubasti"
release = "0.1.0"

extensions = [
    "sphinx.ext.autosectionlabel",
    "sphinx.ext.todo",
    "sphinxcontrib.mermaid",
    "sphinx_copybutton",
]

# Section labels are prefixed with their document, so headings like
# "Parameters" can repeat across sensor pages without clashing.
autosectionlabel_prefix_document = True

templates_path = ["_templates"]
exclude_patterns = ["_build", "Thumbs.db", ".DS_Store"]

html_theme = "sphinx_rtd_theme"
html_static_path = ["_static"]
html_logo = "_static/images/logo.png"
html_theme_options = {
    "navigation_depth": 3,
    "collapse_navigation": False,
}

# Don't copy shell prompts when using the copy button
copybutton_prompt_text = r"\$ |>>> "
copybutton_prompt_is_regexp = True
