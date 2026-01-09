# Event Date & Time Toggle Scripts

## Overview

This directory contains two shell scripts to toggle the visibility of the **DATE & TIME** field on ticket displays across multiple pages.

## Scripts

### 1. `disable-event-datetime.sh`
Hides the Event Date & Time field from ticket displays.

### 2. `enable-event-datetime.sh`
Shows the Event Date & Time field on ticket displays.

## Usage

### To Hide Event Date & Time:

```bash
./disable-event-datetime.sh
```

### To Show Event Date & Time:

```bash
./enable-event-datetime.sh
```

## Important Notes

1. **Backup**: The first time you run `disable-event-datetime.sh`, a backup file will be created at:
   ```
   frontend/src/components/common/AttendeeTicket/index.tsx.backup
   ```

2. **Rebuild Required**: After running either script, you need to rebuild the frontend and restart Docker:
   ```bash
   # Rebuild frontend
   cd frontend && npm run build

   # Restart Docker containers
   cd docker/all-in-one && docker compose restart
   ```

3. **Affected Pages**: These scripts modify the ticket display shown on:
   - **Checkout Summary**: `/checkout/{eventId}/{orderShortId}/summary`
   - **Print Ticket**: `/product/{eventId}/{attendeeId}`
   - **Print All Tickets**: `/order/{eventId}/{orderShortId}/print`
   - Example URL: `https://conference.devz.nida.ac.th/checkout/17/o_XXXXX/summary`

## What Gets Modified

The scripts modify the `AttendeeTicket` component in:
```
frontend/src/components/common/AttendeeTicket/index.tsx
```

Specifically, they enable/disable the date & time display section that shows:
- **Label**: "Date & Time"
- **Value**: Event date and time with timezone (e.g., "Jan 12, 2026 9:00am")

## Example

**Before (Enabled)**:
```
Ticket Card
┌────────────────────────────────────┐
│ NIC - NIDA Conference 2026         │
│ Free                                │
├────────────────────────────────────┤
│ DATE & TIME                         │
│ Jan 12, 2026 9:00am                 │
│                                     │
│ ORGANIZER                           │
│ National Institute (NIDA)           │
│                                     │
│ LOCATION                            │
│ 148 Seri Thai Rd, Bangkok          │
│                                     │
│ TICKET TYPE                         │
│ Registration for Day 2              │
├────────────────────────────────────┤
│         [QR CODE]                   │
└────────────────────────────────────┘
```

**After (Disabled)**:
```
Ticket Card
┌────────────────────────────────────┐
│ NIC - NIDA Conference 2026         │
│ Free                                │
├────────────────────────────────────┤
│ ORGANIZER                           │
│ National Institute (NIDA)           │
│                                     │
│ LOCATION                            │
│ 148 Seri Thai Rd, Bangkok          │
│                                     │
│ TICKET TYPE                         │
│ Registration for Day 2              │
├────────────────────────────────────┤
│         [QR CODE]                   │
└────────────────────────────────────┘
```

## Troubleshooting

### Script won't run (Permission Denied)
```bash
chmod +x disable-event-datetime.sh enable-event-datetime.sh
```

### Changes not appearing
Make sure to rebuild and restart:
```bash
cd frontend && npm run build
cd ../docker/all-in-one && docker compose restart
```

### Restore original file
If something goes wrong, you can restore from backup:
```bash
cp frontend/src/components/common/AttendeeTicket/index.tsx.backup \
   frontend/src/components/common/AttendeeTicket/index.tsx
```

## Technical Details

- **Method**: Uses conditional rendering (`{false && ...}`) to disable the component
- **Lines Modified**: Lines 74-79 in AttendeeTicket/index.tsx
- **Valid JSX**: The modification maintains valid TypeScript/JSX syntax
- **Safe**: Original code is preserved in backup file
- **Reversible**: Can toggle between enabled/disabled states anytime

## Support

If you encounter any issues, please check:
1. You're running scripts from the project root directory
2. The frontend file exists and hasn't been moved
3. You have write permissions to modify files
4. Docker containers are running

---

**Created**: 2026-01-09
**Location**: `/home/user/Hi.Events/`
