# Variables
INPUT_MD      = ARCHITECTURE.md VERIFICATION.md VALIDATION.md # Default input (change as needed)
OUTPUT_HTML   = $(INPUT_MD:.md=.html)
OUTPUT_DOCX   = REPORT.docx
REFERENCE_DOC = custom-reference.docx
RESOURCE_PATH = .:media
DPI           = 600
PANDOC_FLAGS  = --resource-path=$(RESOURCE_PATH) --reference-doc=$(REFERENCE_DOC) --dpi=$(DPI) --verbose

# Default target (build .docx)
all: $(OUTPUT_DOCX)

$(OUTPUT_DOCX): $(INPUT_MD)
	pandoc $(PANDOC_FLAGS) -f markdown+raw_html -t html $(INPUT_MD) -o temp.html
	pandoc $(PANDOC_FLAGS) -f html -t docx temp.html -o $@
	rm -f temp.html

# Step 1: Markdown -> HTML
# $(OUTPUT_HTML): $(INPUT_MD)
# 	pandoc $(PANDOC_FLAGS) \
# 	-f markdown+raw_html+raw_attribute \
# 	--to=html \
# 	$< -o $@

# # Step 2: HTML -> DOCX
# $(OUTPUT_DOCX): $(OUTPUT_HTML)
# 	pandoc $(PANDOC_FLAGS) \
# 	-f html \
# 	--to=docx-auto_identifiers+styles+gfm_auto_identifiers \
# 	$< -o $@

# Cleanup
clean:
	rm -f $(OUTPUT_HTML) $(OUTPUT_DOCX)

.PHONY: all clean

# # Variables
# INPUT_MD_FILES = INTRO.md CHAPTER1.md APPENDIX.md  # <-- EDIT THIS LIST!
# OUTPUT_DOCX    = REPORT.docx
# REFERENCE_DOC  = custom-reference.docx
# RESOURCE_PATH  = .:media
# DPI            = 600
# PANDOC_FLAGS   = --resource-path=$(RESOURCE_PATH) \
#                  --reference-doc=$(REFERENCE_DOC) \
#                  --dpi=$(DPI) \
#                  --verbose

# # Default target
# all: $(OUTPUT_DOCX)

# # Merge all .md files -> single .docx
# $(OUTPUT_DOCX): $(INPUT_MD_FILES)
# 	pandoc $(PANDOC_FLAGS) \
# 	-f markdown+raw_html+raw_attribute \
# 	--to=docx-auto_identifiers+styles+gfm_auto_identifiers \
# 	$(INPUT_MD_FILES) -o $@

# clean:
# 	rm -f $(OUTPUT_DOCX)

# .PHONY: all clean
