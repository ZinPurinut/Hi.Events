#!/bin/bash

# Script to hide DATE & TIME field in Ticket Display
# This will affect: Checkout Summary, Print Ticket, and Print All pages

set -e

FRONTEND_FILE="frontend/src/components/common/AttendeeTicket/index.tsx"
BACKUP_FILE="frontend/src/components/common/AttendeeTicket/index.tsx.backup"

echo "================================================"
echo "Disabling Date & Time in Ticket Display"
echo "================================================"

# Check if file exists
if [ ! -f "$FRONTEND_FILE" ]; then
    echo "❌ Error: File not found: $FRONTEND_FILE"
    exit 1
fi

# Create backup if it doesn't exist
if [ ! -f "$BACKUP_FILE" ]; then
    echo "📦 Creating backup..."
    cp "$FRONTEND_FILE" "$BACKUP_FILE"
    echo "✅ Backup created: $BACKUP_FILE"
fi

# Check if already disabled
if grep -q "{false && <div className={classes.detailRow}>" "$FRONTEND_FILE"; then
    echo "⚠️  Date & Time is already disabled!"
    exit 0
fi

echo "🔧 Modifying frontend code..."

# Use conditional rendering (false &&) to disable the Date & Time section
# This keeps valid JSX syntax and prevents rendering
sed -i '74s|<div className={classes.detailRow}>|{false \&\& <div className={classes.detailRow}>|' "$FRONTEND_FILE"
sed -i '79s|</div>|</div>}|' "$FRONTEND_FILE"

echo "✅ Date & Time field has been disabled!"
echo ""
echo "📍 This affects the following pages:"
echo "   • Checkout Summary (/checkout/{id}/summary)"
echo "   • Print Ticket (/product/{eventId}/{attendeeId})"
echo "   • Print All (/order/{eventId}/{orderId}/print)"
echo ""
echo "📌 Next steps:"
echo "   1. Rebuild the frontend:"
echo "      cd frontend && npm run build"
echo "   2. Restart Docker containers:"
echo "      cd docker/all-in-one && docker compose restart"
echo ""
echo "💡 To re-enable, run: ./enable-event-datetime.sh"
echo "================================================"
