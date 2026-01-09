#!/bin/bash

# Script to show DATE & TIME field in Ticket Display
# This will affect: Checkout Summary, Print Ticket, and Print All pages

set -e

FRONTEND_FILE="frontend/src/components/common/AttendeeTicket/index.tsx"
BACKUP_FILE="frontend/src/components/common/AttendeeTicket/index.tsx.backup"

echo "================================================"
echo "Enabling Date & Time in Ticket Display"
echo "================================================"

# Check if file exists
if [ ! -f "$FRONTEND_FILE" ]; then
    echo "❌ Error: File not found: $FRONTEND_FILE"
    exit 1
fi

# Check if backup exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "⚠️  No backup file found. Date & Time is already enabled or was never disabled."
    exit 0
fi

# Check if already enabled (no false && marker found)
if ! grep -q "{false && <div className={classes\.detailRow}>" "$FRONTEND_FILE"; then
    echo "⚠️  Date & Time is already enabled!"
    exit 0
fi

echo "🔧 Restoring frontend code from backup..."

# Restore from backup
cp "$BACKUP_FILE" "$FRONTEND_FILE"

echo "✅ Date & Time field has been enabled!"
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
echo "💡 To disable again, run: ./disable-event-datetime.sh"
echo "================================================"
