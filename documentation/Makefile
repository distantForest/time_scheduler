# Variables
INPUT_MD      = ARCHITECTURE.md  # Default input (change as needed)
OUTPUT_HTML   = $(INPUT_MD:.md=.html)
OUTPUT_DOCX   = $(INPUT_MD:.md=.docx)
REFERENCE_DOC = custom-reference.docx
RESOURCE_PATH = .:media
DPI           = 600
PANDOC_FLAGS  = --resource-path=$(RESOURCE_PATH) --reference-doc=$(REFERENCE_DOC) --dpi=$(DPI) --verbose

# Default target (build .docx)
all: $(OUTPUT_DOCX)

# Step 1: Markdown -> HTML
$(OUTPUT_HTML): $(INPUT_MD)
	pandoc $(PANDOC_FLAGS) \
	-f markdown+raw_html+raw_attribute \
	--to=html \
	$< -o $@

# Step 2: HTML -> DOCX
$(OUTPUT_DOCX): $(OUTPUT_HTML)
	pandoc $(PANDOC_FLAGS) \
	-f html \
	--to=docx-auto_identifiers+styles+gfm_auto_identifiers \
	$< -o $@

# Cleanup
clean:
	rm -f $(OUTPUT_HTML) $(OUTPUT_DOCX)

.PHONY: all clean

