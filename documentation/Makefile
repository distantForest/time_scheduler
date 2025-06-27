# Variables
INPUT_MD_FILES = AGSTU_Time_Scheduler.md INTRODUCTION.md requirement_specification.md TEST_PROTOCOL.md \
                  ARCHITECTURE.md VERIFICATION.md \
                  VALIDATION.md # 
TITLE_PAGE     = title-page.docx      # Your preformatted title page
OUTPUT_DOCX    = REPORT.docx          # Final output (with title)
NO_TITLE_DOCX  = REPORT-no-title.docx # Output without title
TEMP_DOCX      = temp-content.docx    # Intermediate file
REFERENCE_DOC  = custom-reference.docx
RESOURCE_PATH  = .:media
DPI            = 600
PANDOC_FLAGS   = --resource-path=$(RESOURCE_PATH) \
                 --reference-doc=$(REFERENCE_DOC) \
                 --dpi=$(DPI) \
                 --toc \
                 --toc-depth=3\
                 --verbose

# Default target (prints instructions for manual merge)
all: $(TEMP_DOCX)
	@echo "\n=== MANUAL STEP REQUIRED ==="
	@echo "1. Open '$(TITLE_PAGE)' and '$(TEMP_DOCX)' in Microsoft Word"
	@echo "2. Copy ALL content from '$(TEMP_DOCX)'"
	@echo "3. Paste it AFTER the title page in '$(TITLE_PAGE)'"
	@echo "4. Save the combined file as '$(OUTPUT_DOCX)'\n"
	@touch $(OUTPUT_DOCX)  # Fake target fulfillment

# Target for document WITHOUT title (fully automated)
no-title: $(NO_TITLE_DOCX)

# Convert all .md to single .docx (base content)
$(TEMP_DOCX): $(INPUT_MD_FILES)
	pandoc $(PANDOC_FLAGS) \
	-f markdown+raw_html+raw_attribute \
	--to=docx-auto_identifiers+styles+gfm_auto_identifiers \
	$(INPUT_MD_FILES) -o $@

	pandoc $(PANDOC_FLAGS) -f markdown+raw_html -t html $(INPUT_MD_FILES) -s -o temp.html
	pandoc $(PANDOC_FLAGS) -f html -t docx temp.html -N -o $@
	rm -f temp.html

# Output without title (just copy temp file)
$(NO_TITLE_DOCX): $(TEMP_DOCX)
	cp $(TEMP_DOCX) $@
	@echo "Built '$@' (no title page)."

# Cleanup
clean:
	rm -f $(TEMP_DOCX) $(OUTPUT_DOCX) $(NO_TITLE_DOCX)

.PHONY: all no-title clean

