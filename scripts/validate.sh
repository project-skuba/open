#!/usr/bin/env bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Track validation status
VALIDATION_FAILED=0

echo "🔍 Starting validation..."
echo ""

# Determine which validator to use
VALIDATOR=""
if command -v ajv &> /dev/null; then
    VALIDATOR="ajv"
    echo "Using ajv-cli for validation"
elif command -v bunx &> /dev/null; then
    VALIDATOR="bunx"
    echo "Using bunx with ajv-cli for validation"
elif command -v npx &> /dev/null; then
    VALIDATOR="npx"
    echo "Using npx with ajv-cli for validation"
else
    echo -e "${RED}❌ ERROR: No JSON schema validator found.${NC}"
    echo ""
    echo "Please install Bun (https://bun.sh) or Node.js, or install ajv-cli globally:"
    echo "  npm install -g ajv-cli ajv-formats"
    echo ""
    exit 1
fi
echo ""

# Function to validate JSON against schema
validate_json_schema() {
    local json_file="$1"
    local schema_ref
    
    echo -e "${YELLOW}📄 Validating: ${json_file}${NC}"
    
    # Extract $schema reference from JSON file
    schema_ref=$(jq -r '."$schema" // empty' "$json_file")
    
    if [ -z "$schema_ref" ]; then
        echo -e "${RED}❌ ERROR: No \$schema reference found in ${json_file}${NC}"
        VALIDATION_FAILED=1
        return 1
    fi
    
    # Convert URL to local file path
    # Example: https://open.skuba.app/schemas/agencies/agencies.schema.v1.0.0.json
    # -> schemas/agencies/agencies.schema.v1.0.0.json
    local schema_file=$(echo "$schema_ref" | sed 's|https://open.skuba.app/||')
    
    if [ ! -f "$schema_file" ]; then
        echo -e "${RED}❌ ERROR: Schema file not found: ${schema_file}${NC}"
        VALIDATION_FAILED=1
        return 1
    fi
    
    echo "   Schema: $schema_file"
    
    # Create a temporary file for output
    local temp_output=$(mktemp)
    
    # Validate using ajv (either directly or via bunx/npx)
    local validation_status=0
    if [ "$VALIDATOR" = "ajv" ]; then
        ajv validate -s "$schema_file" -d "$json_file" --strict=false --all-errors > "$temp_output" 2>&1 || validation_status=$?
    elif [ "$VALIDATOR" = "bunx" ]; then
        bunx --bun ajv-cli validate -s "$schema_file" -d "$json_file" --strict=false --spec=draft2020 > "$temp_output" 2>&1 || validation_status=$?
    else
        npx --yes ajv-cli validate -s "$schema_file" -d "$json_file" --strict=false --spec=draft2020 > "$temp_output" 2>&1 || validation_status=$?
    fi
    
    if [ $validation_status -eq 0 ]; then
        echo -e "${GREEN}✅ Schema validation passed${NC}"
    else
        echo -e "${RED}❌ Schema validation failed${NC}"
        # Filter out noise from bun/npx output
        grep -v "^unknown format" "$temp_output" | \
        grep -v "^Resolving" | \
        grep -v "^Resolved," | \
        grep -v "^Saved lockfile" | \
        grep -v "^Installed" || true
        VALIDATION_FAILED=1
    fi
    
    rm -f "$temp_output"
    echo ""
}

# Function to check for duplicate IDs in a JSON dataset
check_duplicate_ids() {
    local json_file="$1"
    
    echo -e "${YELLOW}🔎 Checking for duplicate IDs in: ${json_file}${NC}"
    
    # Determine the array key based on filename
    local array_key=""
    if [[ "$json_file" == *"agencies.json"* ]]; then
        array_key="agencies"
    elif [[ "$json_file" == *"certifications"* ]]; then
        array_key="certifications"
    else
        # Try to find any array that contains objects with 'id' fields
        array_key=$(jq -r 'to_entries | map(select(.value | type == "array" and (.[0]? | has("id")))) | .[0].key // empty' "$json_file" 2>/dev/null || echo "")
    fi
    
    if [ -z "$array_key" ]; then
        echo -e "${BLUE}ℹ️  Could not determine array key for duplicate ID check, skipping${NC}"
        echo ""
        return 0
    fi
    
    # Extract all IDs and check for duplicates
    local duplicates
    duplicates=$(jq -r ".${array_key}[]? | .id? // empty" "$json_file" 2>/dev/null | sort | uniq -d || echo "")
    
    if [ -n "$duplicates" ] && [ "$duplicates" != "" ]; then
        echo -e "${RED}❌ ERROR: Duplicate IDs found:${NC}"
        echo "$duplicates" | while read -r dup_id; do
            if [ -n "$dup_id" ]; then
                echo -e "${RED}   - ${dup_id}${NC}"
            fi
        done
        VALIDATION_FAILED=1
    else
        echo -e "${GREEN}✅ No duplicate IDs found${NC}"
    fi
    
    echo ""
}

# Function to validate schema files themselves
validate_schema_file() {
    local schema_file="$1"
    
    echo -e "${YELLOW}📋 Validating schema file: ${schema_file}${NC}"
    
    # Check if file is valid JSON first
    if ! jq empty "$schema_file" 2>/dev/null; then
        echo -e "${RED}❌ ERROR: Invalid JSON in schema file${NC}"
        VALIDATION_FAILED=1
        return 1
    fi
    
    # Extract the $schema reference to determine which meta-schema to validate against
    local meta_schema
    meta_schema=$(jq -r '."$schema" // empty' "$schema_file" 2>/dev/null || echo "")
    
    if [ -z "$meta_schema" ]; then
        echo -e "${BLUE}ℹ️  No \$schema reference found, assuming draft-07${NC}"
        meta_schema="http://json-schema.org/draft-07/schema#"
    fi
    
    echo "   Meta-schema: $meta_schema"
    
    # Create a temporary file for output
    local temp_output=$(mktemp)
    
    # Validate the schema file against the meta-schema
    local validation_status=0
    if [ "$VALIDATOR" = "ajv" ]; then
        ajv compile -s "$schema_file" --strict=false > "$temp_output" 2>&1 || validation_status=$?
    elif [ "$VALIDATOR" = "bunx" ]; then
        bunx --bun ajv-cli compile -s "$schema_file" --strict=false --spec=draft2020 > "$temp_output" 2>&1 || validation_status=$?
    else
        npx --yes ajv-cli compile -s "$schema_file" --strict=false --spec=draft2020 > "$temp_output" 2>&1 || validation_status=$?
    fi
    
    if [ $validation_status -eq 0 ]; then
        echo -e "${GREEN}✅ Schema is valid${NC}"
    else
        echo -e "${RED}❌ Schema validation failed${NC}"
        grep -v "^unknown format" "$temp_output" | \
        grep -v "^Resolving" | \
        grep -v "^Resolved," | \
        grep -v "^Saved lockfile" | \
        grep -v "^Installed" || true
        VALIDATION_FAILED=1
    fi
    
    rm -f "$temp_output"
    echo ""
}

# Function to check if agency logos exist
check_agency_logos() {
    local json_file="$1"
    
    # Only check agencies.json
    if [[ "$json_file" != *"agencies.json"* ]]; then
        return 0
    fi
    
    echo -e "${YELLOW}🖼️  Checking agency logos in: ${json_file}${NC}"
    
    # Check if assets/agency-logos directory exists
    if [ ! -d "assets/agency-logos" ]; then
        echo -e "${RED}❌ ERROR: assets/agency-logos directory not found${NC}"
        VALIDATION_FAILED=1
        echo ""
        return 1
    fi
    
    # Extract all agency IDs
    local agency_ids
    agency_ids=$(jq -r '.agencies[]? | .id? // empty' "$json_file" 2>/dev/null || echo "")
    
    if [ -z "$agency_ids" ]; then
        echo -e "${BLUE}ℹ️  No agencies found in file${NC}"
        echo ""
        return 0
    fi
    
    local missing_logos=()
    local found_count=0
    local total_count=0
    
    # Check each agency for a corresponding logo file
    while IFS= read -r agency_id; do
        if [ -z "$agency_id" ]; then
            continue
        fi
        
        total_count=$((total_count + 1))
        
        # Check for both .svg and .png extensions
        local logo_svg="assets/agency-logos/${agency_id}.svg"
        local logo_png="assets/agency-logos/${agency_id}.png"
        
        if [ -f "$logo_svg" ] || [ -f "$logo_png" ]; then
            found_count=$((found_count + 1))
            if [ -f "$logo_svg" ]; then
                echo -e "${GREEN}   ✓ ${agency_id}.svg${NC}"
            else
                echo -e "${GREEN}   ✓ ${agency_id}.png${NC}"
            fi
        else
            missing_logos+=("$agency_id")
        fi
    done <<< "$agency_ids"
    
    echo ""
    
    # Report results
    if [ ${#missing_logos[@]} -gt 0 ]; then
        echo -e "${RED}❌ ERROR: Missing agency logos (${#missing_logos[@]} out of $total_count agencies)${NC}"
        echo -e "${RED}   Each agency must have a corresponding logo file in assets/agency-logos/${NC}"
        echo -e "${RED}   Logo files must be named with the agency ID and be either .svg or .png${NC}"
        echo ""
        echo -e "${RED}   Missing logos for:${NC}"
        for missing_id in "${missing_logos[@]}"; do
            echo -e "${RED}   - ${missing_id} (expected: ${missing_id}.svg or ${missing_id}.png)${NC}"
        done
        VALIDATION_FAILED=1
    else
        echo -e "${GREEN}✅ All ${total_count} agencies have logo files${NC}"
    fi
    
    echo ""
}

# Main validation logic
main() {
    # Check if jq is installed
    if ! command -v jq &> /dev/null; then
        echo -e "${RED}❌ ERROR: jq is required but not installed.${NC}"
        echo "Please install jq: https://jqlang.github.io/jq/download/"
        exit 1
    fi
    
    # ===== STEP 1: Validate Schema Files =====
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${BLUE}Step 1: Validating Schema Files${NC}"
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    echo ""
    
    if [ -d "schemas" ]; then
        local schema_files
        schema_files=$(find schemas -name "*.json" -type f 2>/dev/null || echo "")
        
        if [ -n "$schema_files" ]; then
            echo "Found schema files:"
            echo "$schema_files" | while read -r file; do
                if [ -n "$file" ]; then
                    echo "  - $file"
                fi
            done
            echo ""
            
            # Validate each schema file
            while IFS= read -r schema_file; do
                if [ -n "$schema_file" ] && [ -f "$schema_file" ]; then
                    validate_schema_file "$schema_file"
                fi
            done <<< "$schema_files"
        else
            echo -e "${YELLOW}⚠️  No schema files found in schemas directory${NC}"
            echo ""
        fi
    else
        echo -e "${YELLOW}⚠️  schemas directory not found${NC}"
        echo ""
    fi
    
    # ===== STEP 2: Validate Dataset Files =====
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${BLUE}Step 2: Validating Dataset Files${NC}"
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    echo ""
    
    # Check if datasets directory exists
    if [ ! -d "datasets" ]; then
        echo -e "${RED}❌ ERROR: datasets directory not found${NC}"
        echo "Please run this script from the project root directory."
        exit 1
    fi
    
    # Get all JSON files in datasets
    local json_files
    json_files=$(find datasets -name "*.json" -type f 2>/dev/null || echo "")
    
    if [ -z "$json_files" ]; then
        echo -e "${YELLOW}⚠️  No JSON files found in datasets directory${NC}"
    else
        echo "Found dataset files:"
        echo "$json_files" | while read -r file; do
            if [ -n "$file" ]; then
                echo "  - $file"
            fi
        done
        echo ""
        
        # Validate each JSON file
        while IFS= read -r json_file; do
            if [ -n "$json_file" ] && [ -f "$json_file" ]; then
                validate_json_schema "$json_file"
                check_duplicate_ids "$json_file"
                check_agency_logos "$json_file"
            fi
        done <<< "$json_files"
    fi
    
    # Final result
    echo "=========================================="
    if [ $VALIDATION_FAILED -eq 0 ]; then
        echo -e "${GREEN}✅ All validations passed!${NC}"
        exit 0
    else
        echo -e "${RED}❌ Validation failed. Please fix the errors above.${NC}"
        exit 1
    fi
}

# Run main function
main
